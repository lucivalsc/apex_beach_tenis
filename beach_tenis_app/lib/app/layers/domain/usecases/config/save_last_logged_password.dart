import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/domain/repositories/config_repository.dart';
import 'package:dartz/dartz.dart';

class SaveLastLoggedPasswordUsecase implements Usecase<String, void> {
  final IConfigRepository repository;

  const SaveLastLoggedPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String password) async {
    return await repository.saveLastLoggedPassword(password);
  }
}
