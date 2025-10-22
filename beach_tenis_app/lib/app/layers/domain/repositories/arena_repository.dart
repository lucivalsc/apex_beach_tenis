import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/models/arena_model.dart';
import 'package:dartz/dartz.dart';

abstract class IArenaRepository {
  Future<Either<Failure, List<ArenaModel>>> getAllArenas();
  Future<Either<Failure, List<ArenaModel>>> getArenasAtivas();
  Future<Either<Failure, ArenaModel?>> getArenaById(int id);
  Future<Either<Failure, ArenaModel?>> getArenaByCnpj(String cnpj);
  Future<Either<Failure, ArenaModel>> createArena(ArenaModel arena);
  Future<Either<Failure, ArenaModel>> updateArena(ArenaModel arena);
  Future<Either<Failure, void>> deleteArena(int id);
  Future<Either<Failure, void>> ativarDesativarArena(int id, bool ativo);
  Future<Either<Failure, List<ArenaModel>>> searchArenas(String query);
  Future<Either<Failure, void>> atualizarStatusPagamento(int arenaId, String novoStatus);
  Future<Either<Failure, List<ArenaModel>>> getArenasByTipoAssinatura(String tipoAssinatura);
  Future<Either<Failure, List<ArenaModel>>> getArenasComPagamentoPendente();
  Future<Either<Failure, void>> adicionarPagamento(int arenaId, Map<String, dynamic> dadosPagamento);
}