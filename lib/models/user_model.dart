class UserModel {
  final String id;
  final String cpr;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final String? profileImage;
  final String? address;
  final String? dateOfBirth;
  final String? nationality;
  final String? passportNumber;
  final String? gender;

  UserModel({
    required this.id,
    required this.cpr,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.profileImage,
    this.address,
    this.dateOfBirth,
    this.nationality,
    this.passportNumber,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      cpr: json['cpr'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: _parseRole(json['role']),
      profileImage: json['profile_image'],
      address: json['address'],
      dateOfBirth: json['date_of_birth'],
      nationality: json['nationality'],
      passportNumber: json['passport_number'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cpr': cpr,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.name,
      'profile_image': profileImage,
      'address': address,
      'date_of_birth': dateOfBirth,
      'nationality': nationality,
      'passport_number': passportNumber,
      'gender': gender,
    };
  }

  static UserRole _parseRole(dynamic role) {
    if (role == null) return UserRole.customer;
    
    if (role is String) {
      switch (role.toLowerCase()) {
        case 'admin':
          return UserRole.admin;
        case 'agent':
          return UserRole.agent;
        case 'customer':
          return UserRole.customer;
        default:
          return UserRole.customer;
      }
    }
    
    return UserRole.customer;
  }

  UserModel copyWith({
    String? id,
    String? cpr,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    String? profileImage,
    String? address,
    String? dateOfBirth,
    String? nationality,
    String? passportNumber,
    String? gender,
  }) {
    return UserModel(
      id: id ?? this.id,
      cpr: cpr ?? this.cpr,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nationality: nationality ?? this.nationality,
      passportNumber: passportNumber ?? this.passportNumber,
      gender: gender ?? this.gender,
    );
  }
}

enum UserRole {
  customer,
  agent,
  admin,
}
