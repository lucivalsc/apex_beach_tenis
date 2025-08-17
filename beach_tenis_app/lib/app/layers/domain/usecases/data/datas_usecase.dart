import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/domain/repositories/data_repository.dart';
import 'package:dartz/dartz.dart';

class DatasUsecase implements Usecase<List<Object>, List<Object>> {
  final IDataRepository repository;

  const DatasUsecase(this.repository);

  @override
  Future<Either<Failure, List<Object>>> call(List<Object> objects) async {
    return await repository.datas(objects);
  }
}
