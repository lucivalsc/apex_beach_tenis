'use strict';

module.exports = (sequelize, DataTypes) => {
  const StatusAssinatura = sequelize.define('StatusAssinatura', {
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
    createdAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updatedAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'status_assinaturas',
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

  StatusAssinatura.associate = function(models) {
    StatusAssinatura.hasMany(models.Arena, {
      foreignKey: 'status_assinatura_id',
      as: 'arenas'
    });
    
    StatusAssinatura.hasMany(models.Assinatura, {
      foreignKey: 'status_id',
      as: 'assinaturas'
    });
  };

  // Método para inserir os valores padrão
  StatusAssinatura.insertDefaultValues = async function() {
    const statusAssinaturas = [
      { nome: 'Ativo', descricao: 'Assinatura ativa e em dia', codigo: 'ATIVO', ativo: true },
      { nome: 'Inativo', descricao: 'Assinatura inativa', codigo: 'INATIVO', ativo: true },
      { nome: 'Suspenso', descricao: 'Assinatura temporariamente suspensa', codigo: 'SUSPENSO', ativo: true },
      { nome: 'Cancelado', descricao: 'Assinatura cancelada', codigo: 'CANCELADO', ativo: true },
      { nome: 'Vencida', descricao: 'Assinatura com pagamento vencido', codigo: 'VENCIDA', ativo: true }
    ];

    for (const status of statusAssinaturas) {
      await this.findOrCreate({
        where: { codigo: status.codigo },
        defaults: status
      });
    }
  };

  return StatusAssinatura;
};
