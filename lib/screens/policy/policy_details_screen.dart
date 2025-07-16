import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/policy.dart';
import '../../utils/app_colors.dart';
import '../../widgets/common/custom_button.dart';

class PolicyDetailsScreen extends ConsumerWidget {
  final Policy policy;

  const PolicyDetailsScreen({
    Key? key,
    required this.policy,
  }) : super(key: key);

  bool isExpiringInOneMonth() {
    try {
      // Parse the expiry date
      final dateFormat = DateFormat('dd/MM/yyyy');
      final expiryDate = dateFormat.parse(policy.expiryDate);
      final now = DateTime.now();
      
      // Calculate the difference in days
      final difference = expiryDate.difference(now).inDays;
      
      // Check if the policy expires within 30 days
      return difference <= 30 && difference >= 0;
    } catch (e) {
      // If there's an error parsing the date, return false
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpiringSoon = isExpiringInOneMonth();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policy Details'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Policy header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primaryLight,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Policy Information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Policy Number', policy.policyNumber, Colors.white),
                  _buildInfoRow('Policy Holder', policy.name, Colors.white),
                  _buildInfoRow('Vehicle Number', policy.vehicleNumber, Colors.white),
                  _buildInfoRow('Expiry Date', policy.expiryDate, Colors.white),
                ],
              ),
            ),
            
            // Coverage details
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Coverage Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...policy.coverageDetails.map((coverage) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            coverage,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
            
            // Expiry warning and renewal options
            if (isExpiringSoon)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.warning),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Your policy is expiring soon!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.warning,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Renew your policy before it expires to maintain continuous coverage.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Renew Policy',
                            onPressed: () {
                              // Handle policy renewal
                            },
                            isFullWidth: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              // Navigate to get quotes from other companies
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Compare Quotes'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
            // Additional information
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Policy Type', 'Vehicle Insurance', AppColors.textPrimary),
                  _buildInfoRow('Insurance Provider', 'InsureMe Partner', AppColors.textPrimary),
                  _buildInfoRow('Payment Status', 'Paid', AppColors.textPrimary),
                  _buildInfoRow('Next Payment', 'N/A', AppColors.textPrimary),
                ],
              ),
            ),
            
            // Action buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Download Policy',
                      onPressed: () {
                        // Handle policy download
                      },
                      isFullWidth: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle file claim action
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('File a Claim'),
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
  
  Widget _buildInfoRow(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
