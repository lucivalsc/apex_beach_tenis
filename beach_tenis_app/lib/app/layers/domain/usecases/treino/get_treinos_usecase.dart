import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/treino_model.dart';
import 'package:apex_sports/app/layers/domain/repositories/treino_repository.dart';
import 'package:dartz/dartz.dart';

class GetTreinosUsecase implements Usecase<NoParams, List<TreinoModel>> {
  final ITreinoRepository repository;

  const GetTreinosUsecase(this.repository);

  @override
  Future<Either<Failure, List<TreinoModel>>> call(NoParams params) async {
    return await repository.getAllTreinos();
  }
}