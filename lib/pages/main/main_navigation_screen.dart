import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/main_navigation_controller.dart';
import '../home/home_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  MainNavigationScreen({super.key});

  final MainNavigationController controller = Get.put(MainNavigationController());

  final List<Widget> _screens = [
    HomeScreen(),           // Index 0
    Container(),            // Index 1 - Create Order (placeholder)
    Container(),            // Index 2 - Orders (placeholder)  
    Container(),            // Index 3 - Profile (placeholder)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: _screens,
      )),
      
      bottomNavigationBar: Obx(() => _buildBottomNavigationBar()),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: controller.currentIndex.value,
      onTap: (index) => controller.changeTab(index),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey[600],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outlined),
          activeIcon: Icon(Icons.add_circle),
          label: 'Create Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          activeIcon: Icon(Icons.shopping_bag),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}