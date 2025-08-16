import 'dart:io';

import 'package:beach_tenis_app/app/common/models/exception_models.dart';
import 'package:beach_tenis_app/app/common/models/failure_models.dart';
import 'package:beach_tenis_app/app/layers/data/datasources/remote/remote_data_datasource.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/data_repository.dart';
import 'package:dartz/dartz.dart';

class DataRepositoryImplementation implements IDataRepository {
  final IRemoteDataDatasource remoteDatasource;
  final socketError = const Failure(
      failureType: "SocketFailure",
      title: "Falha de Conexão",
      message: "Não foi possível estabelecer conexão com o servidor.");

  DataRepositoryImplementation(this.remoteDatasource);

  @override
  Future<Either<Failure, List<Object>>> datas(List<Object> objects) async {
    try {
      final result = await remoteDatasource.datas(objects);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(failureType: "ServerFailure", title: e.title, message: e.message));
    } on SocketException {
      return Left(socketError);
    }
  }

  @override
  Future<Either<Failure, List<Object>>> getSyncDatas(List<Object> objects) async {
    try {
      final result = await remoteDatasource.getSyncDatas(objects);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(failureType: "ServerFailure", title: e.title, message: e.message));
    } on SocketException {
      return Left(socketError);
    }
  }
}
