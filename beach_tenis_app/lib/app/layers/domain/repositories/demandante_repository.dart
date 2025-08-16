import 'package:beach_tenis_app/app/layers/domain/entities/demandante_profile_entity.dart';

abstract class IDemandanteRepository {
  Future<DemandanteProfileEntity?> getDemandanteProfile(String userId);
  Future<List<DemandanteProfileEntity>> getAllDemandantes();
  Future<List<DemandanteProfileEntity>> getActivelySearchingDemandantes();
  Future<DemandanteProfileEntity> createDemandanteProfile(DemandanteProfileEntity profile);
  Future<DemandanteProfileEntity> updateDemandanteProfile(DemandanteProfileEntity profile);
  Future<void> deleteDemandanteProfile(String userId);
  Future<void> updateSearchStatus(String userId, bool isActivelySearching);
}
