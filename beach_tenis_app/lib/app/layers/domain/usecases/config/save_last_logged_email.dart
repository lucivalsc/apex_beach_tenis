import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/common/usecase.dart';
import 'package:apex_sports/layers/domain/repositories/config_repository.dart';
import 'package:dartz/dartz.dart';

class SaveLastLoggedEmailUsecase implements Usecase<String, void> {
  final IConfigRepository repository;

  const SaveLastLoggedEmailUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String email) async {
    return await repository.saveLastLoggedEmail(email);
  }
}
