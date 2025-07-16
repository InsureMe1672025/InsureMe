import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/policy.dart';

// Provider for active policies
final activePoliciesProvider = Provider<List<Policy>>((ref) {
  // Mock data - in a real app, this would come from an API or local database
  return [
    Policy(
      policyNumber: 'BH000112IAA011009',
      name: 'Ahmed Abdullah',
      vehicleNumber: '77323',
      expiryDate: '12/12/2025',
      coverageDetails: [
        'Third Party Property Damages',
        'Third Party bodily Injury',
        'Loss or Damage of Vehicle',
        'Emergency Treatment Cover',
        'Car Replacement Cover',
        'Road Assist Cover',
        'Agency Repair'
      ],
    ),
    Policy(
      policyNumber: 'BH000113IAA011010',
      name: 'Mohammed Ali',
      vehicleNumber: '45678',
      expiryDate: '15/10/2025',
      coverageDetails: [
        'Third Party Property Damages',
        'Third Party bodily Injury',
        'Loss or Damage of Vehicle',
        'Emergency Treatment Cover',
      ],
    ),
    Policy(
      policyNumber: 'BH000114IAA011011',
      name: 'Fatima Hassan',
      vehicleNumber: '98765',
      expiryDate: '03/08/2026',
      coverageDetails: [
        'Third Party Property Damages',
        'Third Party bodily Injury',
        'Loss or Damage of Vehicle',
        'Road Assist Cover',
        'Agency Repair'
      ],
    ),
  ];
});
