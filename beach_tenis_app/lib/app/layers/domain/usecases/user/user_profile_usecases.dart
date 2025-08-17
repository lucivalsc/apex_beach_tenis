import 'package:apex_sports/app/layers/domain/entities/demandante_profile_entity.dart';
import 'package:apex_sports/layers/domain/entities/donor_profile_entity.dart';
import 'package:apex_sports/layers/domain/entities/user_entity.dart';
import 'package:apex_sports/layers/domain/repositories/demandante_repository.dart';
import 'package:apex_sports/layers/domain/repositories/donor_repository.dart';
import 'package:apex_sports/layers/domain/repositories/user_repository.dart';

class GetUserProfileUseCase {
  final IUserRepository userRepository;
  final IDonorRepository donorRepository;
  final IDemandanteRepository demandanteRepository;

  GetUserProfileUseCase(
    this.userRepository,
    this.donorRepository,
    this.demandanteRepository,
  );

  Future<Map<String, dynamic>> call(String userId) async {
    final user = await userRepository.getUserById(userId);
    if (user == null) {
      throw Exception('Usuário não encontrado');
    }

    Map<String, dynamic> profile = {
      'user': user,
    };

    if (user.userType == 'doador') {
      final donorProfile = await donorRepository.getDonorProfile(userId);
      profile['donorProfile'] = donorProfile;
    } else if (user.userType == 'demandante') {
      final demandanteProfile = await demandanteRepository.getDemandanteProfile(userId);
      profile['demandanteProfile'] = demandanteProfile;
    }

    return profile;
  }
}

class UpdateUserProfileUseCase {
  final IUserRepository userRepository;
  final IDonorRepository donorRepository;
  final IDemandanteRepository demandanteRepository;

  UpdateUserProfileUseCase(
    this.userRepository,
    this.donorRepository,
    this.demandanteRepository,
  );

  Future<UserEntity> call(UserEntity user) async {
    return await userRepository.updateUser(user);
  }
}

class CreateDonorProfileUseCase {
  final IDonorRepository repository;

  CreateDonorProfileUseCase(this.repository);

  Future<DonorProfileEntity> call(DonorProfileEntity profile) async {
    return await repository.createDonorProfile(profile);
  }
}

class CreateDemandanteProfileUseCase {
  final IDemandanteRepository repository;

  CreateDemandanteProfileUseCase(this.repository);

  Future<DemandanteProfileEntity> call(DemandanteProfileEntity profile) async {
    return await repository.createDemandanteProfile(profile);
  }
}
