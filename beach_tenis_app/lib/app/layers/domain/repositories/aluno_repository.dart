import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/models/aluno_model.dart';
import 'package:dartz/dartz.dart';

abstract class IAlunoRepository {
  Future<Either<Failure, List<AlunoModel>>> getAllAlunos();
  Future<Either<Failure, List<AlunoModel>>> getAlunosByArena(int arenaId);
  Future<Either<Failure, List<AlunoModel>>> getAlunosAtivos();
  Future<Either<Failure, List<AlunoModel>>> getAlunosByProfessor(int professorId);
  Future<Either<Failure, AlunoModel?>> getAlunoById(int id);
  Future<Either<Failure, AlunoModel?>> getAlunoByCpf(String cpf);
  Future<Either<Failure, AlunoModel>> createAluno(AlunoModel aluno);
  Future<Either<Failure, AlunoModel>> updateAluno(AlunoModel aluno);
  Future<Either<Failure, void>> deleteAluno(int id);
  Future<Either<Failure, void>> ativarDesativarAluno(int id, bool ativo);
  Future<Either<Failure, List<AlunoModel>>> searchAlunos(String query);
  Future<Either<Failure, void>> vincularProfessor(int alunoId, int professorId);
  Future<Either<Failure, void>> desvincularProfessor(int alunoId, int professorId);
  Future<Either<Failure, void>> atualizarNivel(int alunoId, String novoNivel);
}