const BaseEntity = require('./baseEntity');

/**
 * Modelo de Treinamento
 */
class Training extends BaseEntity {
  constructor() {
    super();
    this.title = '';
    this.description = '';
    this.date = new Date();
    this.startTime = '';
    this.endTime = '';
    this.idArena = null;
    this.idTeacher = null; // ID do professor/treinador
    this.students = []; // Array de IDs de alunos
    this.maxStudents = 8;
    this.price = 0;
  }
}

/**
 * Modelo para MySQL
 */
const TrainingModel = {
  tableName: 'trainings',
  
  fields: {
    id: { type: 'VARCHAR(36)', primaryKey: true },
    title: { type: 'VARCHAR(100)', notNull: true },
    description: { type: 'TEXT' },
    date: { type: 'DATE', notNull: true },
    startTime: { type: 'TIME', notNull: true },
    endTime: { type: 'TIME', notNull: true },
    idArena: { type: 'VARCHAR(36)', notNull: true },
    idTeacher: { type: 'VARCHAR(36)', notNull: true },
    maxStudents: { type: 'INT', default: 8 },
    price: { type: 'DECIMAL(10,2)', default: 0 },
    creationDate: { type: 'DATETIME', default: 'CURRENT_TIMESTAMP' },
    changeDate: { type: 'DATETIME', default: 'CURRENT_TIMESTAMP' },
    status: { type: 'TINYINT', default: 1 }
  },
  
  createTable: `
    CREATE TABLE IF NOT EXISTS trainings (
      id VARCHAR(36) PRIMARY KEY,
      title VARCHAR(100) NOT NULL,
      description TEXT,
      date DATE NOT NULL,
      startTime TIME NOT NULL,
      endTime TIME NOT NULL,
      idArena VARCHAR(36) NOT NULL,
      idTeacher VARCHAR(36) NOT NULL,
      maxStudents INT DEFAULT 8,
      price DECIMAL(10,2) DEFAULT 0,
      creationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
      changeDate DATETIME DEFAULT CURRENT_TIMESTAMP,
      status TINYINT DEFAULT 1,
      FOREIGN KEY (idArena) REFERENCES arenas(id),
      FOREIGN KEY (idTeacher) REFERENCES users(id)
    )
  `,
  
  // Tabela de relacionamento entre treinamentos e alunos
  createStudentRelationTable: `
    CREATE TABLE IF NOT EXISTS training_students (
      id INT AUTO_INCREMENT PRIMARY KEY,
      trainingId VARCHAR(36) NOT NULL,
      userId VARCHAR(36) NOT NULL,
      creationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (trainingId) REFERENCES trainings(id),
      FOREIGN KEY (userId) REFERENCES users(id),
      UNIQUE KEY unique_training_student (trainingId, userId)
    )
  `
};

module.exports = {
  Training,
  TrainingModel
};
