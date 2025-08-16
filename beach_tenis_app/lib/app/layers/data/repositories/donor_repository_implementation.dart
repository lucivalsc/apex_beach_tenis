import 'package:beach_tenis_app/app/layers/data/datasources/remote/remote_data_datasource.dart';
import 'package:beach_tenis_app/app/layers/domain/entities/donor_profile_entity.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/donor_repository.dart';

class DonorRepositoryImplementation implements IDonorRepository {
  final IRemoteDataDatasource remoteDataSource;

  DonorRepositoryImplementation(this.remoteDataSource);

  @override
  Future<DonorProfileEntity?> getDonorProfile(String userId) async {
    try {
      final response = await remoteDataSource.getDonors();
      if (response['success'] == true) {
        final donors = response['data'] as List;
        final donorData = donors.firstWhere(
          (donor) => donor['userId'] == userId,
          orElse: () => null,
        );

        if (donorData != null) {
          return DonorProfileEntity.fromJson(donorData);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao buscar perfil do doador: $e');
    }
  }

  @override
  Future<List<DonorProfileEntity>> getAllDonors() async {
    try {
      final response = await remoteDataSource.getDonors();
      if (response['success'] == true) {
        final donors = response['data'] as List;
        return donors.map((donorData) => DonorProfileEntity.fromJson(donorData)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar doadores: $e');
    }
  }

  @override
  Future<List<DonorProfileEntity>> getAvailableDonors() async {
    try {
      final response = await remoteDataSource.getDonors();
      if (response['success'] == true) {
        final donors = response['data'] as List;
        final availableDonors = donors.where((donor) => donor['isAvailable'] == true).toList();
        return availableDonors.map((donorData) => DonorProfileEntity.fromJson(donorData)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar doadores disponíveis: $e');
    }
  }

  @override
  Future<List<DonorProfileEntity>> searchDonors({
    int? minAge,
    int? maxAge,
    String? bloodType,
    String? education,
    String? eyeColor,
    String? hairColor,
    String? skinColor,
  }) async {
    try {
      final filters = <String, dynamic>{};
      if (minAge != null) filters['minAge'] = minAge;
      if (maxAge != null) filters['maxAge'] = maxAge;
      if (bloodType != null) filters['bloodType'] = bloodType;
      if (education != null) filters['education'] = education;
      if (eyeColor != null) filters['eyeColor'] = eyeColor;
      if (hairColor != null) filters['hairColor'] = hairColor;
      if (skinColor != null) filters['skinColor'] = skinColor;

      final response = await remoteDataSource.searchDonors(filters);
      if (response['success'] == true) {
        final donors = response['data'] as List;
        return donors.map((donorData) => DonorProfileEntity.fromJson(donorData)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar doadores com filtros: $e');
    }
  }

  @override
  Future<DonorProfileEntity> createDonorProfile(DonorProfileEntity profile) async {
    try {
      // Em uma implementação real, isso faria uma chamada POST para criar o perfil
      // Por enquanto, retornamos o perfil como foi criado
      await Future.delayed(const Duration(milliseconds: 300));
      return profile;
    } catch (e) {
      throw Exception('Erro ao criar perfil do doador: $e');
    }
  }

  @override
  Future<DonorProfileEntity> updateDonorProfile(DonorProfileEntity profile) async {
    try {
      // Em uma implementação real, isso faria uma chamada PUT para atualizar o perfil
      await Future.delayed(const Duration(milliseconds: 250));
      return profile;
    } catch (e) {
      throw Exception('Erro ao atualizar perfil do doador: $e');
    }
  }

  @override
  Future<void> deleteDonorProfile(String userId) async {
    try {
      // Em uma implementação real, isso faria uma chamada DELETE
      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e) {
      throw Exception('Erro ao deletar perfil do doador: $e');
    }
  }

  @override
  Future<void> updateAvailability(String userId, bool isAvailable) async {
    try {
      // Em uma implementação real, isso faria uma chamada PATCH para atualizar disponibilidade
      await Future.delayed(const Duration(milliseconds: 150));
    } catch (e) {
      throw Exception('Erro ao atualizar disponibilidade do doador: $e');
    }
  }
}
