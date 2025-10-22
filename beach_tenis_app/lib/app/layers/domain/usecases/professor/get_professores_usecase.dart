import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/professor_model.dart';
import 'package:apex_sports/app/layers/domain/repositories/professor_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfessoresUsecase implements Usecase<NoParams, List<ProfessorModel>> {
  final IProfessorRepository repository;

  const GetProfessoresUsecase(this.repository);

  @override
  Future<Either<Failure, List<ProfessorModel>>> call(NoParams params) async {
    return await repository.getAllProfessores();
  }
}