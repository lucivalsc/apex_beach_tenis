import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/models/professor_model.dart';
import 'package:dartz/dartz.dart';

abstract class IProfessorRepository {
  Future<Either<Failure, List<ProfessorModel>>> getAllProfessores();
  Future<Either<Failure, List<ProfessorModel>>> getProfessoresByArena(int arenaId);
  Future<Either<Failure, List<ProfessorModel>>> getProfessoresAtivos();
  Future<Either<Failure, ProfessorModel?>> getProfessorById(int id);
  Future<Either<Failure, ProfessorModel?>> getProfessorByCpf(String cpf);
  Future<Either<Failure, ProfessorModel>> createProfessor(ProfessorModel professor);
  Future<Either<Failure, ProfessorModel>> updateProfessor(ProfessorModel professor);
  Future<Either<Failure, void>> deleteProfessor(int id);
  Future<Either<Failure, void>> ativarDesativarProfessor(int id, bool ativo);
  Future<Either<Failure, List<ProfessorModel>>> searchProfessores(String query);
  Future<Either<Failure, void>> vincularArena(int professorId, int arenaId);
  Future<Either<Failure, void>> desvincularArena(int professorId, int arenaId);
}