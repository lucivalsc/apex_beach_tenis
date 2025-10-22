import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/models/treino_model.dart';
import 'package:dartz/dartz.dart';

abstract class ITreinoRepository {
  Future<Either<Failure, List<TreinoModel>>> getAllTreinos();
  Future<Either<Failure, List<TreinoModel>>> getTreinosByAluno(int alunoId);
  Future<Either<Failure, List<TreinoModel>>> getTreinosByProfessor(int professorId);
  Future<Either<Failure, List<TreinoModel>>> getTreinosByArena(int arenaId);
  Future<Either<Failure, List<TreinoModel>>> getTreinosByStatus(String status);
  Future<Either<Failure, TreinoModel?>> getTreinoById(int id);
  Future<Either<Failure, TreinoModel>> createTreino(TreinoModel treino);
  Future<Either<Failure, TreinoModel>> updateTreino(TreinoModel treino);
  Future<Either<Failure, void>> deleteTreino(int id);
  Future<Either<Failure, TreinoModel>> adicionarItemTreino(int treinoId, Map<String, dynamic> itemTreino);
  Future<Either<Failure, TreinoModel>> removerItemTreino(int treinoId, int itemTreinoId);
  Future<Either<Failure, TreinoModel>> atualizarProgressoItem(int treinoId, int itemTreinoId, int progressoExito);
  Future<Either<Failure, List<TreinoModel>>> getTreinosPorPeriodo(DateTime inicio, DateTime fim);
  Future<Either<Failure, Map<String, dynamic>>> getEstatisticasAluno(int alunoId);
  Future<Either<Failure, List<TreinoModel>>> getTreinosNaoPreenchidos(int professorId);
}