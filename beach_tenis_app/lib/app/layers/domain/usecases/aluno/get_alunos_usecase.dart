import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/aluno_model.dart';
import 'package:apex_sports/app/layers/domain/repositories/aluno_repository.dart';
import 'package:dartz/dartz.dart';

class GetAlunosUsecase implements Usecase<NoParams, List<AlunoModel>> {
  final IAlunoRepository repository;

  const GetAlunosUsecase(this.repository);

  @override
  Future<Either<Failure, List<AlunoModel>>> call(NoParams params) async {
    return await repository.getAllAlunos();
  }
}