
abstract class IRemoteDataDatasource {
  Future<List<Object>> datas(List<Object> objects);
  Future<List<Object>> getSyncDatas(List<Object> objects);
  
  // Métodos específicos do Fertilink
  Future<Map<String, dynamic>> getUsers();
  Future<Map<String, dynamic>> getDonors();
  Future<Map<String, dynamic>> getDemandantes();
  Future<Map<String, dynamic>> getMatches(String userId);
  Future<Map<String, dynamic>> getChatMessages(String matchId);
  Future<Map<String, dynamic>> searchDonors(Map<String, dynamic> filters);
  Future<Map<String, dynamic>> createMatch(Map<String, dynamic> matchData);
  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> messageData);
  
  // Métodos específicos para Demandante
  Future<Map<String, dynamic>?> getDemandanteProfile(String userId);
  Future<List<Map<String, dynamic>>> getAllDemandantes();
  Future<List<Map<String, dynamic>>> getActivelySearchingDemandantes();
  Future<Map<String, dynamic>> createDemandanteProfile(Map<String, dynamic> profile);
  Future<Map<String, dynamic>> updateDemandanteProfile(Map<String, dynamic> profile);
  Future<void> deleteDemandanteProfile(String userId);
  Future<void> updateDemandanteSearchStatus(String userId, bool isActivelySearching);

  // Métodos específicos para Beach Tênis
  
  // Professor
  Future<List<Map<String, dynamic>>> getAllProfessores();
  Future<List<Map<String, dynamic>>> getProfessoresByArena(int arenaId);
  Future<Map<String, dynamic>?> getProfessorById(int id);
  Future<Map<String, dynamic>> createProfessor(Map<String, dynamic> professor);
  Future<Map<String, dynamic>> updateProfessor(Map<String, dynamic> professor);
  Future<void> deleteProfessor(int id);
  
  // Aluno
  Future<List<Map<String, dynamic>>> getAllAlunos();
  Future<List<Map<String, dynamic>>> getAlunosByArena(int arenaId);
  Future<Map<String, dynamic>?> getAlunoById(int id);
  Future<Map<String, dynamic>> createAluno(Map<String, dynamic> aluno);
  Future<Map<String, dynamic>> updateAluno(Map<String, dynamic> aluno);
  Future<void> deleteAluno(int id);
  
  // Atleta
  Future<List<Map<String, dynamic>>> getAllAtletas();
  Future<Map<String, dynamic>?> getAtletaById(int id);
  Future<Map<String, dynamic>> createAtleta(Map<String, dynamic> atleta);
  Future<Map<String, dynamic>> updateAtleta(Map<String, dynamic> atleta);
  Future<void> deleteAtleta(int id);
  
  // Arena
  Future<List<Map<String, dynamic>>> getAllArenas();
  Future<Map<String, dynamic>?> getArenaById(int id);
  Future<Map<String, dynamic>> createArena(Map<String, dynamic> arena);
  Future<Map<String, dynamic>> updateArena(Map<String, dynamic> arena);
  Future<void> deleteArena(int id);
  
  // Jogo
  Future<List<Map<String, dynamic>>> getAllJogos();
  Future<List<Map<String, dynamic>>> getJogosByAtleta(int atletaId);
  Future<Map<String, dynamic>?> getJogoById(int id);
  Future<Map<String, dynamic>> createJogo(Map<String, dynamic> jogo);
  Future<Map<String, dynamic>> updateJogo(Map<String, dynamic> jogo);
  Future<void> deleteJogo(int id);
  
  // Treino
  Future<List<Map<String, dynamic>>> getAllTreinos();
  Future<List<Map<String, dynamic>>> getTreinosByAluno(int alunoId);
  Future<List<Map<String, dynamic>>> getTreinosByProfessor(int professorId);
  Future<Map<String, dynamic>?> getTreinoById(int id);
  Future<Map<String, dynamic>> createTreino(Map<String, dynamic> treino);
  Future<Map<String, dynamic>> updateTreino(Map<String, dynamic> treino);
  Future<void> deleteTreino(int id);
  
  // Avaliação
  Future<List<Map<String, dynamic>>> getAllAvaliacoes();
  Future<List<Map<String, dynamic>>> getAvaliacoesByAluno(int alunoId);
  Future<List<Map<String, dynamic>>> getAvaliacoesByProfessor(int professorId);
  Future<Map<String, dynamic>?> getAvaliacaoById(int id);
  Future<Map<String, dynamic>> createAvaliacao(Map<String, dynamic> avaliacao);
  Future<Map<String, dynamic>> updateAvaliacao(Map<String, dynamic> avaliacao);
  Future<void> deleteAvaliacao(int id);
  
  // Conexão
  Future<List<Map<String, dynamic>>> getAllConexoes();
  Future<List<Map<String, dynamic>>> getConexoesByAtleta(int atletaId);
  Future<Map<String, dynamic>?> getConexaoById(int id);
  Future<Map<String, dynamic>> createConexao(Map<String, dynamic> conexao);
  Future<Map<String, dynamic>> updateConexao(Map<String, dynamic> conexao);
  Future<void> deleteConexao(int id);
}
