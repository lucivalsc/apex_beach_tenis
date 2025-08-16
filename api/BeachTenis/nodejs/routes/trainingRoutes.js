const express = require('express');
const router = express.Router();
const { v4: uuidv4 } = require('uuid');
const { query } = require('../config/database');
const { Training } = require('../models/training');
const jwt = require('jsonwebtoken');
const { authenticateToken } = require('../middleware/authMiddleware');

/**
 * @route GET /api/training
 * @desc Consulta todos os treinamentos
 * @access Privado
 */
router.get('/', authenticateToken, async (req, res) => {
  try {
    const trainings = await query('SELECT * FROM trainings WHERE status = 1');
    
    // Para cada treinamento, busca o professor e os alunos
    for (const training of trainings) {
      // Busca o professor
      const [teacher] = await query(
        'SELECT * FROM users WHERE id = ? AND status = 1',
        [training.idTeacher]
      );
      
      if (teacher) {
        const { password, ...teacherWithoutPassword } = teacher;
        training.teacher = teacherWithoutPassword;
      }
      
      // Busca os alunos
      const students = await query(
        'SELECT u.* FROM training_students ts JOIN users u ON ts.userId = u.id WHERE ts.trainingId = ?',
        [training.id]
      );
      
      // Remove senhas dos alunos
      training.students = students.map(student => {
        const { password, ...studentWithoutPassword } = student;
        return studentWithoutPassword;
      });
    }
    
    res.json(trainings);
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao listar os treinamentos.' });
  }
});

/**
 * @route GET /api/training/:trainingId
 * @desc Consulta treinamento por ID
 * @access Privado
 */
router.get('/:trainingId', authenticateToken, async (req, res) => {
  try {
    const [training] = await query('SELECT * FROM trainings WHERE id = ? AND status = 1', [req.params.trainingId]);
    
    if (!training) {
      return res.status(404).json({ message: 'Treinamento não encontrado.' });
    }
    
    // Busca o professor
    const [teacher] = await query(
      'SELECT * FROM users WHERE id = ? AND status = 1',
      [training.idTeacher]
    );
    
    if (teacher) {
      const { password, ...teacherWithoutPassword } = teacher;
      training.teacher = teacherWithoutPassword;
    }
    
    // Busca os alunos do treinamento
    const students = await query(
      'SELECT u.* FROM training_students ts JOIN users u ON ts.userId = u.id WHERE ts.trainingId = ?',
      [training.id]
    );
    
    // Remove senhas dos alunos
    training.students = students.map(student => {
      const { password, ...studentWithoutPassword } = student;
      return studentWithoutPassword;
    });
    
    res.json(training);
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao buscar o treinamento.' });
  }
});

/**
 * @route POST /api/training
 * @desc Cria um novo treinamento
 * @access Privado
 */
