
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  var currentIndex = 0.obs;
  var ordersBadgeCount = 0.obs;
  var canPop = false.obs;

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
    if (index >= 0 && index < 4) {
      currentIndex.value = index;
    }
  }

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

  @override
  void onClose() {
    super.onClose();
  }
}