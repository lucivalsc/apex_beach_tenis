import 'package:beach_tenis_app/app/common/models/failure_models.dart';
import 'package:beach_tenis_app/app/common/usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/config_repository.dart';
import 'package:dartz/dartz.dart';

class LoadConfigUsecase implements Usecase<NoParams, String> {
  final IConfigRepository repository;

  LoadConfigUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.loadConfig();
  }
}
