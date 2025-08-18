'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoUsuario = sequelize.define('TipoUsuario', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nome: {
      type: DataTypes.STRING(50),
      allowNull: false,
      unique: true
    },
    descricao: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    codigo: {
      type: DataTypes.STRING(50),
      allowNull: false,
      unique: true
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updated_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'tipos_usuario',
    timestamps: true,
    createdAt: 'created_at',
    updated_at: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo',
        fields: ['codigo']
      }
    ]
  });

  TipoUsuario.associate = function(models) {
    TipoUsuario.hasMany(models.Usuario, {
      foreignKey: 'tipo_usuario_id',
      as: 'usuarios'
    });
  };

  // Método para inserir os valores padrão
  TipoUsuario.insertDefaultValues = async function() {
    const tiposUsuario = [
      { nome: 'Arena', descricao: 'Estabelecimento que oferece quadras de beach tênis', codigo: 'ARENA', ativo: true },
      { nome: 'Atleta', descricao: 'Jogador de beach tênis', codigo: 'ATLETA', ativo: true },
      { nome: 'Aluno', descricao: 'Aluno de beach tênis', codigo: 'ALUNO', ativo: true },
      { nome: 'Professor', descricao: 'Professor de beach tênis', codigo: 'PROFESSOR', ativo: true },
      { nome: 'Profissional Técnico', descricao: 'Profissional técnico de beach tênis', codigo: 'PROFISSIONAL_TECNICO', ativo: true },
      { nome: 'Administrador', descricao: 'Administrador do sistema', codigo: 'ADMIN', ativo: true }
    ];

    for (const tipo of tiposUsuario) {
      await this.findOrCreate({
        where: { codigo: tipo.codigo },
        defaults: tipo
      });
    }
  };

  return TipoUsuario;
};
