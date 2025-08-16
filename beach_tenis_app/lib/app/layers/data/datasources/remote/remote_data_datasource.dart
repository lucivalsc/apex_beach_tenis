
abstract class IRemoteDataDatasource {
  Future<List<Object>> datas(List<Object> objects);
  Future<List<Object>> getSyncDatas(List<Object> objects);
  
  // Métodos específicos do Fertilink
  Future<Map<String, dynamic>> getUsers();
  Future<Map<String, dynamic>> getDonors();
  Future<Map<String, dynamic>> getDemandantes();
  Future<Map<String, dynamic>> getMatches(String userId);
  Future<Map<String, dynamic>> getChatMessages(String matchId);
  Future<Map<String, dynamic>> searchDonors(Map<String, dynamic> filters);
  Future<Map<String, dynamic>> createMatch(Map<String, dynamic> matchData);
  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> messageData);
  
  // Métodos específicos para Demandante
  Future<Map<String, dynamic>?> getDemandanteProfile(String userId);
  Future<List<Map<String, dynamic>>> getAllDemandantes();
  Future<List<Map<String, dynamic>>> getActivelySearchingDemandantes();
  Future<Map<String, dynamic>> createDemandanteProfile(Map<String, dynamic> profile);
  Future<Map<String, dynamic>> updateDemandanteProfile(Map<String, dynamic> profile);
  Future<void> deleteDemandanteProfile(String userId);
  Future<void> updateDemandanteSearchStatus(String userId, bool isActivelySearching);
}
