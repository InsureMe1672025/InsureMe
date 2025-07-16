import 'package:flutter/material.dart';
import '../../models/policy.dart';
import '../../screens/policy/policy_details_screen.dart';
import '../../utils/app_colors.dart';

class PolicyCard extends StatelessWidget {
  final Policy policy;
  
  const PolicyCard({
    Key? key,
    required this.policy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PolicyDetailsScreen(policy: policy),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 300,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFC1D7E0), // AppColors.secondary
                Color(0xFFD2DFE4), // AppColors.secondaryLight
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Policy No.: ${policy.policyNumber}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Name: ${policy.name}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Vehicle number: ${policy.vehicleNumber}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Expiry Date: ${policy.expiryDate}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Cover:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  policy.coverageDetails.join(', '),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
