import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/models/jogo_model.dart';
import 'package:dartz/dartz.dart';

abstract class IJogoRepository {
  Future<Either<Failure, List<JogoModel>>> getAllJogos();
  Future<Either<Failure, List<JogoModel>>> getJogosByAtleta(int atletaId);
  Future<Either<Failure, List<JogoModel>>> getJogosByArena(int arenaId);
  Future<Either<Failure, List<JogoModel>>> getJogosByStatus(String status);
  Future<Either<Failure, JogoModel?>> getJogoById(int id);
  Future<Either<Failure, JogoModel>> createJogo(JogoModel jogo);
  Future<Either<Failure, JogoModel>> updateJogo(JogoModel jogo);
  Future<Either<Failure, void>> deleteJogo(int id);
  Future<Either<Failure, JogoModel>> adicionarJogada(int jogoId, Map<String, dynamic> jogada);
  Future<Either<Failure, JogoModel>> finalizarJogo(int jogoId, Map<String, dynamic> resultado);
  Future<Either<Failure, List<JogoModel>>> getJogosPorPeriodo(DateTime inicio, DateTime fim);
  Future<Either<Failure, List<JogoModel>>> getJogosEmAndamento();
  Future<Either<Failure, List<JogoModel>>> getHistoricoJogos(int atletaId, {int? limit});
  Future<Either<Failure, Map<String, dynamic>>> getEstatisticasAtleta(int atletaId);
  Future<Either<Failure, List<JogoModel>>> getJogosPorAdministrador(int administradorId);
}