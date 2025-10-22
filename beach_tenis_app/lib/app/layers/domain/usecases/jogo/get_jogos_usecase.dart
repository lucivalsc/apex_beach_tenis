import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/jogo_model.dart';
import 'package:apex_sports/app/layers/domain/repositories/jogo_repository.dart';
import 'package:dartz/dartz.dart';

class GetJogosUsecase implements Usecase<NoParams, List<JogoModel>> {
  final IJogoRepository repository;

  const GetJogosUsecase(this.repository);

  @override
  Future<Either<Failure, List<JogoModel>>> call(NoParams params) async {
    return await repository.getAllJogos();
  }
}