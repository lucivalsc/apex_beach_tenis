import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/aluno_model.dart';
import 'package:apex_sports/app/layers/domain/repositories/aluno_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateAlunoUsecase implements Usecase<AlunoModel, AlunoModel> {
  final IAlunoRepository repository;

  const UpdateAlunoUsecase(this.repository);

  @override
  Future<Either<Failure, AlunoModel>> call(AlunoModel aluno) async {
    return await repository.updateAluno(aluno);
  }
}