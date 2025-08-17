import 'package:apex_sports/app/layers/data/datasources/remote/remote_data_datasource.dart';
import 'package:apex_sports/app/layers/domain/entities/match_entity.dart';
import 'package:apex_sports/app/layers/domain/repositories/match_repository.dart';

class MatchRepositoryImplementation implements IMatchRepository {
  final IRemoteDataDatasource remoteDataSource;

  MatchRepositoryImplementation(this.remoteDataSource);

  @override
  Future<MatchEntity?> getMatchById(String id) async {
    try {
      final response = await remoteDataSource.getMatches('');
      if (response['success'] == true) {
        final matches = response['data'] as List;
        final matchData = matches.firstWhere(
          (match) => match['id'] == id,
          orElse: () => null,
        );

        if (matchData != null) {
          return MatchEntity.fromJson(matchData);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao buscar match: $e');
    }
  }

  @override
  Future<List<MatchEntity>> getMatchesByDemandante(String demandanteId) async {
    try {
      final response = await remoteDataSource.getMatches(demandanteId);
      if (response['success'] == true) {
        final matches = response['data'] as List;
        final demandanteMatches = matches.where((match) => match['demandanteId'] == demandanteId).toList();
        return demandanteMatches.map((matchData) => MatchEntity.fromJson(matchData)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar matches do demandante: $e');
    }
  }

  @override
  Future<List<MatchEntity>> getMatchesByDonor(String donorId) async {
    try {
      final response = await remoteDataSource.getMatches(donorId);
      if (response['success'] == true) {
        final matches = response['data'] as List;
        final donorMatches = matches.where((match) => match['donorId'] == donorId).toList();
        return donorMatches.map((matchData) => MatchEntity.fromJson(matchData)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar matches do doador: $e');
    }
  }

  @override
  Future<List<MatchEntity>> getPendingMatches(String userId) async {
    try {
      final response = await remoteDataSource.getMatches(userId);
      if (response['success'] == true) {
        final matches = response['data'] as List;
        final pendingMatches = matches
            .where((match) =>
                match['status'] == 'pending' && (match['demandanteId'] == userId || match['donorId'] == userId))
            .toList();
        return pendingMatches.map((matchData) => MatchEntity.fromJson(matchData)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar matches pendentes: $e');
    }
  }

  @override
  Future<List<MatchEntity>> getActiveMatches(String userId) async {
    try {
      final response = await remoteDataSource.getMatches(userId);
      if (response['success'] == true) {
        final matches = response['data'] as List;
        final activeMatches = matches
            .where(
                (match) => match['isActive'] == true && (match['demandanteId'] == userId || match['donorId'] == userId))
            .toList();
        return activeMatches.map((matchData) => MatchEntity.fromJson(matchData)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar matches ativos: $e');
    }
  }

  @override
  Future<MatchEntity> createMatch(MatchEntity match) async {
    try {
      final matchData = match.toJson();
      final response = await remoteDataSource.createMatch(matchData);
      if (response['success'] == true) {
        return MatchEntity.fromJson(response['data']);
      }
      throw Exception('Falha ao criar match');
    } catch (e) {
      throw Exception('Erro ao criar match: $e');
    }
  }

  @override
  Future<MatchEntity> updateMatchStatus(String matchId, String status) async {
    try {
      // Em uma implementação real, isso faria uma chamada PATCH para atualizar o status
      await Future.delayed(const Duration(milliseconds: 200));

      // Simula retorno do match atualizado
      final updatedMatch = MatchEntity(
        id: matchId,
        demandanteId: 'user_001',
        donorId: 'user_002',
        status: status,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        acceptedAt: status == 'accepted' ? DateTime.now() : null,
        compatibilityScore: 0.92,
        isActive: true,
      );

      return updatedMatch;
    } catch (e) {
      throw Exception('Erro ao atualizar status do match: $e');
    }
  }

  @override
  Future<void> deleteMatch(String id) async {
    try {
      // Em uma implementação real, isso faria uma chamada DELETE
      await Future.delayed(const Duration(milliseconds: 150));
    } catch (e) {
      throw Exception('Erro ao deletar match: $e');
    }
  }

  @override
  Future<double> calculateCompatibilityScore(String demandanteId, String donorId) async {
    try {
      // Em uma implementação real, isso calcularia a compatibilidade baseada em critérios
      await Future.delayed(const Duration(milliseconds: 100));

      // Simula cálculo de compatibilidade
      final random = DateTime.now().millisecondsSinceEpoch % 100;
      return (80 + random) / 100.0; // Score entre 0.80 e 0.99
    } catch (e) {
      throw Exception('Erro ao calcular score de compatibilidade: $e');
    }
  }
}
