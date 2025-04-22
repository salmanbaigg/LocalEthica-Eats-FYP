import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Groceries',
    'Beverages',
    'Coffee',
    'Restaurant',
    'Dairy Products',
    'Snacks',
  ];

  final List<Map<String, String>> brandData = [
    {
      'brand': 'Nestle',
      'category': 'Dairy Products',
      'alternatives': 'Nurpur, Prema, Fruitien, Qarshi, Klassno, Pakola',
      'status': 'Boycotted',
      'origin': 'Switzerland',
    },
    {
      'brand': 'Olper’s',
      'category': 'Dairy Products',
      'alternatives': 'Nurpur, Prema',
      'status': 'Boycotted',
      'origin': 'Pakistan',
    },
    {
      'brand': 'Pepsi',
      'category': 'Beverages',
      'alternatives': 'Gourmet, Cola Next, Pakola',
      'status': 'Boycotted',
      'origin': 'USA',
    },
    {
      'brand': 'Tapal',
      'category': 'Coffee',
      'alternatives': '',
      'status': 'Not Boycotted',
      'origin': 'Pakistan',
    },
    {
      'brand': 'Nurpur',
      'category': 'Dairy Products',
      'alternatives': '',
      'status': 'Not Boycotted',
      'origin': 'Pakistan',
    },
    {
      'brand': 'Prema',
      'category': 'Dairy Products',
      'alternatives': '',
      'status': 'Not Boycotted',
      'origin': 'Pakistan',
    },
    {
      'brand': 'Fruitien',
      'category': 'Beverages',
      'alternatives': '',
      'status': 'Not Boycotted',
      'origin': 'Pakistan',
    },
    {
      'brand': 'Qarshi',
      'category': 'Beverages',
      'alternatives': '',
      'status': 'Not Boycotted',
      'origin': 'Pakistan',
    },
    {
      'brand': 'Gourmet',
      'category': 'Beverages',
      'alternatives': '',
      'status': 'Not Boycotted',
      'origin': 'Pakistan',
    },
    {
      'brand': 'Young’s',
      'category': 'Groceries',
      'alternatives': '',
      'status': 'Not Boycotted',
      'origin': 'Pakistan',
    },
    // Add more with proper category tags
  ];

  @override
  Widget build(BuildContext context) {
    String query = _searchController.text.toLowerCase();

    final filteredBrands = brandData.where((brand) {
      final matchesSearch = brand['brand']!.toLowerCase().contains(query);
      final matchesCategory =
          selectedCategory == 'All' || brand['category'] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Boycott Brand Info'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Search brand...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Category filter
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories
                  .map((cat) =>
                      DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Filter by category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Results
            Expanded(
              child: filteredBrands.isEmpty
                  ? const Center(child: Text('No matching brands found.'))
                  : ListView.builder(
                      itemCount: filteredBrands.length,
                      itemBuilder: (context, index) {
                        final brand = filteredBrands[index];
                        return Card(
                          color: brand['status'] == 'Boycotted'
                              ? Colors.red[100]
                              : Colors.green[100],
                          child: ListTile(
                            title: Text(brand['brand']!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Category: ${brand['category']}'),
                                Text('Status: ${brand['status']}'),
                                if (brand['alternatives']!.isNotEmpty)
                                  Text('Alternatives: ${brand['alternatives']}'),
                                Text('Origin: ${brand['origin']}'),
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
    );
  }
}
