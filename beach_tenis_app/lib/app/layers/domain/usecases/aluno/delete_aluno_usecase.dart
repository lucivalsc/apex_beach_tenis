import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/domain/repositories/aluno_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAlunoUsecase implements Usecase<int, void> {
  final IAlunoRepository repository;

  const DeleteAlunoUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteAluno(id);
  }
}