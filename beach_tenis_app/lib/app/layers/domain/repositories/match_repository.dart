import 'package:apex_sports/app/layers/domain/entities/match_entity.dart';

abstract class IMatchRepository {
  Future<MatchEntity?> getMatchById(String id);
  Future<List<MatchEntity>> getMatchesByDemandante(String demandanteId);
  Future<List<MatchEntity>> getMatchesByDonor(String donorId);
  Future<List<MatchEntity>> getPendingMatches(String userId);
  Future<List<MatchEntity>> getActiveMatches(String userId);
  Future<MatchEntity> createMatch(MatchEntity match);
  Future<MatchEntity> updateMatchStatus(String matchId, String status);
  Future<void> deleteMatch(String id);
  Future<double> calculateCompatibilityScore(String demandanteId, String donorId);
}
