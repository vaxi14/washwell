import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DryServiceScreen extends StatelessWidget {
  const DryServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Dry Service',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade700, Colors.orangeAccent.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.ac_unit, 
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Service Content
          SliverList(
            delegate: SliverChildListDelegate([
              _buildSection(
                title: 'Professional Drying Service',
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get perfectly dried clothes with our professional drying service. '
                      'We use temperature-controlled dryers and multiple drying methods '
                      'to ensure your clothes are dried perfectly while maintaining fabric quality and softness.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Our Drying Process:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    _ProcessStep(step: '1. Moisture Check', description: 'Assess fabric and moisture level'),
                    _ProcessStep(step: '2. Method Selection', description: 'Choose optimal drying method'),
                    _ProcessStep(step: '3. Controlled Drying', description: 'Temperature and time optimization'),
                    _ProcessStep(step: '4. Cooling Phase', description: 'Gentle cooling to set fabrics'),
                    _ProcessStep(step: '5. Quality Inspection', description: 'Check for perfect dryness'),
                  ],
                ),
              ),

              // Pricing Section
              _buildSection(
                title: 'Pricing',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPricingTable(
                      title: 'Per Item Pricing',
                      items: [
                        _PricingItem(item: 'Shirt/T-Shirt', price: '₹12'),
                        _PricingItem(item: 'Pants/Jeans', price: '₹18'),
                        _PricingItem(item: 'Sweater/Jacket', price: '₹25'),
                        _PricingItem(item: 'Bed Sheet', price: '₹30'),
                        _PricingItem(item: 'Towel', price: '₹15'),
                        _PricingItem(item: 'Saree/Dress', price: '₹20'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildPricingTable(
                      title: 'Weight-based Pricing',
                      items: [
                        _PricingItem(item: 'Standard Drying (per kg)', price: '₹50/kg'),
                        _PricingItem(item: 'Premium Drying (per kg)', price: '₹70/kg'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildPricingTable(
                      title: 'Bulk Drying Discounts',
                      items: [
                        _PricingItem(item: '3-5 kg', price: '5% off'),
                        _PricingItem(item: '5+ kg', price: '10% off'),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Text(
                      '* Minimum charge: ₹40 per order',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                  ],
                ),
              ),
              _buildSection(
                title: 'Drying Methods',
                child: Column(
                  children: [
                    _buildDryingMethod(
                      'Machine Dry',
                      'Fast, efficient drying for regular fabrics',
                      'Ideal for: Cotton, Linen, Denim',
                      Icons.local_laundry_service,
                      Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    _buildDryingMethod(
                      'Air Dry',
                      'Gentle, natural drying for delicate items',
                      'Ideal for: Silk, Wool, Lace',
                      Icons.air,
                      Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildDryingMethod(
                      'Tumble Dry',
                      'Professional even drying with softness',
                      'Ideal for: Mixed fabrics, Regular wear',
                      Icons.repeat,
                      Colors.green,
                    ),
                  ],
                ),
              ),

              _buildSection(
                title: 'Service Options',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOptionItem('Drying Method', ['Machine Dry', 'Air Dry', 'Tumble Dry']),
                    const SizedBox(height: 16),
                    _buildOptionItem('Temperature', ['Low', 'Medium', 'High']),
                    const SizedBox(height: 16),
                    _buildOptionItem('Fabric Type', ['Cotton', 'Synthetic', 'Wool', 'Silk', 'Mixed']),
                    const SizedBox(height: 16),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Special Instructions',
                        hintText: 'Specific drying preferences, delicate items...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),

              _buildSection(
                title: 'Turnaround Time',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTimeOption('Standard Drying', '6-12 hours', '₹0'),
                    const SizedBox(height: 12),
                    _buildTimeOption('Express Drying', '3 hours', '+25%'),
                    const SizedBox(height: 12),
                    _buildTimeOption('Same Day', '2 hours', '+40%'),
                  ],
                ),
              ),

              _buildSection(
                title: 'Fabric Safety Guide',
                child: Column(
                  children: [
                    _buildSafetyItem('Cotton & Linen', 'High heat safe', Icons.check_circle, Colors.green),
                    _buildSafetyItem('Synthetic', 'Medium heat recommended', Icons.info, Colors.blue),
                    _buildSafetyItem('Wool', 'Low heat only', Icons.warning_amber, Colors.orange),
                    _buildSafetyItem('Silk & Delicate', 'Air dry recommended', Icons.warning, Colors.red),
                  ],
                ),
              ),

              _buildSection(
                title: 'Why Choose Our Dry Service?',
                child: Column(
                  children: [
                    _buildBenefitItem('Temperature Controlled', Icons.thermostat),
                    _buildBenefitItem('Fabric Protection', Icons.security),
                    _buildBenefitItem('Energy Efficient', Icons.bolt),
                    _buildBenefitItem('Softness Guaranteed', Icons.soap),
                  ],
                ),
              ),

              _buildSection(
                title: 'Frequently Asked Questions',
                child: Column(
                  children: [
                    _buildFAQItem(
                      'What\'s the difference between air dry and machine dry?',
                      'Air dry uses natural air circulation (gentle), while machine dry uses controlled heat (faster).',
                    ),
                    _buildFAQItem(
                      'How do you prevent clothes from shrinking?',
                      'We use temperature-controlled drying and follow fabric-specific guidelines to prevent shrinkage.',
                    ),
                    _buildFAQItem(
                      'Can you dry shoes and special items?',
                      'Yes, we can dry shoes and special items using appropriate methods (additional charges may apply).',
                    ),
                    _buildFAQItem(
                      'Do you add fabric softener during drying?',
                      'We can add fabric softener upon request to maintain fabric softness.',
                    ),
                    _buildFAQItem(
                      'How do you handle wet clothes from washing?',
                      'We ensure proper moisture balance before drying to optimize the process.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100), 
            ]),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed('/create-order', arguments: {'serviceType': 'dry'});
        },
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
        label: const Text(
          'Create Order',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildPricingTable({required String title, required List<_PricingItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.item, style: const TextStyle(fontSize: 15)),
              Text(item.price, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildDryingMethod(String method, String description, String idealFor, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                Text(
                  idealFor,
                  style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) => Chip(
            label: Text(option),
            backgroundColor: Colors.orange.shade50,
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildTimeOption(String service, String time, String price) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(service, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(time, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
        ],
      ),
    );
  }

  Widget _buildSafetyItem(String fabric, String safety, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fabric, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(safety, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 20),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.4),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class _ProcessStep extends StatelessWidget {
  final String step;
  final String description;

  const _ProcessStep({required this.step, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '$step: ', style: const TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PricingItem {
  final String item;
  final String price;

  _PricingItem({required this.item, required this.price});
}