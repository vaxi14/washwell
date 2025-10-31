import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildUserInfoCard(),
            
            const SizedBox(height: 16),
            
            _buildStatsCard(),
            
            const SizedBox(height: 16),
            
            _buildAccountSettingsCard(),
            
            const SizedBox(height: 16),
            
            _buildAddressBookCard(),
            
            const SizedBox(height: 16),
            
            _buildOrderHistoryCard(),
            
            const SizedBox(height: 16),
            
            _buildSupportCard(),
            
            const SizedBox(height: 16),
            
            _buildLegalCard(),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Obx(() => Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade100,
              backgroundImage: controller.userProfile.value?.profileImage.isNotEmpty == true
                  ? NetworkImage(controller.userProfile.value!.profileImage)
                  : null,
              child: controller.userProfile.value?.profileImage.isEmpty == true
                  ? const Icon(Icons.person, size: 40, color: Colors.blue)
                  : null,
            ),
            
            const SizedBox(height: 12),
            
            Text(
              controller.userDisplayName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 4),
            
            Text(
              controller.userEmail,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            
            const SizedBox(height: 4),
            
            Text(
              controller.memberSince,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, size: 16, color: Colors.orange.shade600),
                  const SizedBox(width: 4),
                  Text(
                    '${controller.loyaltyLevel} Member',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Get.toNamed('/edit-profile');
                },
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Edit Profile'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildStatsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Laundry Stats',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Orders', controller.totalOrders.value.toString(), Icons.shopping_bag),
                _buildStatItem('Hours Saved', controller.hoursSaved.value.toString(), Icons.access_time),
                _buildStatItem('Savings', '₹${controller.totalSavings.value.toInt()}', Icons.savings),
              ],
            )),
            
            const SizedBox(height: 12),
            
            Obx(() => Row(
              children: [
                Icon(Icons.favorite, size: 16, color: Colors.red.shade400),
                const SizedBox(width: 8),
                Text(
                  'Favorite Service: ${controller.favoriteService.value}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettingsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 12),
            
            _buildSettingItem(
              'Personal Information',
              Icons.person_outline,
              () => Get.toNamed('/edit-profile'),
            ),
            
            _buildSettingItem(
              'Change Password',
              Icons.lock_outline,
              () => Get.toNamed('/change-password'),
            ),
            
            _buildSettingItem(
              'Notification Settings',
              Icons.notifications_outlined,
              () => Get.toNamed('/notifications'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressBookCard() {
    return Obx(() => Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Address Book',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 12),
            
            if (controller.addresses.isNotEmpty)
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.home, size: 16, color: Colors.green.shade600),
                      const SizedBox(width: 8),
                      const Text(
                        'Default Address:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.defaultAddress,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            else
              const Text(
                'No addresses saved',
                style: TextStyle(color: Colors.grey),
              ),
            
            const SizedBox(height: 16),
            
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Get.toNamed('/address-book');
                },
                icon: const Icon(Icons.add_location_alt_outlined, size: 18),
                label: const Text('Manage Addresses'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildOrderHistoryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 12),
            
            const Text(
              'View your past orders and track current ones',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            
            const SizedBox(height: 16),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/orders');
                },
                icon: const Icon(Icons.history, size: 18),
                label: const Text('View Order History'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Support & Help',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 12),
            
            _buildSupportItem(
              'Contact Support',
              Icons.support_agent_outlined,
              () => Get.toNamed('/contact-support'),
            ),
            
            _buildSupportItem(
              'Help & FAQ',
              Icons.help_outline,
              () => Get.toNamed('/faq'),
            ),
            
            _buildSupportItem(
              'About App',
              Icons.info_outline,
              () => Get.toNamed('/about'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Legal & Preferences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 12),
            
            _buildLegalItem(
              'Terms & Privacy',
              Icons.security_outlined,
              () => Get.toNamed('/terms-privacy'),
            ),
            
            _buildLegalItem(
              'App Settings',
              Icons.settings_outlined,
              () => Get.toNamed('/app-settings'),
            ),
            
            const SizedBox(height: 8),
            
            const Divider(),
            
            const SizedBox(height: 8),
            
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () {
                  _showLogoutDialog();
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(vertical: -2),
    );
  }

  Widget _buildSupportItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(vertical: -2),
    );
  }

  Widget _buildLegalItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(vertical: -2),
    );
  }


  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.logout();
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}