router.post('/', authenticateToken, async (req, res) => {
  try {
    const trainingData = req.body;
    const students = trainingData.students || [];
    
    // Verifica se a arena existe
    if (trainingData.idArena) {
      const [arena] = await query('SELECT * FROM arenas WHERE id = ? AND status = 1', [trainingData.idArena]);
      if (!arena) {
        return res.status(400).json({ message: 'Arena não encontrada.' });
      }
    }
    
    // Verifica se o professor existe
    if (trainingData.idTeacher) {
      const [teacher] = await query('SELECT * FROM users WHERE id = ? AND status = 1', [trainingData.idTeacher]);
      if (!teacher) {
        return res.status(400).json({ message: 'Professor não encontrado.' });
      }
    }
    
    // Cria uma instância do modelo Training
    const training = new Training();
    Object.assign(training, trainingData);
    
    // Validações básicas
    if (!training.title) {
      return res.status(400).json({ message: 'Título é obrigatório.' });
    }
    
    if (!training.date || !training.startTime || !training.endTime) {
      return res.status(400).json({ message: 'Data e horários são obrigatórios.' });
    }
    
    if (!training.idArena) {
      return res.status(400).json({ message: 'Arena é obrigatória.' });
    }
    
    if (!training.idTeacher) {
      return res.status(400).json({ message: 'Professor é obrigatório.' });
    }
    
    // Gera um ID único
    training.id = uuidv4();
    
    // Insere o treinamento no banco de dados
    await query(
      `INSERT INTO trainings (
        id, title, description, date, startTime, endTime, idArena, 
        idTeacher, maxStudents, price, creationDate, changeDate, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)`,
      [
        training.id, training.title, training.description, training.date, training.startTime, 
        training.endTime, training.idArena, training.idTeacher, training.maxStudents, 
        training.price, training.status
      ]
    );
    
    // Adiciona os alunos ao treinamento
    if (students.length > 0) {
      for (const studentId of students) {
        // Verifica se o aluno existe
        const [student] = await query('SELECT * FROM users WHERE id = ? AND status = 1', [studentId]);
        if (student) {
          await query(
            'INSERT INTO training_students (trainingId, userId, creationDate) VALUES (?, ?, NOW())',
            [training.id, studentId]
          );
        }
      }
    }
    
    res.status(201).json({ 
      message: 'Treinamento criado com sucesso.', 
      training 
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao criar o treinamento.' });
  }
});

/**
 * @route PUT /api/training/:trainingId
 * @desc Atualiza um treinamento
 * @access Privado
 */
router.put('/:trainingId', authenticateToken, async (req, res) => {
  try {
    const trainingId = req.params.trainingId;
    const trainingData = req.body;
    const students = trainingData.students || [];
    
    // Verifica se o treinamento existe
    const [existingTraining] = await query('SELECT * FROM trainings WHERE id = ?', [trainingId]);
    
    if (!existingTraining) {
      return res.status(404).json({ message: 'Treinamento não encontrado.' });
    }
    
    // Verifica se a arena existe
    if (trainingData.idArena) {
      const [arena] = await query('SELECT * FROM arenas WHERE id = ? AND status = 1', [trainingData.idArena]);
      if (!arena) {
        return res.status(400).json({ message: 'Arena não encontrada.' });
      }
    }
    
    // Verifica se o professor existe
    if (trainingData.idTeacher) {
      const [teacher] = await query('SELECT * FROM users WHERE id = ? AND status = 1', [trainingData.idTeacher]);
      if (!teacher) {
        return res.status(400).json({ message: 'Professor não encontrado.' });
      }
    }
    
    // Cria uma instância do modelo Training
    const training = new Training();
    Object.assign(training, { ...existingTraining, ...trainingData });
    
    // Validações básicas
    if (!training.title) {
      return res.status(400).json({ message: 'Título é obrigatório.' });
    }
    
    if (!training.date || !training.startTime || !training.endTime) {
      return res.status(400).json({ message: 'Data e horários são obrigatórios.' });
    }
    
    if (!training.idArena) {
      return res.status(400).json({ message: 'Arena é obrigatória.' });
    }
    
    if (!training.idTeacher) {
      return res.status(400).json({ message: 'Professor é obrigatório.' });
    }
    
    // Atualiza a data de alteração
    training.alterChangeDate();
    
    // Atualiza o treinamento no banco de dados
    await query(
      `UPDATE trainings SET 
        title = ?, description = ?, date = ?, startTime = ?, endTime = ?, 
        idArena = ?, idTeacher = ?, maxStudents = ?, price = ?, 
        changeDate = NOW(), status = ?
      WHERE id = ?`,
      [
        training.title, training.description, training.date, training.startTime, training.endTime, 
        training.idArena, training.idTeacher, training.maxStudents, training.price, 
        training.status, trainingId
      ]
    );
    
    // Atualiza os alunos do treinamento
    if (students.length > 0) {
      // Remove alunos atuais
      await query('DELETE FROM training_students WHERE trainingId = ?', [trainingId]);
      
      // Adiciona os novos alunos
      for (const studentId of students) {
        // Verifica se o aluno existe
        const [student] = await query('SELECT * FROM users WHERE id = ? AND status = 1', [studentId]);
        if (student) {
          await query(
            'INSERT INTO training_students (trainingId, userId, creationDate) VALUES (?, ?, NOW())',
            [trainingId, studentId]
          );
        }
      }
    }
    
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao atualizar o treinamento.' });
  }
});

/**
 * @route DELETE /api/training/:trainingId
 * @desc Desativa um treinamento
 * @access Privado
 */
router.delete('/:trainingId', authenticateToken, async (req, res) => {
  try {
    const trainingId = req.params.trainingId;
    
    // Verifica se o treinamento existe
    const [existingTraining] = await query('SELECT * FROM trainings WHERE id = ?', [trainingId]);
    
    if (!existingTraining) {
      return res.status(404).json({ message: 'Treinamento não encontrado.' });
    }
    
    // Desativa o treinamento (altera o status para 2 = Desativado)
    await query(
      'UPDATE trainings SET status = 2, changeDate = NOW() WHERE id = ?',
      [trainingId]
    );
    
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao desativar o treinamento.' });
  }
});

/**
 * @route POST /api/training/:trainingId/student/:studentId
 * @desc Adiciona um aluno ao treinamento
 * @access Privado
 */
router.post('/:trainingId/student/:studentId', authenticateToken, async (req, res) => {
  try {
    const trainingId = req.params.trainingId;
    const studentId = req.params.studentId;
    
    // Verifica se o treinamento existe
    const [training] = await query('SELECT * FROM trainings WHERE id = ? AND status = 1', [trainingId]);
    if (!training) {
      return res.status(404).json({ message: 'Treinamento não encontrado.' });
    }
    
    // Verifica se o aluno existe
    const [student] = await query('SELECT * FROM users WHERE id = ? AND status = 1', [studentId]);
    if (!student) {
      return res.status(404).json({ message: 'Aluno não encontrado.' });
    }
    
    // Verifica se o aluno já está no treinamento
    const [existingStudent] = await query(
      'SELECT * FROM training_students WHERE trainingId = ? AND userId = ?',
      [trainingId, studentId]
    );
    
    if (existingStudent) {
      return res.status(400).json({ message: 'Aluno já está no treinamento.' });
    }
    
    // Verifica se o treinamento já está cheio
    const [{ count }] = await query(
      'SELECT COUNT(*) as count FROM training_students WHERE trainingId = ?',
      [trainingId]
    );
    
    if (count >= training.maxStudents) {
      return res.status(400).json({ message: 'Treinamento já está com o número máximo de alunos.' });
    }
    
    // Adiciona o aluno ao treinamento
    await query(
      'INSERT INTO training_students (trainingId, userId, creationDate) VALUES (?, ?, NOW())',
      [trainingId, studentId]
    );
    
    res.status(201).json({ message: 'Aluno adicionado ao treinamento com sucesso.' });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao adicionar o aluno ao treinamento.' });
  }
});

/**
 * @route DELETE /api/training/:trainingId/student/:studentId
 * @desc Remove um aluno do treinamento
 * @access Privado
 */
router.delete('/:trainingId/student/:studentId', authenticateToken, async (req, res) => {
  try {
    const trainingId = req.params.trainingId;
    const studentId = req.params.studentId;
    
    // Verifica se o treinamento existe
    const [training] = await query('SELECT * FROM trainings WHERE id = ? AND status = 1', [trainingId]);
    if (!training) {
      return res.status(404).json({ message: 'Treinamento não encontrado.' });
    }
    
    // Verifica se o aluno está no treinamento
    const [existingStudent] = await query(
      'SELECT * FROM training_students WHERE trainingId = ? AND userId = ?',
      [trainingId, studentId]
    );
    
    if (!existingStudent) {
      return res.status(404).json({ message: 'Aluno não está no treinamento.' });
    }
    
    // Remove o aluno do treinamento
    await query(
      'DELETE FROM training_students WHERE trainingId = ? AND userId = ?',
      [trainingId, studentId]
    );
    
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao remover o aluno do treinamento.' });
  }
});

module.exports = router;
