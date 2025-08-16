class UserEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime birthDate;
  final String gender;
  final String userType; // 'demandante' ou 'doador'
  final String? profileImageUrl;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.userType,
    this.profileImageUrl,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
      'userType': userType,
      'profileImageUrl': profileImageUrl,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      birthDate: DateTime.parse(json['birthDate']),
      gender: json['gender'],
      userType: json['userType'],
      profileImageUrl: json['profileImageUrl'],
      isVerified: json['isVerified'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
