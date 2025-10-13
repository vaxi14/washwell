import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  var currentIndex = 0.obs;
  var ordersBadgeCount = 0.obs;
  var canPop = false.obs;

  final List<String> tabRoutes = [
    '/home',
    '/create-order', 
    '/orders',
    '/profile',
  ];

  final List<String> tabTitles = [
    'Home',
    'Create Order',
    'Orders', 
    'Profile',
  ];

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

  void _initializeNavigation() {
    _loadOrdersBadgeCount();
  }

  // FIXED: Updated changeTab method for proper navigation
  void changeTab(int index) {
    if (index >= 0 && index < tabRoutes.length) {
      currentIndex.value = index;
      
      // For Create Order tab, navigate to the create-order screen
      if (index == 1) { // Create Order tab index
        Get.offNamedUntil('/create-order', (route) => route.isFirst);
      } 
      // For other tabs, use the existing navigation
      else {
        Get.offNamedUntil(tabRoutes[index], (route) => route.isFirst);
      }
    }
  }

  void navigateToTab(String routeName) {
    final index = tabRoutes.indexWhere((route) => route == routeName);
    if (index != -1) {
      changeTab(index);
    }
  }

  String get currentRoute => tabRoutes[currentIndex.value];

  bool isTabActive(int index) {
    return currentIndex.value == index;
  }

  void _loadOrdersBadgeCount() {
    ordersBadgeCount.value = 3;
  }

  void updateOrdersBadge(int count) {
    ordersBadgeCount.value = count;
  }

  void clearOrdersBadge() {
    ordersBadgeCount.value = 0;
  }

  bool get hasOrdersBadge => ordersBadgeCount.value > 0;

  void handleBackButton() {
    if (canPop.value) {
      Get.back();
    } else {
      changeTab(0); 
    }
  }

  Future<void> refreshAllTabs() async {
    _loadOrdersBadgeCount();
  }

  // FIXED: Updated navigateToCreateOrder method
  void navigateToCreateOrder({String? serviceType}) {
    // Set the current index to Create Order tab
    currentIndex.value = 1;
    
    // Navigate to create-order screen with optional service type
    if (serviceType != null) {
      Get.offNamedUntil('/create-order', (route) => route.isFirst, arguments: {'serviceType': serviceType});
    } else {
      Get.offNamedUntil('/create-order', (route) => route.isFirst);
    }
  }

  void navigateToOrders({String? filter}) {
    currentIndex.value = 2;
    clearOrdersBadge(); 
    
    if (filter != null) {
      Get.offNamedUntil('/orders', (route) => route.isFirst, arguments: {'filter': filter});
    } else {
      Get.offNamedUntil('/orders', (route) => route.isFirst);
    }
  }

  // NEW: Method to navigate back to home tab
  void navigateToHome() {
    currentIndex.value = 0;
    Get.offNamedUntil('/home', (route) => route.isFirst);
  }

  // NEW: Method to navigate to profile tab
  void navigateToProfile() {
    currentIndex.value = 3;
    Get.offNamedUntil('/profile', (route) => route.isFirst);
  }

  @override
  void onClose() {
    super.onClose();
  }
}