import 'dart:io';

import 'package:apex_sports/app/common/models/exception_models.dart';
import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/datasources/remote/remote_data_datasource.dart';
import 'package:apex_sports/app/layers/data/models/professor_model.dart';
import 'package:apex_sports/app/layers/domain/repositories/professor_repository.dart';
import 'package:dartz/dartz.dart';

class ProfessorRepositoryImplementation implements IProfessorRepository {
  final IRemoteDataDatasource remoteDatasource;
  final socketError = const Failure(
      failureType: "SocketFailure",
      title: "Falha de Conexão",
      message: "Não foi possível estabelecer conexão com o servidor.");

  ProfessorRepositoryImplementation(this.remoteDatasource);

  @override
  Future<Either<Failure, List<ProfessorModel>>> getAllProfessores() async {
    try {
      final result = await remoteDatasource.getAllProfessores();
      final professores =
          result.map((json) => ProfessorModel.fromJson(json)).toList();
      return Right(professores);
    } on ServerException catch (e) {
      return Left(Failure(
          failureType: "ServerFailure", title: e.title, message: e.message));
    } on SocketException {
      return Left(socketError);
    }
  }

  @override
  Future<Either<Failure, List<ProfessorModel>>> getProfessoresByArena(
      int arenaId) async {
    try {
      final result = await remoteDatasource.getProfessoresByArena(arenaId);
      final professores =
          result.map((json) => ProfessorModel.fromJson(json)).toList();
      return Right(professores);
    } on ServerException catch (e) {
      return Left(Failure(
          failureType: "ServerFailure", title: e.title, message: e.message));
    } on SocketException {
      return Left(socketError);
    }
  }

  @override
  Future<Either<Failure, List<ProfessorModel>>> getProfessoresAtivos() async {
    try {
      final result = await getAllProfessores();
      return result.fold(
        (failure) => Left(failure),
        (professores) => Right(professores.where((p) => p.ativo).toList()),
      );
    } catch (e) {
      return const Left(Failure(
          failureType: "UnknownFailure",
          title: "Erro",
          message: "Erro desconhecido"));
    }
  }

  @override
  Future<Either<Failure, ProfessorModel?>> getProfessorById(int id) async {
    try {
      final result = await remoteDatasource.getProfessorById(id);
      if (result == null) return const Right(null);
      final professor = ProfessorModel.fromJson(result);
      return Right(professor);
    } on ServerException catch (e) {
      return Left(Failure(
          failureType: "ServerFailure", title: e.title, message: e.message));
    } on SocketException {
      return Left(socketError);
    }
  }

  @override
  Future<Either<Failure, ProfessorModel?>> getProfessorByCpf(String cpf) async {
    try {
      final result = await getAllProfessores();
      return result.fold(
        (failure) => Left(failure),
        (professores) {
          try {
            final professor = professores.firstWhere((p) => p.cpf == cpf);
            return Right(professor);
          } catch (e) {
            return const Right(null);
          }
        },
      );
    } catch (e) {
      return const Left(Failure(
          failureType: "UnknownFailure",
          title: "Erro",
          message: "Erro desconhecido"));
    }
  }

  @override
  Future<Either<Failure, ProfessorModel>> createProfessor(
      ProfessorModel professor) async {
    try {
      final result = await remoteDatasource.createProfessor(professor.toJson());
      final novoProfessor = ProfessorModel.fromJson(result);
      return Right(novoProfessor);
    } on ServerException catch (e) {
      return Left(Failure(
          failureType: "ServerFailure", title: e.title, message: e.message));
    } on SocketException {
      return Left(socketError);
    }
  }

