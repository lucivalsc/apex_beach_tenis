import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/common/usecase.dart';
import 'package:apex_sports/layers/domain/repositories/config_repository.dart';
import 'package:dartz/dartz.dart';

class LoadLastLoggedEmailUsecase implements Usecase<NoParams, String?> {
  final IConfigRepository repository;

  const LoadLastLoggedEmailUsecase(this.repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    return await repository.loadLastLoggedEmail();
  }
}
