import 'package:beach_tenis_app/app/layers/data/datasources/remote/remote_data_datasource.dart';
import 'package:beach_tenis_app/app/layers/domain/entities/demandante_profile_entity.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/demandante_repository.dart';

class DemandanteRepositoryImplementation implements IDemandanteRepository {
  final IRemoteDataDatasource remoteDataSource;

  DemandanteRepositoryImplementation(this.remoteDataSource);

  @override
  Future<DemandanteProfileEntity?> getDemandanteProfile(String userId) async {
    try {
      final demandanteData = await remoteDataSource.getDemandanteProfile(userId);
      if (demandanteData != null) {
        return DemandanteProfileEntity.fromJson(demandanteData);
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao carregar perfil de demandante: ${e.toString()}');
    }
  }

  @override
  Future<List<DemandanteProfileEntity>> getAllDemandantes() async {
    try {
      final demandantesData = await remoteDataSource.getAllDemandantes();
      return demandantesData.map((data) => DemandanteProfileEntity.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Erro ao carregar demandantes: ${e.toString()}');
    }
  }

  @override
  Future<List<DemandanteProfileEntity>> getActivelySearchingDemandantes() async {
    try {
      final demandantesData = await remoteDataSource.getActivelySearchingDemandantes();
      return demandantesData.map((data) => DemandanteProfileEntity.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Erro ao carregar demandantes em busca ativa: ${e.toString()}');
    }
  }

  @override
  Future<DemandanteProfileEntity> createDemandanteProfile(DemandanteProfileEntity profile) async {
    try {
      final data = await remoteDataSource.createDemandanteProfile(profile.toJson());
      return DemandanteProfileEntity.fromJson(data);
    } catch (e) {
      throw Exception('Erro ao criar perfil de demandante: ${e.toString()}');
    }
  }

  @override
  Future<DemandanteProfileEntity> updateDemandanteProfile(DemandanteProfileEntity profile) async {
    try {
      final data = await remoteDataSource.updateDemandanteProfile(profile.toJson());
      return DemandanteProfileEntity.fromJson(data);
    } catch (e) {
      throw Exception('Erro ao atualizar perfil de demandante: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteDemandanteProfile(String userId) async {
    try {
      await remoteDataSource.deleteDemandanteProfile(userId);
    } catch (e) {
      throw Exception('Erro ao excluir perfil de demandante: ${e.toString()}');
    }
  }

  @override
  Future<void> updateSearchStatus(String userId, bool isActivelySearching) async {
    try {
      await remoteDataSource.updateDemandanteSearchStatus(userId, isActivelySearching);
    } catch (e) {
      throw Exception('Erro ao atualizar status de busca: ${e.toString()}');
    }
  }
}
