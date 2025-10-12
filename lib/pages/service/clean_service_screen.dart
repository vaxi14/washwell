import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CleanServiceScreen extends StatelessWidget {
  const CleanServiceScreen({super.key});

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
                'Clean Service',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade700, Colors.purpleAccent.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.cleaning_services,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          //service Content
          SliverList(
            delegate: SliverChildListDelegate([
              _buildSection(
                title: 'Premium Cleaning Service',
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Experience our premium cleaning service for delicate, formal, and special care items. '
                      'We use specialized cleaning techniques, premium solutions, and expert stain removal '
                      'to restore your clothes to their original beauty while preserving fabric integrity.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Our Premium Cleaning Process:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    _ProcessStep(step: '1. Detailed Inspection', description: 'Assess fabric, stains, and special needs'),
                    _ProcessStep(step: '2. Stain Pre-treatment', description: 'Professional stain removal solutions'),
                    _ProcessStep(step: '3. Specialized Cleaning', description: 'Fabric-specific cleaning methods'),
                    _ProcessStep(step: '4. Quality Enhancement', description: 'Fabric softeners and treatments'),
                    _ProcessStep(step: '5. Premium Finishing', description: 'Expert ironing and packaging'),
                  ],
                ),
              ),
              _buildSection(
                title: 'Premium Pricing',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPricingTable(
                      title: 'Premium Item Cleaning',
                      items: [
                        _PricingItem(item: 'Shirt/Blouse', price: '₹40'),
                        _PricingItem(item: 'Pants/Trousers', price: '₹50'),
                        _PricingItem(item: 'Dress', price: '₹70'),
                        _PricingItem(item: 'Kurta', price: '₹60'),
                        _PricingItem(item: 'Sweater/Jacket', price: '₹80'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildPricingTable(
                      title: 'Special Items Cleaning',
                      items: [
                        _PricingItem(item: 'Saree', price: '₹100'),
                        _PricingItem(item: 'Suit/Blazer', price: '₹150'),
                        _PricingItem(item: 'Leather Jacket', price: '₹200'),
                        _PricingItem(item: 'Wedding Dress', price: '₹300'),
                        _PricingItem(item: 'Silk Dress', price: '₹120'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildPricingTable(
                      title: 'Additional Services',
                      items: [
                        _PricingItem(item: 'Stain Treatment', price: '+₹20-50'),
                        _PricingItem(item: 'Fabric Protection', price: '+₹30'),
                        _PricingItem(item: 'Premium Packaging', price: '+₹25'),
                        _PricingItem(item: 'Emergency Service', price: '+50%'),
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
                title: 'Specialized Cleaning Types',
                child: Column(
                  children: [
                    _buildCleaningType(
                      'Stain Removal',
                      'Professional treatment for tough stains',
                      'Wine, ink, oil, grease, blood stains',
                      Icons.clean_hands,
                      Colors.red,
                    ),
                    const SizedBox(height: 16),
                    _buildCleaningType(
                      'Delicate Care',
                      'Gentle cleaning for sensitive fabrics',
                      'Silk, wool, lace, embroidery',
                      Icons.favorite_border,
                      Colors.pink,
                    ),
                    const SizedBox(height: 16),
                    _buildCleaningType(
                      'Formal Wear',
                      'Expert care for formal clothing',
                      'Suits, blazers, dresses, traditional wear',
                      Icons.celebration,
                      Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildCleaningType(
                      'Special Items',
                      'Cleaning for non-regular items',
                      'Shoes, bags, curtains, accessories',
                      Icons.style,
                      Colors.orange,
                    ),
                  ],
                ),
              ),

              _buildSection(
                title: 'Service Options',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOptionItem('Cleaning Intensity', ['Standard', 'Deep Clean', 'Premium']),
                    const SizedBox(height: 16),
                    _buildOptionItem('Stain Treatment', ['Basic', 'Advanced', 'Premium']),
                    const SizedBox(height: 16),
                    _buildOptionItem('Fabric Protection', ['None', 'Water Repellent', 'Stain Guard']),
                    const SizedBox(height: 16),
                    _buildOptionItem('Packaging', ['Standard', 'Premium', 'Gift Wrap']),
                    const SizedBox(height: 16),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Special Instructions & Stains',
                        hintText: 'Describe stains, delicate areas, special care needed...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              _buildSection(
                title: 'Turnaround Time',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTimeOption('Standard Cleaning', '48-72 hours', '₹0'),
                    const SizedBox(height: 12),
                    _buildTimeOption('Express Service', '24 hours', '+40%'),
                    const SizedBox(height: 12),
                    _buildTimeOption('Emergency Service', '12 hours', '+50%'),
                    const SizedBox(height: 12),
                    _buildTimeOption('Premium Deluxe', '5-7 days', 'Special Quote'),
                  ],
                ),
              ),

              _buildSection(
                title: 'Stain Types We Specialize In',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildStainChip('Food Stains'),
                    _buildStainChip('Wine/Coffee'),
                    _buildStainChip('Ink/Pen'),
                    _buildStainChip('Oil/Grease'),
                    _buildStainChip('Blood'),
                    _buildStainChip('Grass/Mud'),
                    _buildStainChip('Makeup'),
                    _buildStainChip('Perspiration'),
                    _buildStainChip('Old Stains'),
                    _buildStainChip('Unknown Stains'),
                  ],
                ),
              ),

              _buildSection(
                title: 'Why Choose Our Clean Service?',
                child: Column(
                  children: [
                    _buildBenefitItem('Expert Stain Removal', Icons.cleaning_services),
                    _buildBenefitItem('Premium Solutions', Icons.eco),
                    _buildBenefitItem('Fabric Preservation', Icons.favorite),
                    _buildBenefitItem('Specialized Equipment', Icons.precision_manufacturing),
                    _buildBenefitItem('Quality Guarantee', Icons.verified_user),
                  ],
                ),
              ),

              _buildSection(
                title: 'Frequently Asked Questions',
                child: Column(
                  children: [
                    _buildFAQItem(
                      'What\'s the difference between clean and wash service?',
                      'Clean service uses specialized techniques for delicate, formal, and stained items with premium solutions, while wash service is for regular everyday laundry.',
                    ),
                    _buildFAQItem(
                      'Can you remove old stubborn stains?',
                      'Yes, we specialize in removing even old and stubborn stains using professional-grade solutions and techniques.',
                    ),
                    _buildFAQItem(
                      'How do you handle expensive formal wear?',
                      'We use gentle cleaning methods, hand-finishing, and premium packaging to preserve your expensive formal wear.',
                    ),
                    _buildFAQItem(
                      'Do you offer fabric protection services?',
                      'Yes, we offer water repellent and stain guard treatments to protect your clothes from future stains.',
                    ),
                    _buildFAQItem(
                      'What items require clean service vs regular wash?',
                      'Silk, wool, formal wear, wedding dresses, leather, and heavily stained items should use our clean service for best results.',
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
          Get.toNamed('/create-order', arguments: {'serviceType': 'clean'});
        },
        backgroundColor: Colors.purple,
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

  Widget _buildCleaningType(String type, String description, String handles, IconData icon, Color color) {
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
                  type,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                Text(
                  'Handles: $handles',
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
            backgroundColor: Colors.purple.shade50,
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
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
        ],
      ),
    );
  }

  Widget _buildStainChip(String stain) {
    return Chip(
      label: Text(stain),
      backgroundColor: Colors.purple.shade50,
      side: BorderSide(color: Colors.purple.shade200),
    );
  }

  Widget _buildBenefitItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple, size: 20),
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
          Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
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