  @override
  Future<Either<Failure, ProfessorModel>> updateProfessor(
      ProfessorModel professor) async {
    try {
      final result = await remoteDatasource.updateProfessor(professor.toJson());
      final professorAtualizado = ProfessorModel.fromJson(result);
      return Right(professorAtualizado);
    } on ServerException catch (e) {
      return Left(Failure(
          failureType: "ServerFailure", title: e.title, message: e.message));
    } on SocketException {
      return Left(socketError);
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfessor(int id) async {
    try {
      await remoteDatasource.deleteProfessor(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(
          failureType: "ServerFailure", title: e.title, message: e.message));
    } on SocketException {
      return Left(socketError);
    }
  }

  @override
  Future<Either<Failure, void>> ativarDesativarProfessor(
      int id, bool ativo) async {
    try {
      final professorResult = await getProfessorById(id);
      return professorResult.fold(
        (failure) => Left(failure),
        (professor) async {
          if (professor == null) {
            return const Left(Failure(
                failureType: "NotFound",
                title: "Professor não encontrado",
                message: "Professor não encontrado"));
          }
          final professorAtualizado =
              professor.copyWith(ativo: ativo, updatedAt: DateTime.now());
          final result = await updateProfessor(professorAtualizado);
          return result.fold(
            (failure) => Left(failure),
            (professorAtualizado) => const Right(null),
          );
        },
      );
    } catch (e) {
      return const Left(Failure(
          failureType: "UnknownFailure",
          title: "Erro",
          message: "Erro desconhecido"));
    }
  }

  @override
  Future<Either<Failure, List<ProfessorModel>>> searchProfessores(
      String query) async {
    try {
      final result = await getAllProfessores();
      return result.fold(
        (failure) => Left(failure),
        (professores) {
          final filtrados = professores.where((professor) {
            return professor.nome.toLowerCase().contains(query.toLowerCase()) ||
                professor.email.toLowerCase().contains(query.toLowerCase()) ||
                professor.cpf.contains(query) ||
                (professor.telefone?.contains(query) ?? false);
          }).toList();
          return Right(filtrados);
        },
      );
    } catch (e) {
      return const Left(Failure(
          failureType: "UnknownFailure",
          title: "Erro",
          message: "Erro desconhecido"));
    }
  }

  @override
  Future<Either<Failure, void>> vincularArena(
      int professorId, int arenaId) async {
    try {
      final professorResult = await getProfessorById(professorId);
      return professorResult.fold(
        (failure) => Left(failure),
        (professor) async {
          if (professor == null) {
            return const Left(Failure(
                failureType: "NotFound",
                title: "Professor não encontrado",
                message: "Professor não encontrado"));
          }
          final arenasAtualizadas = List<int>.from(professor.arenasIds);
          if (!arenasAtualizadas.contains(arenaId)) {
            arenasAtualizadas.add(arenaId);
          }
          final professorAtualizado = professor.copyWith(
            arenasIds: arenasAtualizadas,
            updatedAt: DateTime.now(),
          );
          final result = await updateProfessor(professorAtualizado);
          return result.fold(
            (failure) => Left(failure),
            (professorAtualizado) => const Right(null),
          );
        },
      );
    } catch (e) {
      return const Left(Failure(
          failureType: "UnknownFailure",
          title: "Erro",
          message: "Erro desconhecido"));
    }
  }

  @override
  Future<Either<Failure, void>> desvincularArena(
      int professorId, int arenaId) async {
    try {
      final professorResult = await getProfessorById(professorId);
      return professorResult.fold(
        (failure) => Left(failure),
        (professor) async {
          if (professor == null) {
            return const Left(Failure(
                failureType: "NotFound",
                title: "Professor não encontrado",
                message: "Professor não encontrado"));
          }
          final arenasAtualizadas = List<int>.from(professor.arenasIds);
          arenasAtualizadas.remove(arenaId);
          final professorAtualizado = professor.copyWith(
            arenasIds: arenasAtualizadas,
            updatedAt: DateTime.now(),
          );
          final result = await updateProfessor(professorAtualizado);
          return result.fold(
            (failure) => Left(failure),
            (professorAtualizado) => const Right(null),
          );
        },
      );
    } catch (e) {
      return const Left(Failure(
          failureType: "UnknownFailure",
          title: "Erro",
          message: "Erro desconhecido"));
    }
  }
}
