import 'package:beach_tenis_app/app/common/models/failure_models.dart';
import 'package:beach_tenis_app/app/common/usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/data_repository.dart';
import 'package:dartz/dartz.dart';

class GetSyncDatasUsecase implements Usecase<List<Object>, List<Object>> {
  final IDataRepository repository;

  const GetSyncDatasUsecase(this.repository);

  @override
  Future<Either<Failure, List<Object>>> call(List<Object> objects) async {
    return await repository.getSyncDatas(objects);
  }
}
