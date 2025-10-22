import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/models/conexao_model.dart';
import 'package:dartz/dartz.dart';

abstract class IConexaoRepository {
  Future<Either<Failure, List<ConexaoModel>>> getAllConexoes();
  Future<Either<Failure, List<ConexaoModel>>> getConexoesByAtleta(int atletaId);
  Future<Either<Failure, List<ConexaoModel>>> getConexoesAceitas(int atletaId);
  Future<Either<Failure, List<ConexaoModel>>> getConexoesPendentes(int atletaId);
  Future<Either<Failure, List<ConexaoModel>>> getSolicitacoesRecebidas(int atletaId);
  Future<Either<Failure, List<ConexaoModel>>> getSolicitacoesEnviadas(int atletaId);
  Future<Either<Failure, ConexaoModel?>> getConexaoById(int id);
  Future<Either<Failure, ConexaoModel?>> getConexaoEntreAtletas(int atletaId1, int atletaId2);
  Future<Either<Failure, ConexaoModel>> createSolicitacaoConexao(SolicitacaoConexaoModel solicitacao, int atletaSolicitanteId);
  Future<Either<Failure, ConexaoModel>> aceitarSolicitacao(int conexaoId, {String? mensagem});
  Future<Either<Failure, ConexaoModel>> recusarSolicitacao(int conexaoId, {String? mensagem});
  Future<Either<Failure, ConexaoModel>> bloquearConexao(int conexaoId);
  Future<Either<Failure, void>> desfazerConexao(int conexaoId);
  Future<Either<Failure, ConexaoModel>> avaliarConexao(int conexaoId, int atletaAvaliadorId, double avaliacao);
  Future<Either<Failure, void>> atualizarEstatisticasConexao(int conexaoId, Map<String, dynamic> estatisticas);
  Future<Either<Failure, List<ConexaoModel>>> getConexoesPorTipo(int atletaId, TipoConexao tipo);
  Future<Either<Failure, List<ConexaoModel>>> searchConexoes(int atletaId, String query);
}