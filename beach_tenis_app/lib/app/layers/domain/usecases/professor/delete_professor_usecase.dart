import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/domain/repositories/professor_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteProfessorUsecase implements Usecase<int, void> {
  final IProfessorRepository repository;

  const DeleteProfessorUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteProfessor(id);
  }
}