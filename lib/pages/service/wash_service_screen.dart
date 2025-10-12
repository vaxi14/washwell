import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WashServiceScreen extends StatelessWidget {
  const WashServiceScreen({super.key});

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
                'Wash Service',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.lightBlue.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.local_laundry_service,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              _buildSection(
                title: 'Professional Wash Service',
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get your clothes professionally washed with care and precision. '
                      'We use high-quality detergents and follow strict hygiene standards '
                      'to ensure your clothes come out fresh and clean every time.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Our Process:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    _ProcessStep(step: '1. Sorting', description: 'Separate by color and fabric type'),
                    _ProcessStep(step: '2. Washing', description: 'Professional machines with quality detergents'),
                    _ProcessStep(step: '3. Drying', description: 'Optimal temperature for each fabric'),
                    _ProcessStep(step: '4. Folding', description: 'Neatly folded and packaged'),
                  ],
                ),
              ),
              _buildSection(
                title: 'Pricing',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
  
                    _buildPricingTable(
                      title: 'Per Item Pricing',
                      items: [
                        _PricingItem(item: 'Shirt/T-Shirt', price: '₹20'),
                        _PricingItem(item: 'Pants/Jeans', price: '₹30'),
                        _PricingItem(item: 'Kurta/Pajama', price: '₹40'),
                        _PricingItem(item: 'Sweater/Jacket', price: '₹50'),
                        _PricingItem(item: 'Bed Sheet', price: '₹60'),
                        _PricingItem(item: 'Towel', price: '₹25'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildPricingTable(
                      title: 'Weight-based Pricing',
                      items: [
                        _PricingItem(item: 'Standard (per kg)', price: '₹80/kg'),
                        _PricingItem(item: 'Premium (per kg)', price: '₹120/kg'),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Text(
                      '* Minimum charge: ₹100 per order',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                  ],
                ),
              ),

              _buildSection(
                title: 'Service Options',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOptionItem('Detergent Type', ['Regular', 'Mild', 'Scented', 'Hypoallergenic']),
                    const SizedBox(height: 16),
                    _buildOptionItem('Water Temperature', ['Cold', 'Warm', 'Hot']),
                    const SizedBox(height: 16),
                    _buildOptionItem('Fabric Softener', ['Yes', 'No']),
                    const SizedBox(height: 16),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Special Instructions',
                        hintText: 'Any specific requirements...',
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
                    _buildTimeOption('Standard Service', '24-48 hours', '₹0'),
                    const SizedBox(height: 12),
                    _buildTimeOption('Express Service', '12 hours', '+20%'),
                    const SizedBox(height: 12),
                    _buildTimeOption('Super Express', '6 hours', '+50%'),
                  ],
                ),
              ),

              _buildSection(
                title: 'Why Choose Our Wash Service?',
                child: Column(
                  children: [
                    _buildBenefitItem('Quality Detergents', Icons.clean_hands),
                    _buildBenefitItem('Expert Handling', Icons.engineering),
                    _buildBenefitItem('Hygienic Process', Icons.health_and_safety),
                    _buildBenefitItem('Eco-Friendly', Icons.eco),
                  ],
                ),
              ),

              _buildSection(
                title: 'Frequently Asked Questions',
                child: Column(
                  children: [
                    _buildFAQItem(
                      'How do you handle delicate fabrics?',
                      'We use gentle cycles and mild detergents for delicate items like silk and wool.',
                    ),
                    _buildFAQItem(
                      'What\'s your stain removal process?',
                      'We pre-treat stains with specialized solutions before washing.',
                    ),
                    _buildFAQItem(
                      'Can I provide my own detergent?',
                      'Yes, you can provide your preferred detergent at no extra cost.',
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
          Get.toNamed('/create-order', arguments: {'serviceType': 'wash'});
        },
        backgroundColor: Colors.blue,
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
            backgroundColor: Colors.blue.shade50,
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
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
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
          Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
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