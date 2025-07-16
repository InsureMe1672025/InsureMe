import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/policy_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/common/custom_button.dart';

enum QuotationStatus {
  pending,
  readyToPay,
  inProgress,
  expired
}

class QuotationModel {
  final String id;
  final String policyNumber;
  final String companyName;
  final String vehicleNumber;
  final DateTime requestDate;
  final double price;
  final QuotationStatus status;
  final List<String>? coverageDetails;

  QuotationModel({
    required this.id,
    required this.policyNumber,
    required this.companyName,
    required this.vehicleNumber,
    required this.requestDate,
    required this.price,
    required this.status,
    this.coverageDetails,
  });
}

class PoliciesScreen extends ConsumerStatefulWidget {
  const PoliciesScreen({super.key});

  @override
  ConsumerState<PoliciesScreen> createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends ConsumerState<PoliciesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Policies'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Expired'),
            Tab(text: 'Quotations'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPoliciesList(active: true),
          _buildPoliciesList(active: false),
          _buildQuotationsList(),
        ],
      ),
    );
  }
  
  Widget _buildPoliciesList({required bool active}) {
    // Mock policies for demonstration
    final policies = [
      PolicyModel(
        id: '1',
        policyNumber: 'BH0001121AA01009',
        name: 'Ahmed Abdullah',
        companyId: 'comp1',
        companyName: 'Insurance Co Ltd',
        companyLogo: 'assets/images/company1.png',
        vehicleNumber: '77323',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        expiryDate: DateTime.now().add(const Duration(days: 335)),
        type: PolicyType.vehicle,
        status: PolicyStatus.active,
        premium: 120.0,
        coverageDetails: [
          'Third Party Property Damage',
          'Third Party Bodily Injury',
          'Own Car Replacement Cover',
          'Road Assistance Service',
        ],
      ),
      PolicyModel(
        id: '2',
        policyNumber: 'BH0001121AA01010',
        name: 'Ahmed Abdullah',
        companyId: 'comp2',
        companyName: 'Secure Insurance',
        companyLogo: 'assets/images/company2.png',
        vehicleNumber: '88456',
        startDate: DateTime.now().subtract(const Duration(days: 60)),
        expiryDate: active 
            ? DateTime.now().add(const Duration(days: 120))
            : DateTime.now().subtract(const Duration(days: 30)),
        type: PolicyType.vehicle,
        status: active ? PolicyStatus.active : PolicyStatus.expired,
        premium: 150.0,
        coverageDetails: [
          'Comprehensive Coverage',
          'Personal Accident Cover',
          'Natural Disaster Protection',
        ],
      ),
    ];
    
    final filteredPolicies = policies.where((policy) => 
      active ? policy.status == PolicyStatus.active : policy.status == PolicyStatus.expired
    ).toList();
    
    if (filteredPolicies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              active ? Icons.policy_outlined : Icons.history,
              size: 80,
              color: AppColors.textLight,
            ),
            const SizedBox(height: 16),
            Text(
              active 
                ? 'No active policies found'
                : 'No expired policies found',
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Get New Policy',
              onPressed: () {
                // Navigate to get new policy
              },
              width: 200,
              isFullWidth: false,
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredPolicies.length,
      itemBuilder: (context, index) {
        final policy = filteredPolicies[index];
        return _buildPolicyCard(policy);
      },
    );
  }
  
  Widget _buildQuotationsList() {
    // Mock quotations for demonstration
    final quotations = [
      QuotationModel(
        id: '1',
        policyNumber: 'QT0001121AA01009',
        companyName: 'AGC Insurance',
        vehicleNumber: '77323',
        requestDate: DateTime.now().subtract(const Duration(days: 2)),
        price: 120.0,
        status: QuotationStatus.readyToPay,
        coverageDetails: [
          'Third Party Property Damage',
          'Third Party Bodily Injury',
          'Loss or Damage of Vehicle',
          'Emergency Treatment',
          'Road Assistance Service Agency',
          'Repair',
        ],
      ),
      QuotationModel(
        id: '2',
        policyNumber: 'QT0001121AA01010',
        companyName: 'SAT Insurance',
        vehicleNumber: '88456',
        requestDate: DateTime.now().subtract(const Duration(days: 5)),
        price: 150.0,
        status: QuotationStatus.inProgress,
        coverageDetails: [
          'Comprehensive Coverage',
          'Personal Accident Cover',
          'Natural Disaster Protection',
        ],
      ),
      QuotationModel(
        id: '3',
        policyNumber: 'QT0001121AA01011',
        companyName: 'GTC Insurance',
        vehicleNumber: '99789',
        requestDate: DateTime.now().subtract(const Duration(days: 15)),
        price: 135.0,
        status: QuotationStatus.expired,
        coverageDetails: [
          'Third Party Coverage',
          'Vehicle Damage Protection',
          'Passenger Insurance',
        ],
      ),
      QuotationModel(
        id: '4',
        policyNumber: 'QT0001121AA01012',
        companyName: 'TYR Insurance',
        vehicleNumber: '12345',
        requestDate: DateTime.now().subtract(const Duration(days: 1)),
        price: 180.0,
        status: QuotationStatus.pending,
        coverageDetails: [
          'Full Comprehensive Coverage',
          'Roadside Assistance',
          'Replacement Car',
          'Personal Effects Coverage',
        ],
      ),
    ];
    
    if (quotations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: 80,
              color: AppColors.textLight,
            ),
            const SizedBox(height: 16),
            const Text(
              'No quotations found',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Get New Quote',
              onPressed: () {
                // Navigate to get new quote
              },
              width: 200,
              isFullWidth: false,
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: quotations.length,
      itemBuilder: (context, index) {
        final quotation = quotations[index];
        return _buildQuotationCard(quotation);
      },
    );
  }
  
  Widget _buildQuotationCard(QuotationModel quotation) {
    // Get status color and text
    Color statusColor;
    String statusText;
    IconData statusIcon;
    bool showActionButton = true;
    String actionButtonText = '';
    
    switch (quotation.status) {
      case QuotationStatus.pending:
        statusColor = Colors.orange;
        statusText = 'Pending';
        statusIcon = Icons.hourglass_empty;
        actionButtonText = 'View Details';
        break;
      case QuotationStatus.readyToPay:
        statusColor = Colors.green;
        statusText = 'Ready to Pay';
        statusIcon = Icons.payment;
        actionButtonText = 'Pay Now';
        break;
      case QuotationStatus.inProgress:
        statusColor = Colors.blue;
        statusText = 'In Progress';
        statusIcon = Icons.sync;
        actionButtonText = 'View Details';
        break;
      case QuotationStatus.expired:
        statusColor = Colors.red;
        statusText = 'Expired';
        statusIcon = Icons.timer_off;
        showActionButton = false;
        break;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondaryDark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.description,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quote No: ${quotation.policyNumber}',
                        style: const TextStyle(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Company: ${quotation.companyName}',
                        style: TextStyle(
                          color: AppColors.primaryDark.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: statusColor),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        statusIcon,
                        size: 14,
                        color: statusColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.directions_car,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Vehicle number: ${quotation.vehicleNumber}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Request Date: ${quotation.requestDate.day}/${quotation.requestDate.month}/${quotation.requestDate.year}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Coverage:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...quotation.coverageDetails!.map((coverage) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(coverage),
                      ),
                    ],
                  ),
                )).toList(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${quotation.price.toStringAsFixed(2)} BHD',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    if (showActionButton) ...[  
                      CustomButton(
                        text: actionButtonText,
                        onPressed: () {
                          // Navigate to quotation details or payment
                        },
                        type: quotation.status == QuotationStatus.readyToPay ? ButtonType.primary : ButtonType.outline,
                        isFullWidth: false,
                        height: 40,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPolicyCard(PolicyModel policy) {
    final bool isExpiring = policy.daysUntilExpiry < 30 && policy.daysUntilExpiry >= 0;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.directions_car,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Policy No: ${policy.policyNumber}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Name: ${policy.name}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.directions_car,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Vehicle number: ${policy.vehicleNumber}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Expiry Date: ${policy.expiryDate.day}/${policy.expiryDate.month}/${policy.expiryDate.year}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isExpiring ? AppColors.warning : null,
                      ),
                    ),
                  ],
                ),
                if (isExpiring) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Expires in ${policy.daysUntilExpiry} days',
                      style: const TextStyle(
                        color: AppColors.warning,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                const Text(
                  'Coverage:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...policy.coverageDetails!.map((coverage) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(coverage),
                      ),
                    ],
                  ),
                )).toList(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Premium',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '\$${policy.premium.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    if (policy.status == PolicyStatus.active) ...[
                      CustomButton(
                        text: isExpiring ? 'Renew Now' : 'View Details',
                        onPressed: () {
                          // Navigate to policy details or renewal
                        },
                        type: isExpiring ? ButtonType.primary : ButtonType.outline,
                        isFullWidth: false,
                        height: 40,
                      ),
                    ] else ...[
                      CustomButton(
                        text: 'View History',
                        onPressed: () {
                          // Navigate to policy history
                        },
                        type: ButtonType.outline,
                        isFullWidth: false,
                        height: 40,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
