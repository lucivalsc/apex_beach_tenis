import 'package:beach_tenis_app/app/common/models/failure_models.dart';
import 'package:beach_tenis_app/app/common/usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/config_repository.dart';
import 'package:dartz/dartz.dart';

class SaveLastLoggedPasswordUsecase implements Usecase<String, void> {
  final IConfigRepository repository;

  const SaveLastLoggedPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String password) async {
    return await repository.saveLastLoggedPassword(password);
  }
}
