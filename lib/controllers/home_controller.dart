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
  
  var greeting = 'Hello!'.obs;

  var notificationCount = 0.obs;
  
  var hasActiveOrders = false.obs;
  
  var activeOrderStatus = 'No active orders'.obs;
  

  var isLoading = false.obs;

  var services = <Service>[].obs;

  var totalOrders = 0.obs;
  var hoursSaved = 0.obs;
  var itemsCleaned = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeHomeData();
  }


  ///Initialize all home screen data when app starts
  void initializeHomeData() {
    _setTimeBasedGreeting();
    _loadNotificationCount();
    _checkActiveOrders();
    _calculateQuickStats();
    _initializeServices();
  }

  /// Initialize services list
  void _initializeServices() {
    services.assignAll([
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


  void _loadNotificationCount() {
    notificationCount.value = 3; //static for now
  }

  void _checkActiveOrders() {
    final hasOrders = true; 
    hasActiveOrders.value = hasOrders;
    
    if (hasOrders) {
      activeOrderStatus.value = '1 order in progress • ETA: Today 6 PM';
    } else {
      activeOrderStatus.value = 'No active orders';
    }
  }

  void _calculateQuickStats() {
    totalOrders.value = 5;
    hoursSaved.value = 12;
    itemsCleaned.value = 45;
  }


  /// Navigate to track order screen
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

  void navigateToService(String serviceName) {
    try {
      final service = services.firstWhere(
        (s) => s.name.toLowerCase() == serviceName.toLowerCase(),
      );
      
      print('🎯 Navigating to: ${service.route}'); 
      
      Get.toNamed(service.route);
      
    } catch (e) {
      print('❌ Error navigating to service: $e');
      Get.snackbar(
        'Service Not Available',
        'The $serviceName service is currently unavailable',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void navigateToServiceByRoute(String routeName) {
    try {
      Get.toNamed(routeName);
    } catch (e) {
      print('❌ Error navigating to route: $routeName - $e');
      Get.snackbar(
        'Navigation Error',
        'Unable to open the requested page',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void onNotificationTap() {
    Get.snackbar(
      'Notifications',
      'You have ${notificationCount.value} notifications',
      snackPosition: SnackPosition.TOP,
    );
    
    notificationCount.value = 0;
  }

  /// Promotion bottom sheet
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


  /// Refresh all home screen data
  Future<void> refreshHomeData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    initializeHomeData();
    isLoading.value = false;
  }

  String get userDisplayName => 'Welcome to LaundryLens';

  String get trackOrderText => hasActiveOrders.value 
      ? 'Track Your Order' 
      : 'Schedule Your First Order';

  String get trackOrderSubtitle => hasActiveOrders.value
      ? 'Real-time updates on your laundry'
      : 'Get started with our laundry services';

  Service? getServiceByName(String name) {
    try {
      return services.firstWhere(
        (s) => s.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  bool isServiceRouteAvailable(String routeName) {
    return services.any((service) => service.route == routeName);
  }
}