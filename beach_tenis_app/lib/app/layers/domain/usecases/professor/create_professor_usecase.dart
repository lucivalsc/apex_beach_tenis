import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/professor_model.dart';
import 'package:apex_sports/app/layers/domain/repositories/professor_repository.dart';
import 'package:dartz/dartz.dart';

class CreateProfessorUsecase implements Usecase<ProfessorModel, ProfessorModel> {
  final IProfessorRepository repository;

  const CreateProfessorUsecase(this.repository);

  @override
  Future<Either<Failure, ProfessorModel>> call(ProfessorModel professor) async {
    return await repository.createProfessor(professor);
  }
}