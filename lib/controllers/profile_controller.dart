import 'package:get/get.dart';

// User Address Model
class UserAddress {
  final String id;
  final String type; // Home, Work, Other
  final String address;
  final String landmark;
  final String city;
  final String pincode;
  final bool isDefault;

  UserAddress({
    required this.id,
    required this.type,
    required this.address,
    required this.landmark,
    required this.city,
    required this.pincode,
    required this.isDefault,
  });
}

// User Profile Model
class UserProfile {
  final String id;
  String fullName;
  String email;
  String phoneNumber;
  String profileImage;
  DateTime joinDate;
  int loyaltyPoints;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.profileImage = '',
    required this.joinDate,
    this.loyaltyPoints = 0,
  });
}

class ProfileController extends GetxController {
  // ==================== USER PROFILE DATA ====================
  var userProfile = Rxn<UserProfile>();
  var isLoading = false.obs;
  
  // ==================== ADDRESS MANAGEMENT ====================
  var addresses = <UserAddress>[].obs;
  var selectedAddress = Rxn<UserAddress>();
  
  // ==================== USER STATISTICS ====================
  var totalOrders = 0.obs;
  var totalSavings = 0.0.obs;
  var hoursSaved = 0.obs;
  var favoriteService = 'Wash'.obs;
  
  // ==================== SETTINGS & PREFERENCES ====================
  var notificationsEnabled = true.obs;
  var emailNotifications = true.obs;
  var smsNotifications = false.obs;
  var pushNotifications = true.obs;
  var darkMode = false.obs;
  var language = 'English'.obs;

