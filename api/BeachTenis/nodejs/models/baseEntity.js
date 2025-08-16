/**
 * Modelo base para todas as entidades
 */
class BaseEntity {
  constructor() {
    this.id = null;
    this.creationDate = new Date();
    this.changeDate = new Date();
    this.status = 1; // 1 = Ativado, 2 = Desativado
  }

  /**
   * Atualiza a data de alteração
   */
  alterChangeDate() {
    this.changeDate = new Date();
  }

  /**
   * Altera o status para desativado
   */
  alterStatus() {
    this.changeDate = new Date();
    this.status = 2;
  }
}

module.exports = BaseEntity;
