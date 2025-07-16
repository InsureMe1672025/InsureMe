class CompanyModel {
  final String id;
  final String name;
  final String logo;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> insuranceTypes;
  final String? website;
  final String? phone;
  final String? email;
  final String? address;

  CompanyModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.insuranceTypes,
    this.website,
    this.phone,
    this.email,
    this.address,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      description: json['description'] ?? '',
      insuranceTypes: json['insurance_types'] != null
          ? List<String>.from(json['insurance_types'])
          : [],
      website: json['website'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'rating': rating,
      'review_count': reviewCount,
      'description': description,
      'insurance_types': insuranceTypes,
      'website': website,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }
}