  // ==================== INITIALIZATION ====================
  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
    _loadUserAddresses();
    _loadUserStatistics();
    _loadUserSettings();
  }

  // ==================== PROFILE MANAGEMENT ====================

  /// Load user profile data
  void _loadUserProfile() {
    // TODO: Replace with actual API call
    userProfile.value = UserProfile(
      id: 'user_123',
      fullName: 'John Doe',
      email: 'john.doe@email.com',
      phoneNumber: '+91 9876543210',
      profileImage: '',
      joinDate: DateTime(2024, 1, 15),
      loyaltyPoints: 150,
    );
  }

  /// Update user profile
  Future<void> updateProfile({
    required String fullName,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      isLoading.value = true;
      
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      if (userProfile.value != null) {
        userProfile.value = userProfile.value!.copyWith(
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
        );
      }
      
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    } finally {
      isLoading.value = false;
    }
  }

  /// Update profile picture
  Future<void> updateProfilePicture(String imagePath) async {
    // TODO: Implement image upload
    if (userProfile.value != null) {
      userProfile.value!.profileImage = imagePath;
      userProfile.refresh();
    }
  }

  // ==================== ADDRESS MANAGEMENT ====================

  /// Load user addresses
  void _loadUserAddresses() {
    // TODO: Replace with actual API call
    addresses.assignAll([
      UserAddress(
        id: 'addr_1',
        type: 'Home',
        address: '123 Main Street, Apartment 4B',
        landmark: 'Near Central Park',
        city: 'Mumbai',
        pincode: '400001',
        isDefault: true,
      ),
      UserAddress(
        id: 'addr_2',
        type: 'Work',
        address: '456 Business Tower, Floor 8',
        landmark: 'Opposite Metro Station',
        city: 'Mumbai',
        pincode: '400002',
        isDefault: false,
      ),
    ]);
    
    selectedAddress.value = addresses.firstWhere((addr) => addr.isDefault);
  }

  /// Add new address
  Future<void> addAddress(UserAddress newAddress) async {
    try {
      // TODO: Replace with actual API call
      addresses.add(newAddress);
      
      if (newAddress.isDefault) {
        _setDefaultAddress(newAddress.id);
      }
      
      Get.snackbar('Success', 'Address added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add address');
    }
  }

  /// Update existing address
  Future<void> updateAddress(String addressId, UserAddress updatedAddress) async {
    try {
      final index = addresses.indexWhere((addr) => addr.id == addressId);
      if (index != -1) {
        addresses[index] = updatedAddress;
        
        if (updatedAddress.isDefault) {
          _setDefaultAddress(addressId);
        }
        
        Get.snackbar('Success', 'Address updated successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update address');
    }
  }

  /// Delete address
  Future<void> deleteAddress(String addressId) async {
    try {
      addresses.removeWhere((addr) => addr.id == addressId);
      Get.snackbar('Success', 'Address deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete address');
    }
  }

  /// Set default address
  void _setDefaultAddress(String addressId) {
    for (var address in addresses) {
      if (address.id == addressId) {
        selectedAddress.value = address;
      }
    }
    addresses.refresh();
  }

  // ==================== STATISTICS MANAGEMENT ====================

  /// Load user statistics
  void _loadUserStatistics() {
    // TODO: Replace with actual API call
    totalOrders.value = 12;
    totalSavings.value = 1560.0;
    hoursSaved.value = 28;
    favoriteService.value = 'Wash';
  }

  // ==================== SETTINGS MANAGEMENT ====================

  /// Load user settings
  void _loadUserSettings() {
    // TODO: Replace with actual API call from local storage
    notificationsEnabled.value = true;
    emailNotifications.value = true;
    smsNotifications.value = false;
    pushNotifications.value = true;
    darkMode.value = false;
    language.value = 'English';
  }

  /// Update notification settings
  void updateNotificationSettings({
    bool? email,
    bool? sms,
    bool? push,
  }) {
    if (email != null) emailNotifications.value = email;
    if (sms != null) smsNotifications.value = sms;
    if (push != null) pushNotifications.value = push;
    
    // Update main notifications flag
    notificationsEnabled.value = 
        emailNotifications.value || smsNotifications.value || pushNotifications.value;
    
    // TODO: Save to local storage/API
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    darkMode.value = !darkMode.value;
    // TODO: Save to local storage and update app theme
  }

  /// Change language
  void changeLanguage(String newLanguage) {
    language.value = newLanguage;
    // TODO: Save to local storage and update app language
  }

  // ==================== LOYALTY & REWARDS ====================

  /// Get loyalty level based on points
  String get loyaltyLevel {
    final points = userProfile.value?.loyaltyPoints ?? 0;
    if (points >= 500) return 'Gold';
    if (points >= 200) return 'Silver';
    return 'Bronze';
  }

  /// Get progress to next loyalty level
  double get loyaltyProgress {
    final points = userProfile.value?.loyaltyPoints ?? 0;
    if (points >= 500) return 1.0; // Max level
    if (points >= 200) return (points - 200) / 300; // Progress to Gold
    return points / 200; // Progress to Silver
  }

  // ==================== GETTERS FOR UI ====================

  /// Get user display name
  String get userDisplayName => userProfile.value?.fullName ?? 'User';

  /// Get user email
  String get userEmail => userProfile.value?.email ?? '';

  /// Get user phone
  String get userPhone => userProfile.value?.phoneNumber ?? '';

  /// Get member since text
  String get memberSince {
    final joinDate = userProfile.value?.joinDate;
    if (joinDate != null) {
      return 'Member since ${joinDate.year}';
    }
    return 'Member';
  }

  /// Get default address
  String get defaultAddress {
    final defaultAddr = addresses.firstWhereOrNull((addr) => addr.isDefault);
    return defaultAddr?.address ?? 'No address saved';
  }

  // ==================== LOGOUT ====================

  /// Logout user
  Future<void> logout() async {
    try {
      isLoading.value = true;
      
      // TODO: Clear user data, tokens, etc.
      await Future.delayed(const Duration(seconds: 1));
      
      // Navigate to login screen
      Get.offAllNamed('/signin');
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout');
    } finally {
      isLoading.value = false;
    }
  }

  // ==================== CLEANUP ====================
  @override
  void onClose() {
    // Clean up any listeners
    super.onClose();
  }
}

// Extension methods for copying objects
extension UserProfileCopyWith on UserProfile {
  UserProfile copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profileImage,
    DateTime? joinDate,
    int? loyaltyPoints,
  }) {
    return UserProfile(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      joinDate: joinDate ?? this.joinDate,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
    );
  }
}