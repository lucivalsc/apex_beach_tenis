import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/common/usecase.dart';
import 'package:apex_sports/layers/domain/repositories/data_repository.dart';
import 'package:dartz/dartz.dart';

class GetSyncDatasUsecase implements Usecase<List<Object>, List<Object>> {
  final IDataRepository repository;

  const GetSyncDatasUsecase(this.repository);

  @override
  Future<Either<Failure, List<Object>>> call(List<Object> objects) async {
    return await repository.getSyncDatas(objects);
  }
}
