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

  void changeTab(int index) {
    if (index >= 0 && index < tabRoutes.length) {
      currentIndex.value = index;
      
      // Get.offNamedUntil(tabRoutes[index], (route) => route.isFirst);
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
    // TODO: Replace with actual API call to get pending orders count
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
    // Refresh orders badge
    _loadOrdersBadgeCount();

  }

  void navigateToCreateOrder({String? serviceType}) {
    changeTab(1); 
    if (serviceType != null) {
      Get.toNamed('/create-order', arguments: {'serviceType': serviceType});
    }
  }

  void navigateToOrders({String? filter}) {
    changeTab(2);
    clearOrdersBadge(); 
    
    if (filter != null) {
      Get.toNamed('/orders', arguments: {'filter': filter});
    }
  }


  @override
  void onClose() {
    super.onClose();
  }
}