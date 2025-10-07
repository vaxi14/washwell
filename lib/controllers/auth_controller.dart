import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var currentUser = Rxn<User>();

  // Validatibg functions (emial, password, name, phone)
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(email)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) return 'Full name is required';
    if (name.length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) return 'Phone number is required';
    if (!GetUtils.isPhoneNumber(phone)) return 'Enter a valid phone number';
    return null;
  }

  //Checkong if email already exists
  Future<bool> isEmailUnique(String email) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('email', email);
      
      return response.isEmpty;
    } catch (e) {
      //it's unique, no record found
      return true;
    }
  }

  //phone number already exists
  Future<bool> isPhoneUnique(String phone) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('phone_number', phone);
      
      return response.isEmpty;
    } catch (e) {
      //it's unique
      return true;
    }
  }

  // Enhanced Sign Up with validation
  Future<void> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Pre-validation
      if (validateName(fullName) != null) {
        Get.snackbar('Error', 'Please enter a valid name');
        return;
      }
      if (validateEmail(email) != null) {
        Get.snackbar('Error', 'Please enter a valid email');
        return;
      }
      if (validatePhone(phoneNumber) != null) {
        Get.snackbar('Error', 'Please enter a valid phone number');
        return;
      }
      if (validatePassword(password) != null) {
        Get.snackbar('Error', 'Password must be at least 6 characters');
        return;
      }

      // Check uniqueness
      if (!await isEmailUnique(email)) {
        Get.snackbar('Error', 'Email already registered');
        return;
      }

      if (!await isPhoneUnique(phoneNumber)) {
        Get.snackbar('Error', 'Phone number already registered');
        return;
      }

      isLoading.value = true;
      
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone_number': phoneNumber,
        },
      );
      
      if (response.user != null) {
        //Create user profile in separate table
        await _createUserProfile(
          userId: response.user!.id,
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
        );
        
        Get.snackbar('Success', 'Account created successfully!');
        Get.toNamed('/signin');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Enhanced Sign In with validation
  Future<void> signIn({
    String? email,
    String? phoneNumber,
    required String password,
  }) async {
    try {
      // Validation
      if ((email == null || email.isEmpty) && (phoneNumber == null || phoneNumber.isEmpty)) {
        Get.snackbar('Error', 'Please enter email or phone number');
        return;
      }
      
      if (validatePassword(password) != null) {
        Get.snackbar('Error', 'Please enter your password');
        return;
      }

      isLoading.value = true;
      
      String loginEmail = email ?? await _getEmailFromPhone(phoneNumber!);
      
      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: loginEmail,
        password: password,
      );
      
      if (response.user != null) {
        currentUser.value = response.user;
        isLoggedIn.value = true;
        await _loadUserProfile(response.user!.id);
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar('Error', 'Invalid credentials or user not found');
    } finally {
      isLoading.value = false;
    }
  }

  // Get email from phone number for login
  Future<String> _getEmailFromPhone(String phoneNumber) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select('email')
          .eq('phone_number', phoneNumber);
      
      if (response.isNotEmpty) {
        return response.first['email'] as String;
      } else {
        throw Exception('No account found with this phone number');
      }
    } catch (e) {
      throw Exception('No account found with this phone number');
    }
  }

  // Create user profile in separate table
  Future<void> _createUserProfile({
    required String userId,
    required String fullName,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      await _supabase
          .from('profiles')
          .insert({
            'id': userId,
            'full_name': fullName,
            'email': email,
            'phone_number': phoneNumber,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          });
    } catch (e) {
      print('Error creating user profile: $e');
      rethrow;
    }
  }

  // Load user profile data
  Future<void> _loadUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId);
      
      if (response.isNotEmpty) {
        print('User profile loaded: ${response.first}');
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      isLoggedIn.value = false;
      currentUser.value = null;
      Get.offAllNamed('/signin');
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out');
    }
  }

  // Check logged in status
  Future<void> checkAuthStatus() async {
    try {
      final User? user = _supabase.auth.currentUser;
      isLoggedIn.value = user != null;
      currentUser.value = user;
      
      if (user != null) {
        await _loadUserProfile(user.id);
      }
    } catch (e) {
      print('Error checking auth status: $e');
    }
  }

  // Forgot Password
  Future<void> resetPassword(String email) async {
    try {
      if (validateEmail(email) != null) {
        Get.snackbar('Error', 'Please enter a valid email');
        return;
      }

      await _supabase.auth.resetPasswordForEmail(email);
      Get.snackbar('Success', 'Password reset email sent!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to send reset email');
    }
  }

  // Get current user data
  Map<String, dynamic>? get userData => currentUser.value != null 
      ? {
          'id': currentUser.value!.id,
          'email': currentUser.value!.email,
        }
      : null;
}