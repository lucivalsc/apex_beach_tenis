'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoSexo = sequelize.define('TipoSexo', {
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
    codigo: {
      type: DataTypes.STRING(50),
      allowNull: false,
      unique: true
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    }
  }, {
    tableName: 'tipos_sexo',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    indexes: [
      {
        name: 'idx_codigo',
        fields: ['codigo']
      }
    ]
  });

  TipoSexo.associate = function(models) {
    TipoSexo.hasMany(models.Aluno, {
      foreignKey: 'tipo_sexo_id',
      as: 'alunos'
    });
    
    TipoSexo.hasMany(models.Atleta, {
      foreignKey: 'tipo_sexo_id',
      as: 'atletas'
    });
    
    TipoSexo.hasMany(models.Professor, {
      foreignKey: 'tipo_sexo_id',
      as: 'professores'
    });
    
    TipoSexo.hasMany(models.ProfissionalTecnico, {
      foreignKey: 'tipo_sexo_id',
      as: 'profissionaisTecnicos'
    });
  };

  // Método para inserir os valores padrão
  TipoSexo.insertDefaultValues = async function() {
    const tiposSexo = [
      { nome: 'Masculino', codigo: 'MASCULINO', ativo: true },
      { nome: 'Feminino', codigo: 'FEMININO', ativo: true },
      { nome: 'Outro', codigo: 'OUTRO', ativo: true }
    ];

    for (const tipo of tiposSexo) {
      await this.findOrCreate({
        where: { codigo: tipo.codigo },
        defaults: tipo
      });
    }
  };

  return TipoSexo;
};
