import 'package:beach_tenis_app/app/common/models/failure_models.dart';
import 'package:beach_tenis_app/app/common/usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/config_repository.dart';
import 'package:dartz/dartz.dart';

class SaveAddressesUsecase implements Usecase<Map<String, String>, void> {
  final IConfigRepository repository;

  SaveAddressesUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Map<String, String> map) async {
    return await repository.saveAddresses(map);
  }
}
