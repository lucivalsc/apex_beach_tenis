class DemandanteProfileEntity {
  final String userId;
  final String relationshipStatus;
  final String partnerName;
  final String reasonForDonation;
  final int preferredAgeMin;
  final int preferredAgeMax;
  final String? preferredEducation;
  final String? preferredBloodType;
  final String? preferredEyeColor;
  final String? preferredHairColor;
  final String? preferredSkinColor;
  final List<String> importantCharacteristics;
  final String additionalNotes;
  final bool isActivelySearching;
  final DateTime lastActivity;

  const DemandanteProfileEntity({
    required this.userId,
    required this.relationshipStatus,
    required this.partnerName,
    required this.reasonForDonation,
    required this.preferredAgeMin,
    required this.preferredAgeMax,
    this.preferredEducation,
    this.preferredBloodType,
    this.preferredEyeColor,
    this.preferredHairColor,
    this.preferredSkinColor,
    required this.importantCharacteristics,
    required this.additionalNotes,
    required this.isActivelySearching,
    required this.lastActivity,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'relationshipStatus': relationshipStatus,
      'partnerName': partnerName,
      'reasonForDonation': reasonForDonation,
      'preferredAgeMin': preferredAgeMin,
      'preferredAgeMax': preferredAgeMax,
      'preferredEducation': preferredEducation,
      'preferredBloodType': preferredBloodType,
      'preferredEyeColor': preferredEyeColor,
      'preferredHairColor': preferredHairColor,
      'preferredSkinColor': preferredSkinColor,
      'importantCharacteristics': importantCharacteristics,
      'additionalNotes': additionalNotes,
      'isActivelySearching': isActivelySearching,
      'lastActivity': lastActivity.toIso8601String(),
    };
  }

  factory DemandanteProfileEntity.fromJson(Map<String, dynamic> json) {
    return DemandanteProfileEntity(
      userId: json['userId'],
      relationshipStatus: json['relationshipStatus'],
      partnerName: json['partnerName'],
      reasonForDonation: json['reasonForDonation'],
      preferredAgeMin: json['preferredAgeMin'],
      preferredAgeMax: json['preferredAgeMax'],
      preferredEducation: json['preferredEducation'],
      preferredBloodType: json['preferredBloodType'],
      preferredEyeColor: json['preferredEyeColor'],
      preferredHairColor: json['preferredHairColor'],
      preferredSkinColor: json['preferredSkinColor'],
      importantCharacteristics: List<String>.from(json['importantCharacteristics']),
      additionalNotes: json['additionalNotes'],
      isActivelySearching: json['isActivelySearching'],
      lastActivity: DateTime.parse(json['lastActivity']),
    );
  }
}
