import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washwell/pages/home/home_screen.dart';
import 'package:washwell/pages/main/main_navigation_screen.dart';
import 'package:washwell/pages/service/clean_service_screen.dart';
import 'package:washwell/pages/service/dry_service_screen.dart';
import 'package:washwell/pages/service/iron_service_screen.dart';
import 'package:washwell/pages/service/wash_service_screen.dart';
import 'utils/supabase_client.dart';
import 'controllers/auth_controller.dart';
import 'pages/auth/signin_screen.dart';
import 'pages/auth/signup_screen.dart';

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
      home:  MainNavigationScreen(),
      getPages: [
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/main', page: ()=> MainNavigationScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/wash', page: () => WashServiceScreen()),
        GetPage(name: '/iron', page: () => IronServiceScreen()),
        GetPage(name: '/dry', page: ()=> DryServiceScreen()),
        GetPage(name: '/clean', page: ()=> CleanServiceScreen())
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
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to Washwell!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => authController.signOut(),
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              ),
            );
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