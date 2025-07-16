import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_model.dart';
import '../../providers/main_provider.dart';
import '../../services/auth_service.dart';
import '../../utils/app_colors.dart';
import '../../widgets/common/custom_button.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isLoading = false;
  
  Future<void> _logout() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      await ref.read(authServiceProvider).signOut();
      await ref.read(mainProvider.notifier).getIfUserLoggedIn();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final mainProviderData = ref.watch(mainProvider);
    final UserModel? user = mainProviderData.currentUser;
    
    if (user == null) {
      return const Center(
        child: Text('User not logged in'),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(user.name),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email ?? 'No email provided',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Personal Information
            _buildSectionHeader('Personal Information'),
            _buildInfoCard([
              _buildInfoItem('CPR', user.cpr),
              _buildInfoItem('Phone', user.phone),
              _buildInfoItem('Email', user.email ?? 'Not provided'),
              _buildInfoItem('Gender', user.gender ?? 'Not provided'),
              _buildInfoItem('Nationality', user.nationality ?? 'Not provided'),
              _buildInfoItem('Date of Birth', user.dateOfBirth != null 
                  ? _formatDate(DateTime.parse(user.dateOfBirth!)) 
                  : 'Not provided'),
            ]),
            
            const SizedBox(height: 24),
            
            // Account Settings
            _buildSectionHeader('Account Settings'),
            _buildSettingsCard([
              _buildSettingItem(
                'Edit Profile',
                Icons.edit,
                () {
                  // Navigate to edit profile
                },
              ),
              _buildSettingItem(
                'Change Password',
                Icons.lock,
                () {
                  // Navigate to change password
                },
              ),
              _buildSettingItem(
                'Notifications',
                Icons.notifications,
                () {
                  // Navigate to notifications settings
                },
              ),
              _buildSettingItem(
                'Language',
                Icons.language,
                () {
                  // Show language options
                },
              ),
            ]),
            
            const SizedBox(height: 24),
            
            // Support & Help
            _buildSectionHeader('Support & Help'),
            _buildSettingsCard([
              _buildSettingItem(
                'Contact Support',
                Icons.support_agent,
                () {
                  // Navigate to support
                },
              ),
              _buildSettingItem(
                'FAQ',
                Icons.question_answer,
                () {
                  // Navigate to FAQ
                },
              ),
              _buildSettingItem(
                'Terms & Conditions',
                Icons.description,
                () {
                  // Navigate to terms
                },
              ),
              _buildSettingItem(
                'Privacy Policy',
                Icons.privacy_tip,
                () {
                  // Navigate to privacy policy
                },
              ),
            ]),
            
            const SizedBox(height: 32),
            
            // Logout button
            Center(
              child: CustomButton(
                text: 'Logout',
                onPressed: _logout,
                isLoading: _isLoading,
                type: ButtonType.secondary,
                width: 200,
                isFullWidth: false,
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
  
  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    if (nameParts.length > 1) {
      return '${nameParts[0][0]}${nameParts[1][0]}';
    } else if (nameParts.isNotEmpty) {
      return nameParts[0][0];
    }
    return '';
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
  
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
  
  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: children,
        ),
      ),
    );
  }
  
  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingsCard(List<Widget> children) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: children,
        ),
      ),
    );
  }
  
  Widget _buildSettingItem(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
