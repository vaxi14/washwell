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
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        
        GetPage(name: '/main', page: () => MainNavigationScreen()),
        GetPage(name: '/wash', page: () => WashServiceScreen()),
        GetPage(name: '/iron', page: () => IronServiceScreen()),
        GetPage(name: '/dry', page: () => DryServiceScreen()),
        GetPage(name: '/clean', page: () => CleanServiceScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/create-order', page: () => CreateOrderScreen()),
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
      future: Get.put(AuthController()).checkAuthStatus(),
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