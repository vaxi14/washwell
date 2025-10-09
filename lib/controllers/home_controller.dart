import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// Service Model
class Service {
  final String name;
  final String icon;
  final String route;
  final double startingPrice;

  Service({
    required this.name,
    required this.icon,
    required this.route,
    required this.startingPrice,
  });
}

class HomeController extends GetxController {
  // ==================== OBSERVABLE VARIABLES ====================
  
  // User greeting based on time of day
  var greeting = 'Hello!'.obs;
  
  // Notification count - will update badge
  var notificationCount = 0.obs;
  
  // Track if user has active orders
  var hasActiveOrders = false.obs;
  
  // Current active order status for display
  var activeOrderStatus = 'No active orders'.obs;
  
  // Loading state for any async operations
  var isLoading = false.obs;

  // ==================== LISTS & DATA ====================
  // List of services we offer - will be displayed in grid
  // FIXED: Use RxList instead of .obs on regular List
  var services = <Service>[].obs;

  // Quick stats data - will be calculated based on user activity
  var totalOrders = 0.obs;
  var hoursSaved = 0.obs;
  var itemsCleaned = 0.obs;

  // ==================== INITIALIZATION ====================
  @override
  void onInit() {
    super.onInit();
    initializeHomeData(); // FIXED: Removed underscore to make it public
  }

  // ==================== CORE METHODS ====================

  /// Initialize all home screen data when app starts
  void initializeHomeData() { // FIXED: Made public by removing underscore
    _setTimeBasedGreeting();
    _loadNotificationCount();
    _checkActiveOrders();
    _calculateQuickStats();
    _initializeServices(); // ADDED: Initialize services list
  }

  /// Initialize services list
  void _initializeServices() {
    services.assignAll([ // FIXED: Use assignAll to update RxList
      Service(
        name: 'Wash',
        icon: '🔄',
        route: '/wash',
        startingPrice: 50.0,
      ),
      Service(
        name: 'Iron',
        icon: '👔',
        route: '/iron',
        startingPrice: 30.0,
      ),
      Service(
        name: 'Dry',
        icon: '🧺',
        route: '/dry',
        startingPrice: 40.0,
      ),
      Service(
        name: 'Clean',
        icon: '✨',
        route: '/clean',
        startingPrice: 80.0,
      ),
    ]);
  }

  /// Set greeting based on current time (Morning, Afternoon, Evening)
  void _setTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      greeting.value = 'Good Morning! 🌅';
    } else if (hour < 17) {
      greeting.value = 'Good Afternoon! ☀️';
    } else {
      greeting.value = 'Good Evening! 🌙';
    }
  }

  /// Load notification count from backend (mock for now)
  void _loadNotificationCount() {
    notificationCount.value = 3; // Mock data
  }

  //checking if user has any active orders
  void _checkActiveOrders() {
    final hasOrders = true; 
    hasActiveOrders.value = hasOrders;
    
    if (hasOrders) {
      activeOrderStatus.value = '1 order in progress • ETA: Today 6 PM';
    } else {
      activeOrderStatus.value = 'No active orders';
    }
  }

  //based on user's order history
  void _calculateQuickStats() {
    totalOrders.value = 5;
    hoursSaved.value = 12;
    itemsCleaned.value = 45;
  }

  //Navigate to track order screen
  void navigateToTrackOrder() {
    if (hasActiveOrders.value) {
      Get.toNamed('/track-order');
    } else {
      Get.snackbar(
        'No Active Orders',
        'You don\'t have any orders to track',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //Navigate to specific service screen
  void navigateToService(String serviceName) {
    final service = services.firstWhere(
      (s) => s.name.toLowerCase() == serviceName.toLowerCase(),
      orElse: () => Service(name: '', icon: '', route: '', startingPrice: 0),
    );
    
    if (service.route.isNotEmpty) {
      Get.toNamed(service.route);
    }
  }

  //Handle notification icon tap
  void onNotificationTap() {
    Get.snackbar(
      'Notifications',
      'You have ${notificationCount.value} notifications',
      snackPosition: SnackPosition.TOP,
    );
    
    // Clear notifications (mock)
    notificationCount.value = 0;
  }

  //promotion bottom sheet
  void showPromotion() {
    final discount = totalOrders.value >= 1 ? '10%' : '25%';
    final message = totalOrders.value >= 1 
        ? 'Loyalty Reward! Get ${discount} off your next order' 
        : 'Welcome Offer! Get ${discount} off your first order';
    
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.local_offer,
              size: 50,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              'Special Offer! 🎉',
              style: Get.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.toNamed('/create-order');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Claim Offer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Maybe Later'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> refreshHomeData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    initializeHomeData();
    
    isLoading.value = false;
  }
  String get userDisplayName => 'Welcome to WashWell';
  String get trackOrderText => hasActiveOrders.value 
      ? 'Track Your Order' 
      : 'Schedule Your First Order';
  String get trackOrderSubtitle => hasActiveOrders.value
      ? 'Real-time updates on your laundry'
      : 'Get started with our laundry services';
}