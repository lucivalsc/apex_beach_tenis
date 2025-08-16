import 'package:beach_tenis_app/app/layers/domain/entities/donor_profile_entity.dart';

abstract class IDonorRepository {
  Future<DonorProfileEntity?> getDonorProfile(String userId);
  Future<List<DonorProfileEntity>> getAllDonors();
  Future<List<DonorProfileEntity>> getAvailableDonors();
  Future<List<DonorProfileEntity>> searchDonors({
    int? minAge,
    int? maxAge,
    String? bloodType,
    String? education,
    String? eyeColor,
    String? hairColor,
    String? skinColor,
  });
  Future<DonorProfileEntity> createDonorProfile(DonorProfileEntity profile);
  Future<DonorProfileEntity> updateDonorProfile(DonorProfileEntity profile);
  Future<void> deleteDonorProfile(String userId);
  Future<void> updateAvailability(String userId, bool isAvailable);
}
