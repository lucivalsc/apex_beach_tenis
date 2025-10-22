import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/jogo_model.dart';
import 'package:apex_sports/app/layers/domain/repositories/jogo_repository.dart';
import 'package:dartz/dartz.dart';

class CreateJogoUsecase implements Usecase<JogoModel, JogoModel> {
  final IJogoRepository repository;

  const CreateJogoUsecase(this.repository);

  @override
  Future<Either<Failure, JogoModel>> call(JogoModel jogo) async {
    return await repository.createJogo(jogo);
  }
}