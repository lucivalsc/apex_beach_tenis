import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/models/atleta_model.dart';
import 'package:dartz/dartz.dart';

abstract class IAtletaRepository {
  Future<Either<Failure, List<AtletaModel>>> getAllAtletas();
  Future<Either<Failure, List<AtletaModel>>> getAtletasAtivos();
  Future<Either<Failure, AtletaModel?>> getAtletaById(int id);
  Future<Either<Failure, AtletaModel?>> getAtletaByCpf(String cpf);
  Future<Either<Failure, AtletaModel?>> getAtletaByEmail(String email);
  Future<Either<Failure, AtletaModel>> createAtleta(AtletaModel atleta);
  Future<Either<Failure, AtletaModel>> updateAtleta(AtletaModel atleta);
  Future<Either<Failure, void>> deleteAtleta(int id);
  Future<Either<Failure, void>> ativarDesativarAtleta(int id, bool ativo);
  Future<Either<Failure, List<AtletaModel>>> searchAtletas(String query);
  Future<Either<Failure, void>> atualizarRanking(int atletaId, int novoRanking);
  Future<Either<Failure, void>> atualizarEstatisticas(int atletaId, Map<String, dynamic> estatisticas);
  Future<Either<Failure, List<AtletaModel>>> getAtletasPorNivel(String nivel);
  Future<Either<Failure, List<AtletaModel>>> getRankingGeral(int? limit);
}