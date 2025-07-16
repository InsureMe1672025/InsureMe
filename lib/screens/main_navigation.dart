import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../providers/main_provider.dart';
import '../features/auth/auth_page.dart';
import '../utils/app_colors.dart';
import 'home/home_screen.dart';
import 'policies/policies_screen.dart';
import 'companies/companies_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigationPage extends ConsumerStatefulWidget {
  const MainNavigationPage({super.key});

  @override
  ConsumerState<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends ConsumerState<MainNavigationPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref.read(mainProvider.notifier).getIfUserLoggedIn();
      if (mounted) ref.read(mainProvider.notifier).setIsLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProviderData = ref.watch(mainProvider);
    final bool showNavBar = mainProviderData.isUserLoggedIn;
    final UserModel? user = mainProviderData.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child:
            mainProviderData.isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
                : Stack(
                  children: [
                    _buildBody(mainProviderData, user),
                    if (showNavBar)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _buildNavBar(mainProviderData),
                      ),
                  ],
                ),
      ),
    );
  }

  Widget _buildBody(MainProviderState mainProviderData, UserModel? user) {
    if (!mainProviderData.isUserLoggedIn || user == null) {
      return const AuthPage();
    } else {
      // Return the appropriate page based on selected index
      return _getPageForIndex(mainProviderData.selectedMainPageIndex);
    }
  }

  Widget _buildNavBar(MainProviderState mainProviderData) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.secondaryDark,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 0, mainProviderData, 'Home'),
            _buildNavItem(Icons.policy, 1, mainProviderData, 'Policies'),
            _buildNavItem(Icons.business, 2, mainProviderData, 'Companies'),
            _buildNavItem(Icons.person, 3, mainProviderData, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    int index,
    MainProviderState mainProviderData,
    String label,
  ) {
    final isSelected = mainProviderData.selectedMainPageIndex == index;

    return GestureDetector(
      onTap: () => ref.read(mainProvider.notifier).setSelectedPage(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.white.withOpacity(0.7), size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Return the appropriate page based on index
  Widget _getPageForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const PoliciesScreen();
      case 2:
        return const CompaniesScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }
}
