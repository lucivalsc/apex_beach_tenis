import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/common/usecase.dart';
import 'package:apex_sports/layers/domain/repositories/config_repository.dart';
import 'package:dartz/dartz.dart';

class CompanyUsecase implements Usecase<String, void> {
  final IConfigRepository repository;

  const CompanyUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String value) async {
    return await repository.company(value);
  }
}
