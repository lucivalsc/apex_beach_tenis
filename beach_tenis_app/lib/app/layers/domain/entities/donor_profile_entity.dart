class DonorProfileEntity {
  final String id;
  final String userId;
  final double height;
  final double weight;
  final String bloodType;
  final String education;
  final String profession;
  final String eyeColor;
  final String hairColor;
  final String skinColor;
  final List<String> hobbies;
  final String motivationLetter;
  final List<String> medicalExams;
  final bool isAvailable;
  final int totalDonations;
  final double rating;
  final DateTime lastMedicalCheckup;
  
  // Campos adicionais necessários para a UI
  final String firstName;
  final String lastName;
  final int age;
  final String ethnicity;
  final String medicalHistory;
  final bool isVerified;

  const DonorProfileEntity({
    required this.id,
    required this.userId,
    required this.height,
    required this.weight,
    required this.bloodType,
    required this.education,
    required this.profession,
    required this.eyeColor,
    required this.hairColor,
    required this.skinColor,
    required this.hobbies,
    required this.motivationLetter,
    required this.medicalExams,
    required this.isAvailable,
    required this.totalDonations,
    required this.rating,
    required this.lastMedicalCheckup,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.ethnicity,
    required this.medicalHistory,
    required this.isVerified,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'height': height,
      'weight': weight,
      'bloodType': bloodType,
      'education': education,
      'profession': profession,
      'eyeColor': eyeColor,
      'hairColor': hairColor,
      'skinColor': skinColor,
      'hobbies': hobbies,
      'motivationLetter': motivationLetter,
      'medicalExams': medicalExams,
      'isAvailable': isAvailable,
      'totalDonations': totalDonations,
      'rating': rating,
      'lastMedicalCheckup': lastMedicalCheckup.toIso8601String(),
    };
  }

  factory DonorProfileEntity.fromJson(Map<String, dynamic> json) {
    // Extração segura de nome completo para firstName e lastName
    String fullName = json['name'] ?? '';
    List<String> nameParts = fullName.split(' ');
    String firstName = json['firstName'] ?? (nameParts.isNotEmpty ? nameParts.first : 'Nome');
    String lastName = json['lastName'] ?? (nameParts.length > 1 ? nameParts.last : 'Sobrenome');

    // Conversão segura para double com valores padrão
    double height = 0.0;
    try {
      height = json['height'] == null ? 1.75 : (json['height'] is int ? (json['height'] as int).toDouble() : json['height'].toDouble());
    } catch (e) {
      height = 1.75; // Valor padrão em caso de erro
    }

    double weight = 0.0;
    try {
      weight = json['weight'] == null ? 70.0 : (json['weight'] is int ? (json['weight'] as int).toDouble() : json['weight'].toDouble());
    } catch (e) {
      weight = 70.0; // Valor padrão em caso de erro
    }

    double rating = 0.0;
    try {
      rating = json['rating'] == null ? 4.5 : (json['rating'] is int ? (json['rating'] as int).toDouble() : json['rating'].toDouble());
    } catch (e) {
      rating = 4.5; // Valor padrão em caso de erro
    }

    // Conversão segura para listas
    List<String> hobbies = [];
    if (json['hobbies'] != null) {
      try {
        hobbies = List<String>.from(json['hobbies']);
      } catch (e) {
        hobbies = ['Leitura', 'Esportes']; // Valores padrão em caso de erro
      }
    } else {
      hobbies = ['Leitura', 'Esportes']; // Valores padrão se ausente
    }

    List<String> medicalExams = [];
    if (json['medicalExams'] != null) {
      try {
        medicalExams = List<String>.from(json['medicalExams']);
      } catch (e) {
        medicalExams = ['Exame de sangue - Normal']; // Valores padrão em caso de erro
      }
    } else {
      medicalExams = ['Exame de sangue - Normal']; // Valores padrão se ausente
    }

    // Data segura
    DateTime lastMedicalCheckup;
    try {
      lastMedicalCheckup = json['lastMedicalCheckup'] != null 
          ? DateTime.parse(json['lastMedicalCheckup'])
          : DateTime.now().subtract(const Duration(days: 30));
    } catch (e) {
      lastMedicalCheckup = DateTime.now().subtract(const Duration(days: 30));
    }

    return DonorProfileEntity(
      id: json['id'] ?? json['userId'] ?? '',
      userId: json['userId'] ?? '',
      height: height,
      weight: weight,
      bloodType: json['bloodType'] ?? 'O+',
      education: json['education'] ?? 'Ensino Superior',
      profession: json['profession'] ?? 'Profissional',
      eyeColor: json['eyeColor'] ?? 'Castanho',
      hairColor: json['hairColor'] ?? 'Preto',
      skinColor: json['skinColor'] ?? 'Moreno',
      hobbies: hobbies,
      motivationLetter: json['motivationLetter'] ?? 'Desejo ajudar famílias a realizarem o sonho de ter filhos.',
      medicalExams: medicalExams,
      isAvailable: json['isAvailable'] ?? true,
      totalDonations: json['totalDonations'] ?? 0,
      rating: rating,
      firstName: firstName,
      lastName: lastName,
      age: json['age'] ?? 30,
      ethnicity: json['ethnicity'] ?? 'Não informado',
      medicalHistory: json['medicalHistory'] ?? 'Sem histórico médico registrado',
      isVerified: json['isVerified'] ?? false,
      lastMedicalCheckup: lastMedicalCheckup,
    );
  }
}
