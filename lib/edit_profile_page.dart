import 'package:flutter/material.dart';
import 'api/api_service.dart'; // Import ApiService class
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isSaving = false;
  bool isLoading = false;

  final _storage = FlutterSecureStorage();
  String? token;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  // Load the token asynchronously
  Future<void> loadToken() async {
    setState(() {
      isLoading = true;
    });

    token = await _storage.read(key: 'auth_token');
    print('Token: $token');  // Debugging line to check token retrieval

    if (token != null) {
      loadInitialData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No authentication token found')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  // Load user profile data using the token
  void loadInitialData() async {
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No authentication token found')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final data = await ApiService().getUserProfile(token!); // Create an instance and call method
      print('Profile data: $data');  // Debugging line to check profile data
      setState(() {
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Save profile data
  Future<void> saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isSaving = true);

      try {
        final success = await ApiService().updateUserProfile( // Create an instance and call method
          nameController.text,
          emailController.text,
          token!,
        );

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated')),
          );
          Navigator.pop(context); // Go back to profile page
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Update failed')),
          );
        }
      } catch (e) {
        print('Error during profile update: $e');  // Log detailed error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred while updating profile: $e')),
        );
      } finally {
        setState(() => isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (val) => val!.isEmpty ? 'Enter name' : null,
                enabled: !isSaving,  // Disable fields while saving
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (val) =>
                    val!.contains('@') ? null : 'Enter valid email',
                enabled: !isSaving,  // Disable fields while saving
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isSaving ? null : saveProfile,
                child: isSaving
                    ? const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(width: 8),
                          Text('Saving...'),
                        ],
                      )
                    : const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
