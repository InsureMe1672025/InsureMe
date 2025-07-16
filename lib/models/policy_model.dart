class PolicyModel {
  final String id;
  final String policyNumber;
  final String name;
  final String companyId;
  final String companyName;
  final String companyLogo;
  final String vehicleNumber;
  final DateTime startDate;
  final DateTime expiryDate;
  final PolicyType type;
  final PolicyStatus status;
  final double premium;
  final String? description;
  final List<String>? coverageDetails;

  PolicyModel({
    required this.id,
    required this.policyNumber,
    required this.name,
    required this.companyId,
    required this.companyName,
    required this.companyLogo,
    required this.vehicleNumber,
    required this.startDate,
    required this.expiryDate,
    required this.type,
    required this.status,
    required this.premium,
    this.description,
    this.coverageDetails,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      id: json['id'] ?? '',
      policyNumber: json['policy_number'] ?? '',
      name: json['name'] ?? '',
      companyId: json['company_id'] ?? '',
      companyName: json['company_name'] ?? '',
      companyLogo: json['company_logo'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      expiryDate: DateTime.parse(json['expiry_date']),
      type: _parsePolicyType(json['type']),
      status: _parsePolicyStatus(json['status']),
      premium: (json['premium'] ?? 0).toDouble(),
      description: json['description'],
      coverageDetails: json['coverage_details'] != null
          ? List<String>.from(json['coverage_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'policy_number': policyNumber,
      'name': name,
      'company_id': companyId,
      'company_name': companyName,
      'company_logo': companyLogo,
      'vehicle_number': vehicleNumber,
      'start_date': startDate.toIso8601String(),
      'expiry_date': expiryDate.toIso8601String(),
      'type': type.name,
      'status': status.name,
      'premium': premium,
      'description': description,
      'coverage_details': coverageDetails,
    };
  }

  static PolicyType _parsePolicyType(dynamic type) {
    if (type == null) return PolicyType.vehicle;
    
    if (type is String) {
      switch (type.toLowerCase()) {
        case 'vehicle':
          return PolicyType.vehicle;
        case 'health':
          return PolicyType.health;
        case 'property':
          return PolicyType.property;
        case 'travel':
          return PolicyType.travel;
        case 'life':
          return PolicyType.life;
        default:
          return PolicyType.vehicle;
      }
    }
    
    return PolicyType.vehicle;
  }

  static PolicyStatus _parsePolicyStatus(dynamic status) {
    if (status == null) return PolicyStatus.active;
    
    if (status is String) {
      switch (status.toLowerCase()) {
        case 'active':
          return PolicyStatus.active;
        case 'expired':
          return PolicyStatus.expired;
        case 'pending':
          return PolicyStatus.pending;
        case 'cancelled':
          return PolicyStatus.cancelled;
        default:
          return PolicyStatus.active;
      }
    }
    
    return PolicyStatus.active;
  }

  bool get isExpired {
    return DateTime.now().isAfter(expiryDate);
  }

  int get daysUntilExpiry {
    return expiryDate.difference(DateTime.now()).inDays;
  }
}

enum PolicyType {
  vehicle,
  health,
  property,
  travel,
  life,
}

enum PolicyStatus {
  active,
  expired,
  pending,
  cancelled,
}
