class Policy {
  final String policyNumber;
  final String name;
  final String vehicleNumber;
  final String expiryDate;
  final List<String> coverageDetails;

  Policy({
    required this.policyNumber,
    required this.name,
    required this.vehicleNumber,
    required this.expiryDate,
    required this.coverageDetails,
  });
}
