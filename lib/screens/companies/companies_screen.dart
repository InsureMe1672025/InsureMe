import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/company_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/common/custom_button.dart';

class CompaniesScreen extends ConsumerStatefulWidget {
  const CompaniesScreen({super.key});

  @override
  ConsumerState<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends ConsumerState<CompaniesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Mock companies for demonstration
    final companies = [
      CompanyModel(
        id: 'comp1',
        insuranceTypes: ['Health', 'Vehicle', 'Property'],
        name: 'Insurance Co Ltd',
        logo: 'assets/images/company1.png',
        description: 'Leading insurance provider with comprehensive coverage options for vehicles, health, and property.',
        rating: 4.5,
        reviewCount: 120,
        phone: '+973 1234 5678',
        email: 'info@insuranceco.com',
        website: 'www.insuranceco.com',
        address: 'Building 123, Road 1234, Block 321, Manama, Bahrain',
      ),
      CompanyModel(
        id: 'comp2',
        insuranceTypes: ['Health', 'Vehicle', 'Property'],
        name: 'Secure Insurance',
        logo: 'assets/images/company2.png',
        description: 'Trusted insurance company with over 25 years of experience in the Bahraini market.',
        rating: 4.2,
        reviewCount: 98,
        phone: '+973 1234 9876',
        email: 'support@secureinsurance.com',
        website: 'www.secureinsurance.com',
        address: 'Building 456, Road 5678, Block 789, Riffa, Bahrain',
      ),
      CompanyModel(
        id: 'comp3',
        insuranceTypes: ['Health', 'Vehicle', 'Property'],
        name: 'Global Protect',
        logo: 'assets/images/company3.png',
        description: 'International insurance company offering innovative and flexible insurance solutions.',
        rating: 4.7,
        reviewCount: 156,
        phone: '+973 1234 1234',
        email: 'info@globalprotect.com',
        website: 'www.globalprotect.com',
        address: 'Building 789, Road 4321, Block 654, Muharraq, Bahrain',
      ),
    ];
    
    // Filter companies based on search query
    final filteredCompanies = companies.where((company) => 
      _searchQuery.isEmpty || 
      company.name.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Companies'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search companies',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.textLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.textLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Companies list
          Expanded(
            child: filteredCompanies.isEmpty
                ? const Center(
                    child: Text(
                      'No companies found',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredCompanies.length,
                    itemBuilder: (context, index) {
                      return _buildCompanyCard(filteredCompanies[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCompanyCard(CompanyModel company) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.business,
                      color: AppColors.primary,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: company.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 16,
                            ignoreGestures: true,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${company.reviewCount})',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Company details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company.description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Contact information
                const Text(
                  'Contact Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                _buildContactItem(Icons.phone, company.phone ?? ''),
                _buildContactItem(Icons.email, company.email ?? ''),
                _buildContactItem(Icons.language, company.website ?? ''),
                _buildContactItem(Icons.location_on, company.address ?? ''),
                
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: 'View Offers',
                      onPressed: () {
                        // Navigate to company offers
                      },
                      type: ButtonType.primary,
                      isFullWidth: false,
                      height: 40,
                    ),
                    CustomButton(
                      text: 'Rate Company',
                      onPressed: () {
                        // Show rating dialog
                        _showRatingDialog(company);
                      },
                      type: ButtonType.outline,
                      isFullWidth: false,
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showRatingDialog(CompanyModel company) {
    double rating = company.rating;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rate ${company.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'How would you rate your experience with this company?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                rating = newRating;
              },
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Add a comment (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Submit rating
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Thank you for your rating!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
