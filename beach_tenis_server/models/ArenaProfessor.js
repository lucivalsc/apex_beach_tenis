'use strict';

module.exports = (sequelize, DataTypes) => {
  const ArenaProfessor = sequelize.define('ArenaProfessor', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    arena_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'arenas',
        key: 'id'
      }
    },
    professor_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'professores',
        key: 'id'
      }
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    data_vinculo: {
      type: DataTypes.DATEONLY,
      defaultValue: DataTypes.NOW
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'arena_professores',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: false,
    indexes: [
      {
        name: 'idx_arena',
        fields: ['arena_id']
      },
      {
        name: 'idx_professor',
        fields: ['professor_id']
      },
      {
        name: 'unique_arena_professor',
        unique: true,
        fields: ['arena_id', 'professor_id']
      }
    ]
  });

  ArenaProfessor.associate = function(models) {
    ArenaProfessor.belongsTo(models.Arena, {
      foreignKey: 'arena_id',
      as: 'arena',
      onDelete: 'CASCADE'
    });
    
    ArenaProfessor.belongsTo(models.Professor, {
      foreignKey: 'professor_id',
      as: 'professor',
      onDelete: 'CASCADE'
    });
  };

  return ArenaProfessor;
};
