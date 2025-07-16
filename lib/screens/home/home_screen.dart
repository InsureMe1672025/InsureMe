import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insure_me/widgets/auth/auth_background.dart';
import '../../providers/policy_provider.dart';
import '../../screens/quotes/quote_form_screen.dart';
import '../../utils/app_colors.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/policy/policy_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:AuthBackground(
      backgroundImage: "assets/images/homebackground.png",
      backgroundColor: Colors.white,
        child: ListView(
          
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'InsureMe',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner/Carousel
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: AppColors.secondaryDark,
                        child: Center(
                          child: Text(
                            'Featured Offers',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      //add : space for ads
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 20,
                          width: 30,
                          color: AppColors.secondary,
                          child: const Text(
                            'Ads',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // My Active Policies
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Active Policies',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 250,
                          child: Consumer(
                            builder: (context, ref, _) {
                              final policies = ref.watch(activePoliciesProvider);
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: policies.length,
                                itemBuilder: (context, index) {
                                  return PolicyCard(policy: policies[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const Divider(),
                  
                  // Quick actions
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Actions',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildQuickActionItem(
                              context,
                              Icons.directions_car,
                              'Get New Quote',
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const QuoteFormScreen(),
                                  ),
                                );
                              },
                            ),
                            _buildQuickActionItem(
                              context,
                              Icons.health_and_safety,
                              'Renew Policy',
                              () {},
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const Divider(),
                  
                  // Top insurance companies
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top Insurance Companies',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return _buildCompanyItem(context, index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const Divider(),
                  
                  // Latest offers
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Latest Offers',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildOfferCard(context),
                        const SizedBox(height: 16),
                        _buildOfferCard(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              borderRadius: BorderRadius.circular(500),
              border: Border.all(color: AppColors.primary, width: 4),
            ),
            child: Icon(
              icon,
              size: 72,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyItem(BuildContext context, int index) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondary),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.business,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Company ${index + 1}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.business,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Insurance Company',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Vehicle Insurance',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '20% Off on New Vehicle Insurance',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Get comprehensive coverage for your vehicle with our special offer. Limited time only!',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Valid until: 31 Dec 2025',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                CustomButton(
                  text: 'View Offer',
                  onPressed: () {},
                  isFullWidth: false,
                  height: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
