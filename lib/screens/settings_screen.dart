import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'logout_confirmation_modal.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => LogoutConfirmationModal(
        onConfirm: () {
          // Clear session logic here if needed
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent, // remove Material 3 tint
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account',
              style: TextStyle(
                fontSize: 14, // Looks small but specific like section header
                fontWeight: FontWeight.bold,
                color: Color(0xFF15181A),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildItem(
                    title: 'Your Profile',
                    subtitle: 'Manage your personal details',
                    iconPath: 'assets/images/Your Profile.png',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildItem(
                    title: 'Other Information',
                    subtitle:
                        'Update additional details like occupation, address',
                    iconPath: 'assets/images/Other Information.png',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildItem(
                    title: 'Verification',
                    subtitle:
                        'Submit required documents to verify your identity',
                    iconPath: 'assets/images/Verifications.png',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildItem(
                    title: 'Account Limits',
                    subtitle: 'Manage how much you can transfer or receive',
                    iconPath: 'assets/images/Account Limits.png',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildItem(
                    title: 'Manage Beneficiaries',
                    subtitle:
                        'Manage your beneficiaries you frequently send money to',
                    iconPath: 'assets/images/Manage Beneficiaries.png',
                    onTap: () {},
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'General',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF15181A),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildItem(
                    title: 'Settings',
                    subtitle:
                        'Change appearance, password, payment pin and more',
                    iconPath: 'assets/images/Settings.png',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildItem(
                    title: 'Two-Factor Authentication',
                    subtitle:
                        'Enhance account security with 2-factor authentication',
                    iconPath: 'assets/images/Two-Factor Authentication.png',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildItem(
                    title: 'Support',
                    subtitle: 'Access help whenever you need assistance',
                    iconPath: 'assets/images/Support.png',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildItem(
                    title: 'FAQ',
                    subtitle:
                        'Need help? Explore our most asked questions below.',
                    iconPath: 'assets/images/faq.png',
                    onTap: () {},
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: TextButton.icon(
                onPressed: () => _handleLogout(context),
                icon: Image.asset(
                  'assets/images/logout.png',
                  width: 24,
                  height: 24,
                  color: Colors.red,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'v 1.0',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey[100]);
  }

  Widget _buildItem({
    required String title,
    required String subtitle,
    required String iconPath,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                iconPath,
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF15181A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
          ],
        ),
      ),
    );
  }
}
