import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/models/avaliacao_model.dart';
import 'package:dartz/dartz.dart';

abstract class IAvaliacaoRepository {
  Future<Either<Failure, List<AvaliacaoModel>>> getAllAvaliacoes();
  Future<Either<Failure, List<AvaliacaoModel>>> getAvaliacoesByAluno(int alunoId);
  Future<Either<Failure, List<AvaliacaoModel>>> getAvaliacoesByProfessor(int professorId);
  Future<Either<Failure, List<AvaliacaoModel>>> getAvaliacoesByArena(int arenaId);
  Future<Either<Failure, List<AvaliacaoModel>>> getAvaliacoesByStatus(String status);
  Future<Either<Failure, AvaliacaoModel?>> getAvaliacaoById(int id);
  Future<Either<Failure, AvaliacaoModel>> createAvaliacao(AvaliacaoModel avaliacao);
  Future<Either<Failure, AvaliacaoModel>> updateAvaliacao(AvaliacaoModel avaliacao);
  Future<Either<Failure, void>> deleteAvaliacao(int id);
  Future<Either<Failure, AvaliacaoModel>> adicionarItemAvaliacao(int avaliacaoId, Map<String, dynamic> itemAvaliacao);
  Future<Either<Failure, AvaliacaoModel>> removerItemAvaliacao(int avaliacaoId, int itemAvaliacaoId);
  Future<Either<Failure, AvaliacaoModel>> atualizarResultadoItem(int avaliacaoId, int itemAvaliacaoId, int acertos, int executado);
  Future<Either<Failure, List<AvaliacaoModel>>> getAvaliacoesPorPeriodo(DateTime inicio, DateTime fim);
  Future<Either<Failure, Map<String, dynamic>>> getEstatisticasAluno(int alunoId);
  Future<Either<Failure, List<AvaliacaoModel>>> getAvaliacoesNaoPreenchidas(int professorId);
  Future<Either<Failure, List<AvaliacaoModel>>> getHistoricoAvaliacoes(int alunoId, {int? limit});
}