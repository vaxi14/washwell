import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IronServiceScreen extends StatelessWidget {
  const IronServiceScreen({super.key});

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
                'Iron Service',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade700, Colors.lightGreen.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.iron,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              _buildSection(
                title: 'Professional Iron Service',
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get crisp, wrinkle-free clothes with our professional ironing service. '
                      'We use industrial steam irons and expert techniques to give your clothes '
                      'a fresh-from-the-store finish while maintaining fabric integrity.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Our Ironing Process:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    _ProcessStep(step: '1. Inspection', description: 'Check fabric type and condition'),
                    _ProcessStep(step: '2. Steam Treatment', description: 'Remove stubborn wrinkles with steam'),
                    _ProcessStep(step: '3. Precision Ironing', description: 'Iron with temperature control'),
                    _ProcessStep(step: '4. Quality Check', description: 'Ensure perfect finish'),
                    _ProcessStep(step: '5. Packaging', description: 'Fold or hang as preferred'),
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
                        _PricingItem(item: 'Shirt/T-Shirt', price: '₹15'),
                        _PricingItem(item: 'Pants/Jeans', price: '₹20'),
                        _PricingItem(item: 'Kurta', price: '₹25'),
                        _PricingItem(item: 'Saree', price: '₹40'),
                        _PricingItem(item: 'Dress', price: '₹35'),
                        _PricingItem(item: 'Suit/Blazer', price: '₹60'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildPricingTable(
                      title: 'Bulk Discounts',
                      items: [
                        _PricingItem(item: '5-9 items', price: '10% off'),
                        _PricingItem(item: '10+ items', price: '15% off'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildPricingTable(
                      title: 'Premium Finishing',
                      items: [
                        _PricingItem(item: 'Steam Ironing', price: '+₹5/item'),
                        _PricingItem(item: 'Premium Folding', price: '+₹3/item'),
                        _PricingItem(item: 'Hanger Delivery', price: '+₹10/order'),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Text(
                      '* Minimum charge: ₹50 per order',
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
                    _buildOptionItem('Ironing Type', ['Normal', 'Steam', 'Premium']),
                    const SizedBox(height: 16),
                    _buildOptionItem('Fabric Type', ['Cotton', 'Linen', 'Silk', 'Synthetic', 'Wool']),
                    const SizedBox(height: 16),
                    _buildOptionItem('Packaging', ['Standard Fold', 'Premium Fold', 'On Hangers']),
                    const SizedBox(height: 16),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Special Instructions',
                        hintText: 'Specific folding instructions, delicate areas...',
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
                    _buildTimeOption('Standard Service', '12-24 hours', '₹0'),
                    const SizedBox(height: 12),
                    _buildTimeOption('Express Service', '6 hours', '+30%'),
                    const SizedBox(height: 12),
                    _buildTimeOption('Same Day', '4 hours', '+50%'),
                  ],
                ),
              ),

              _buildSection(
                title: 'Fabric Care Guide',
                child: Column(
                  children: [
                    _buildFabricCare('Cotton', 'High heat, steam friendly', Icons.check_circle, Colors.green),
                    _buildFabricCare('Silk', 'Low heat, no steam', Icons.warning_amber, Colors.orange),
                    _buildFabricCare('Linen', 'Medium heat, steam recommended', Icons.check_circle, Colors.green),
                    _buildFabricCare('Synthetic', 'Low heat, no steam', Icons.warning_amber, Colors.orange),
                    _buildFabricCare('Wool', 'Low heat, steam with care', Icons.info, Colors.blue),
                  ],
                ),
              ),

              _buildSection(
                title: 'Why Choose Our Iron Service?',
                child: Column(
                  children: [
                    _buildBenefitItem('Professional Steam Irons', Icons.chat),
                    _buildBenefitItem('Expert Garment Handling', Icons.precision_manufacturing),
                    _buildBenefitItem('Wrinkle-Free Finish', Icons.star),
                    _buildBenefitItem('Fabric-Specific Care', Icons.flag),
                  ],
                ),
              ),

              _buildSection(
                title: 'Frequently Asked Questions',
                child: Column(
                  children: [
                    _buildFAQItem(
                      'How do you handle silk and delicate fabrics?',
                      'We use low heat settings and protective cloths for delicate fabrics like silk to prevent damage.',
                    ),
                    _buildFAQItem(
                      'Do you offer hanging delivery?',
                      'Yes, we offer hanger delivery for formal wear and delicate items at an additional charge.',
                    ),
                    _buildFAQItem(
                      'What\'s the difference between normal and premium ironing?',
                      'Premium ironing includes steam treatment, special attention to collars/cuffs, and premium folding.',
                    ),
                    _buildFAQItem(
                      'Can you remove stubborn wrinkles from stored clothes?',
                      'Yes, our steam treatment effectively removes even stubborn wrinkles from long-stored garments.',
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
          Get.toNamed('/create-order', arguments: {'serviceType': 'iron'});
        },
        backgroundColor: Colors.green,
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
            backgroundColor: Colors.green.shade50,
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
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
        ],
      ),
    );
  }

  Widget _buildFabricCare(String fabric, String care, IconData icon, Color color) {
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
                Text(care, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
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
          Icon(icon, color: Colors.green, size: 20),
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
          Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
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