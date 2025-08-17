// Modelos de dados para a camada de dados do Fertilink
// Estes modelos fazem a ponte entre os dados JSON e as entidades do domínio

import 'package:apex_sports/app/layers/domain/entities/donor_profile_entity.dart';
import 'package:apex_sports/layers/domain/entities/match_entity.dart';
import 'package:apex_sports/layers/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.birthDate,
    required super.gender,
    required super.userType,
    super.profileImageUrl,
    required super.isVerified,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      birthDate: birthDate,
      gender: gender,
      userType: userType,
      profileImageUrl: profileImageUrl,
      isVerified: isVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class DonorProfileModel extends DonorProfileEntity {
  const DonorProfileModel({
    required super.id,
    required super.userId,
    required super.height,
    required super.weight,
    required super.bloodType,
    required super.education,
    required super.profession,
    required super.eyeColor,
    required super.hairColor,
    required super.skinColor,
    required super.hobbies,
    required super.motivationLetter,
    required super.medicalExams,
    required super.isAvailable,
    required super.totalDonations,
    required super.rating,
    required super.lastMedicalCheckup,
    required super.firstName,
    required super.lastName,
    required super.age,
    required super.ethnicity,
    required super.medicalHistory,
    required super.isVerified,
  });

  factory DonorProfileModel.fromJson(Map<String, dynamic> json) {
    return DonorProfileModel(
      id: json['id'] ?? json['userId'], // Fallback para compatibilidade
      userId: json['userId'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      bloodType: json['bloodType'],
      education: json['education'],
      profession: json['profession'],
      eyeColor: json['eyeColor'],
      hairColor: json['hairColor'],
      skinColor: json['skinColor'],
      hobbies: List<String>.from(json['hobbies']),
      motivationLetter: json['motivationLetter'],
      medicalExams: List<String>.from(json['medicalExams']),
      isAvailable: json['isAvailable'],
      totalDonations: json['totalDonations'],
      rating: json['rating'].toDouble(),
      lastMedicalCheckup: DateTime.parse(json['lastMedicalCheckup']),
      firstName: json['firstName'] ?? (json['name'] != null ? json['name'].toString().split(' ').first : ''),
      lastName: json['lastName'] ??
          (json['name'] != null && json['name'].toString().split(' ').length > 1
              ? json['name'].toString().split(' ').skip(1).join(' ')
              : ''),
      age: json['age'] ?? 30, // Valor padrão
      ethnicity: json['ethnicity'] ?? 'Não informado',
      medicalHistory: json['medicalHistory'] ?? '',
      isVerified: json['isVerified'] ?? false,
    );
  }

  DonorProfileEntity toEntity() {
    return DonorProfileEntity(
      id: id,
      userId: userId,
      height: height,
      weight: weight,
      bloodType: bloodType,
      education: education,
      profession: profession,
      eyeColor: eyeColor,
      hairColor: hairColor,
      skinColor: skinColor,
      hobbies: hobbies,
      motivationLetter: motivationLetter,
      medicalExams: medicalExams,
      isAvailable: isAvailable,
      totalDonations: totalDonations,
      rating: rating,
      lastMedicalCheckup: lastMedicalCheckup,
      firstName: firstName,
      lastName: lastName,
      age: age,
      ethnicity: ethnicity,
      medicalHistory: medicalHistory,
      isVerified: isVerified,
    );
  }
}

class MatchModel extends MatchEntity {
  const MatchModel({
    required super.id,
    required super.demandanteId,
    required super.donorId,
    required super.status,
    required super.createdAt,
    super.acceptedAt,
    super.completedAt,
    required super.compatibilityScore,
    super.notes,
    required super.isActive,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'],
      demandanteId: json['demandanteId'],
      donorId: json['donorId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      acceptedAt: json['acceptedAt'] != null ? DateTime.parse(json['acceptedAt']) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      compatibilityScore: json['compatibilityScore'].toDouble(),
      notes: json['notes'],
      isActive: json['isActive'],
    );
  }

  MatchEntity toEntity() {
    return MatchEntity(
      id: id,
      demandanteId: demandanteId,
      donorId: donorId,
      status: status,
      createdAt: createdAt,
      acceptedAt: acceptedAt,
      completedAt: completedAt,
      compatibilityScore: compatibilityScore,
      notes: notes,
      isActive: isActive,
    );
  }
}
