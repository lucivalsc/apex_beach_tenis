import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/treino_model.dart';
import 'package:apex_sports/app/layers/domain/repositories/treino_repository.dart';
import 'package:dartz/dartz.dart';

class CreateTreinoUsecase implements Usecase<TreinoModel, TreinoModel> {
  final ITreinoRepository repository;

  const CreateTreinoUsecase(this.repository);

  @override
  Future<Either<Failure, TreinoModel>> call(TreinoModel treino) async {
    return await repository.createTreino(treino);
  }
}