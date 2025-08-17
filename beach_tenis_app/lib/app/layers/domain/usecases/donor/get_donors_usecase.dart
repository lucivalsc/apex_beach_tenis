import 'package:apex_sports/app/layers/domain/entities/donor_profile_entity.dart';
import 'package:apex_sports/app/layers/domain/repositories/donor_repository.dart';

class GetDonorsUseCase {
  final IDonorRepository repository;

  GetDonorsUseCase(this.repository);

  Future<List<DonorProfileEntity>> call() async {
    return await repository.getAllDonors();
  }
}

class GetAvailableDonorsUseCase {
  final IDonorRepository repository;

  GetAvailableDonorsUseCase(this.repository);

  Future<List<DonorProfileEntity>> call() async {
    return await repository.getAvailableDonors();
  }
}

class SearchDonorsUseCase {
  final IDonorRepository repository;

  SearchDonorsUseCase(this.repository);

  Future<List<DonorProfileEntity>> call({
    int? minAge,
    int? maxAge,
    String? bloodType,
    String? education,
    String? eyeColor,
    String? hairColor,
    String? skinColor,
  }) async {
    return await repository.searchDonors(
      minAge: minAge,
      maxAge: maxAge,
      bloodType: bloodType,
      education: education,
      eyeColor: eyeColor,
      hairColor: hairColor,
      skinColor: skinColor,
    );
  }
}
