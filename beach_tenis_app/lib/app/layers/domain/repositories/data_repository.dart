import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:dartz/dartz.dart';

abstract class IDataRepository {
  Future<Either<Failure, List<Object>>> datas(List<Object> strings);
  Future<Either<Failure, List<Object>>> getSyncDatas(List<Object> strings);
}
