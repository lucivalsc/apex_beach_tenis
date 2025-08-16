import 'package:beach_tenis_app/app/common/models/failure_models.dart';
import 'package:beach_tenis_app/app/common/usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/config_repository.dart';
import 'package:dartz/dartz.dart';

class LoadAddressesUsecase implements Usecase<NoParams, Map<String, String>?> {
  final IConfigRepository repository;

  LoadAddressesUsecase(this.repository);

  @override
  Future<Either<Failure, Map<String, String>?>> call(NoParams params) async {
    return await repository.loadAddresses();
  }
}
