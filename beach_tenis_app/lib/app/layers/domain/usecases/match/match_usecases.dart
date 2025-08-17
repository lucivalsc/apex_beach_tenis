import 'package:apex_sports/app/layers/domain/entities/match_entity.dart';
import 'package:apex_sports/layers/domain/repositories/match_repository.dart';

class GetMatchesUseCase {
  final IMatchRepository repository;

  GetMatchesUseCase(this.repository);

  Future<List<MatchEntity>> call(String userId) async {
    return await repository.getActiveMatches(userId);
  }
}

class GetPendingMatchesUseCase {
  final IMatchRepository repository;

  GetPendingMatchesUseCase(this.repository);

  Future<List<MatchEntity>> call(String userId) async {
    return await repository.getPendingMatches(userId);
  }
}

class CreateMatchUseCase {
  final IMatchRepository repository;

  CreateMatchUseCase(this.repository);

  Future<MatchEntity> call(String demandanteId, String donorId) async {
    final compatibilityScore = await repository.calculateCompatibilityScore(
      demandanteId,
      donorId,
    );

    final match = MatchEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      demandanteId: demandanteId,
      donorId: donorId,
      status: 'pending',
      createdAt: DateTime.now(),
      compatibilityScore: compatibilityScore,
      isActive: true,
    );

    return await repository.createMatch(match);
  }
}

class AcceptMatchUseCase {
  final IMatchRepository repository;

  AcceptMatchUseCase(this.repository);

  Future<MatchEntity> call(String matchId) async {
    return await repository.updateMatchStatus(matchId, 'accepted');
  }
}

class RejectMatchUseCase {
  final IMatchRepository repository;

  RejectMatchUseCase(this.repository);

  Future<MatchEntity> call(String matchId) async {
    return await repository.updateMatchStatus(matchId, 'rejected');
  }
}
