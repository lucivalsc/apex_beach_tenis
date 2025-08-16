class MatchEntity {
  final String id;
  final String demandanteId;
  final String donorId;
  final String status; // 'pending', 'accepted', 'rejected', 'completed'
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? completedAt;
  final double compatibilityScore;
  final String? notes;
  final bool isActive;

  const MatchEntity({
    required this.id,
    required this.demandanteId,
    required this.donorId,
    required this.status,
    required this.createdAt,
    this.acceptedAt,
    this.completedAt,
    required this.compatibilityScore,
    this.notes,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'demandanteId': demandanteId,
      'donorId': donorId,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'acceptedAt': acceptedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'compatibilityScore': compatibilityScore,
      'notes': notes,
      'isActive': isActive,
    };
  }

  factory MatchEntity.fromJson(Map<String, dynamic> json) {
    return MatchEntity(
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
}
