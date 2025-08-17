import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/domain/repositories/config_repository.dart';
import 'package:dartz/dartz.dart';

class SaveConfigUsecase implements Usecase<String, void> {
  final IConfigRepository repository;

  const SaveConfigUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String value) async {
    return await repository.saveConfig(value);
  }
}
