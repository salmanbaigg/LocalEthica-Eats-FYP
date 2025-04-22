import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LocalEthica Eats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Text(
                'Welcome back!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Discover local and ethical food choices',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              
              // Quick Actions Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildActionCard(
                    context,
                    icon: Icons.qr_code_scanner,
                    title: 'Scan Product',
                    subtitle: 'Check product ethics',
                    onTap: () => Navigator.pushNamed(context, '/scan'),
                  ),
                  _buildActionCard(
                    context,
                    icon: Icons.list_alt,
                    title: 'Browse Products',
                    subtitle: 'View all products',
                    onTap: () => Navigator.pushNamed(context, '/list'),
                  ),
                  _buildActionCard(
                    context,
                    icon: Icons.auto_awesome,
                    title: 'AI Recommendations',
                    subtitle: 'Get personalized suggestions',
                    onTap: () => Navigator.pushNamed(context, '/ai'),
                  ),
                  _buildActionCard(
                    context,
                    icon: Icons.forum,
                    title: 'Community',
                    subtitle: 'Join discussions',
                    onTap: () => Navigator.pushNamed(context, '/forum'),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Recent Reviews Section
              Text(
                'Recent Reviews',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // TODO: Replace with actual review count
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(right: 16),
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  child: Icon(Icons.person),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'User ${index + 1}',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                const Icon(Icons.star, color: Colors.amber),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Great ethical product!',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
          switch (index) {
            case 1:
              Navigator.pushReplacementNamed(context, '/scan');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/list');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/ai');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
