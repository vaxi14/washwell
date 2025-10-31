import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washwell/pages/home/home_screen.dart';
import 'package:washwell/pages/main/main_navigation_screen.dart';
import 'package:washwell/pages/order/create_order_screen.dart';
import 'package:washwell/pages/service/clean_service_screen.dart';
import 'package:washwell/pages/service/dry_service_screen.dart';
import 'package:washwell/pages/service/iron_service_screen.dart';
import 'package:washwell/pages/service/wash_service_screen.dart';
import 'package:washwell/utils/supabase_client.dart';
import 'package:washwell/controllers/auth_controller.dart';
import 'package:washwell/pages/auth/signin_screen.dart';
import 'package:washwell/pages/auth/signup_screen.dart';

// Profile Screen Imports
import 'package:washwell/pages/profile/profile_screen.dart';
// import 'package:washwell/pages/profile/edit_profile_screen.dart';
// import 'package:washwell/pages/profile/change_password_screen.dart';
// import 'package:washwell/pages/profile/notifications_screen.dart';
// import 'package:washwell/pages/profile/address_book_screen.dart';
// import 'package:washwell/pages/profile/contact_support_screen.dart';
// import 'package:washwell/pages/profile/faq_screen.dart';
// import 'package:washwell/pages/profile/about_screen.dart';
// import 'package:washwell/pages/profile/terms_privacy_screen.dart';
// import 'package:washwell/pages/profile/app_settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseClient.intialize();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LaundryLens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/main',
      getPages: [
        // Auth Routes
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        
        // Main Navigation
        GetPage(name: '/main', page: () => MainNavigationScreen()),
        
        // Service Routes
        GetPage(name: '/wash', page: () => WashServiceScreen()),
        GetPage(name: '/iron', page: () => IronServiceScreen()),
        GetPage(name: '/dry', page: () => DryServiceScreen()),
        GetPage(name: '/clean', page: () => CleanServiceScreen()),
        
        // Home & Order Routes
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/create-order', page: () => CreateOrderScreen()),
        
        // Profile Routes - ADDED
        GetPage(name: '/profile', page: () => ProfileScreen()),
        // GetPage(name: '/edit-profile', page: () => EditProfileScreen()),
        // GetPage(name: '/change-password', page: () => ChangePasswordScreen()),
        // GetPage(name: '/notifications', page: () => NotificationsScreen()),
        // GetPage(name: '/address-book', page: () => AddressBookScreen()),
        // GetPage(name: '/contact-support', page: () => ContactSupportScreen()),
        // GetPage(name: '/faq', page: () => FAQScreen()),
        // GetPage(name: '/about', page: () => AboutScreen()),
        // GetPage(name: '/terms-privacy', page: () => TermsPrivacyScreen()),
        // GetPage(name: '/app-settings', page: () => AppSettingsScreen()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Get.find<AuthController>().checkAuthStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final authController = Get.find<AuthController>();
          if (authController.isLoggedIn.value) {
            // Navigate to main screen with bottom nav
            return MainNavigationScreen();
          } else {
            return const SignInScreen();
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}