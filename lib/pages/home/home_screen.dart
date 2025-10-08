import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(),
              
              const SizedBox(height: 20),
              
              // Track Order Section
              _buildTrackOrderSection(),
              
              const SizedBox(height: 25),
              
              // Services Section
              _buildServicesSection(),
              
              const SizedBox(height: 25),
              
              // Quick Stats Section
              _buildQuickStatsSection(),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      
      // Floating Promo Button (will appear on scroll)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Will implement promo bottom sheet later
        },
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.local_offer, color: Colors.white),
        label: const Text(
          'Special Offer',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Header with Welcome and Notification
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello! 👋',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Welcome to LaundryLens',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // Will implement notifications later
            },
            icon: Badge(
              // Will make dynamic later
              label: const Text('3'),
              child: const Icon(
                Icons.notifications_none,
                size: 28,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Track Order Section
  Widget _buildTrackOrderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          // Get.toNamed('/track-order');
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.track_changes,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Track Your Order',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Real-time updates on your laundry',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Services Section
  Widget _buildServicesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _buildServiceCard('Wash', Icons.local_laundry_service, Colors.blue),
              _buildServiceCard('Iron', Icons.iron, Colors.green),
              _buildServiceCard('Dry', Icons.ac_unit, Colors.orange),
              _buildServiceCard('Clean', Icons.cleaning_services, Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  // Individual Service Card
  Widget _buildServiceCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/$title'.toLowerCase());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'From ₹50',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Quick Stats Section
  Widget _buildQuickStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Laundry Stats',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Orders', '5', Icons.shopping_bag),
                _buildStatItem('Hours Saved', '12', Icons.access_time),
                _buildStatItem('Items Cleaned', '45', Icons.check_circle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Individual Stat Item
  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 24,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}