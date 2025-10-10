import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  

  var currentIndex = 0.obs;
  
  // Badge count for orders tab
  var ordersBadgeCount = 0.obs;
  
  // Track if user can go back from current tab
  var canPop = false.obs;

  final List<String> tabRoutes = [
    '/home',
    '/create-order', 
    '/orders',
    '/profile',
  ];

  // Tab titles for display
  final List<String> tabTitles = [
    'Home',
    'Create Order',
    'Orders', 
    'Profile',
  ];

  // Tab icons
  final List<IconData> tabIcons = [
    Icons.home,
    Icons.add_circle_outline,
    Icons.shopping_bag,
    Icons.person,
  ];
  
  @override
  void onInit() {
    super.onInit();
    _initializeNavigation();
  }


  /// Initialize navigation data
  void _initializeNavigation() {
    // Load initial badge count (you can replace with actual data later)
    _loadOrdersBadgeCount();
  }

  /// Switch to a different tab
  void changeTab(int index) {
    if (index >= 0 && index < tabRoutes.length) {
      currentIndex.value = index;
      
      // Navigate to the tab's route
      // Get.offNamedUntil(tabRoutes[index], (route) => route.isFirst);
    }
  }

  /// Navigate to a specific tab by route name
  void navigateToTab(String routeName) {
    final index = tabRoutes.indexWhere((route) => route == routeName);
    if (index != -1) {
      changeTab(index);
    }
  }

  /// Get the current route based on selected index
  String get currentRoute => tabRoutes[currentIndex.value];

  /// Check if a specific tab is currently active
  bool isTabActive(int index) {
    return currentIndex.value == index;
  }



  /// Load orders badge count (mock for now)
  void _loadOrdersBadgeCount() {
    // TODO: Replace with actual API call to get pending orders count
    ordersBadgeCount.value = 3; // Mock data - 3 new order updates
  }

  /// Update orders badge count
  void updateOrdersBadge(int count) {
    ordersBadgeCount.value = count;
  }

  /// Clear orders badge (when user views orders)
  void clearOrdersBadge() {
    ordersBadgeCount.value = 0;
  }

  /// Check if orders tab has badge
  bool get hasOrdersBadge => ordersBadgeCount.value > 0;


  /// Go back to previous screen if possible, otherwise go to home
  void handleBackButton() {
    if (canPop.value) {
      Get.back();
    } else {
      changeTab(0); // Go to home tab
    }
  }

  /// Refresh all tab data
  Future<void> refreshAllTabs() async {
    // Refresh orders badge
    _loadOrdersBadgeCount();
    
    // You can add refresh logic for other tabs here
    // For example: trigger home data refresh, profile data refresh, etc.
  }

  /// Navigate to create order with pre-selected service
  void navigateToCreateOrder({String? serviceType}) {
    changeTab(1); // Switch to create order tab
    
    // You can pass service type as argument if needed
    if (serviceType != null) {
      // This will be handled in the CreateOrderScreen
      Get.toNamed('/create-order', arguments: {'serviceType': serviceType});
    }
  }

  /// Navigate to orders with specific filter
  void navigateToOrders({String? filter}) {
    changeTab(2); // Switch to orders tab
    clearOrdersBadge(); // Clear badge when user manually goes to orders
    
    if (filter != null) {
      // This will be handled in the OrdersScreen
      Get.toNamed('/orders', arguments: {'filter': filter});
    }
  }


  @override
  void onClose() {
    // Clean up any listeners or streams
    super.onClose();
  }
}