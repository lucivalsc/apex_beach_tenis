'use strict';

module.exports = (sequelize, DataTypes) => {
    const TipoEndereco = sequelize.define('TipoEndereco', {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        nome: {
            type: DataTypes.STRING(100),
            allowNull: false
        },
        codigo: {
            type: DataTypes.STRING(50),
            allowNull: false,
            unique: true
        },
        descricao: {
            type: DataTypes.STRING(255),
            allowNull: true
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
        tableName: 'tipos_endereco',
        timestamps: true,
        indexes: [
            {
                name: 'idx_tipo_endereco_codigo',
                fields: ['codigo'],
                unique: true
            },
            {
                name: 'idx_tipo_endereco_ativo',
                fields: ['ativo']
            }
        ]
    });

    TipoEndereco.associate = function (models) {
        TipoEndereco.hasMany(models.Endereco, {
            foreignKey: 'tipo_endereco_id',
            as: 'enderecos'
        });
    };

    // Método para inserir os valores padrão - VERSÃO COMPLETA
    TipoEndereco.insertDefaultValues = async function () {
        const tiposEndereco = [
            // Endereços Residenciais
            {
                nome: 'Residencial',
                descricao: 'Endereço residencial principal',
                codigo: 'RESIDENCIAL',
                ativo: true
            },
            {
                nome: 'Casa',
                descricao: 'Endereço de casa própria',
                codigo: 'CASA',
                ativo: true
            },
            {
                nome: 'Apartamento',
                descricao: 'Endereço de apartamento',
                codigo: 'APARTAMENTO',
                ativo: true
            },
            {
                nome: 'Kitnet',
                descricao: 'Endereço de kitnet/studio',
                codigo: 'KITNET',
                ativo: true
            },
            {
                nome: 'Condomínio',
                descricao: 'Endereço em condomínio fechado',
                codigo: 'CONDOMINIO',
                ativo: true
            },
            {
                nome: 'Casa de Veraneio',
                descricao: 'Casa de praia/campo/veraneio',
                codigo: 'CASA_VERANEIO',
                ativo: true
            },
            {
                nome: 'República',
                descricao: 'Endereço de república estudantil',
                codigo: 'REPUBLICA',
                ativo: true
            },

            // Endereços Comerciais
            {
                nome: 'Comercial',
                descricao: 'Endereço comercial genérico',
                codigo: 'COMERCIAL',
                ativo: true
            },
            {
                nome: 'Escritório',
                descricao: 'Endereço de escritório/consultório',
                codigo: 'ESCRITORIO',
                ativo: true
            },
            {
                nome: 'Loja',
                descricao: 'Endereço de loja/varejo',
                codigo: 'LOJA',
                ativo: true
            },
            {
                nome: 'Empresa',
                descricao: 'Endereço da sede da empresa',
                codigo: 'EMPRESA',
                ativo: true
            },
            {
                nome: 'Filial',
                descricao: 'Endereço de filial da empresa',
                codigo: 'FILIAL',
                ativo: true
            },
            {
                nome: 'Fábrica',
                descricao: 'Endereço de fábrica/indústria',
                codigo: 'FABRICA',
                ativo: true
            },
            {
                nome: 'Depósito',
                descricao: 'Endereço de depósito/armazém',
                codigo: 'DEPOSITO',
                ativo: true
            },
            {
                nome: 'Centro de Distribuição',
                descricao: 'Endereço de centro de distribuição',
                codigo: 'CENTRO_DISTRIBUICAO',
                ativo: true
            },

            // Endereços Esportivos (específicos para Beach Tênis)
            {
                nome: 'Arena Esportiva',
                descricao: 'Endereço de arena de beach tênis',
                codigo: 'ARENA_ESPORTIVA',
                ativo: true
            },
            {
                nome: 'Quadra de Beach Tênis',
                descricao: 'Endereço específico de quadra',
                codigo: 'QUADRA_BEACH_TENIS',
                ativo: true
            },
            {
                nome: 'Clube Esportivo',
                descricao: 'Endereço de clube esportivo',
                codigo: 'CLUBE_ESPORTIVO',
                ativo: true
            },
            {
                nome: 'Centro de Treinamento',
                descricao: 'Endereço de centro de treinamento esportivo',
                codigo: 'CENTRO_TREINAMENTO',
                ativo: true
            },
            {
                nome: 'Academia',
                descricao: 'Endereço de academia/ginásio',
                codigo: 'ACADEMIA',
                ativo: true
            },

            // Endereços Educacionais
            {
                nome: 'Escola',
                descricao: 'Endereço de escola/colégio',
                codigo: 'ESCOLA',
                ativo: true
            },
            {
                nome: 'Universidade',
                descricao: 'Endereço de universidade/faculdade',
                codigo: 'UNIVERSIDADE',
                ativo: true
            },
            {
                nome: 'Curso Técnico',
                descricao: 'Endereço de curso técnico/profissionalizante',
                codigo: 'CURSO_TECNICO',
                ativo: true
            },

            // Endereços de Saúde
            {
                nome: 'Hospital',
                descricao: 'Endereço de hospital/clínica',
                codigo: 'HOSPITAL',
                ativo: true
            },
            {
                nome: 'Consultório',
                descricao: 'Endereço de consultório médico',
                codigo: 'CONSULTORIO',
                ativo: true
            },
            {
                nome: 'Clínica',
                descricao: 'Endereço de clínica especializada',
                codigo: 'CLINICA',
                ativo: true
            },
            {
                nome: 'Fisioterapia',
                descricao: 'Endereço de clínica de fisioterapia',
                codigo: 'FISIOTERAPIA',
                ativo: true
            },

            // Endereços Especiais/Temporários
            {
                nome: 'Temporário',
                descricao: 'Endereço temporário',
                codigo: 'TEMPORARIO',
                ativo: true
            },
            {
                nome: 'Entrega',
                descricao: 'Endereço apenas para entrega',
                codigo: 'ENTREGA',
                ativo: true
            },
            {
                nome: 'Cobrança',
                descricao: 'Endereço para correspondência/cobrança',
                codigo: 'COBRANCA',
                ativo: true
            },
            {
                nome: 'Correspondência',
                descricao: 'Endereço para correspondência',
                codigo: 'CORRESPONDENCIA',
                ativo: true
            },
            {
                nome: 'Caixa Postal',
                descricao: 'Endereço de caixa postal',
                codigo: 'CAIXA_POSTAL',
                ativo: true
            },

            // Endereços Familiares
            {
                nome: 'Casa dos Pais',
                descricao: 'Endereço da casa dos pais',
                codigo: 'CASA_PAIS',
                ativo: true
            },
            {
                nome: 'Casa de Familiares',
                descricao: 'Endereço de familiares',
                codigo: 'CASA_FAMILIARES',
                ativo: true
            },

            // Endereços de Viagem/Hospedagem
            {
                nome: 'Hotel',
                descricao: 'Endereço de hotel/pousada',
                codigo: 'HOTEL',
                ativo: true
            },
            {
                nome: 'Pousada',
                descricao: 'Endereço de pousada',
                codigo: 'POUSADA',
                ativo: true
            },
            {
                nome: 'Airbnb',
                descricao: 'Endereço de hospedagem Airbnb',
                codigo: 'AIRBNB',
                ativo: true
            },

            // Outros
            {
                nome: 'Outro',
                descricao: 'Outro tipo de endereço não especificado',
                codigo: 'OUTRO',
                ativo: true
            },
            {
                nome: 'Não Informado',
                descricao: 'Tipo de endereço não informado',
                codigo: 'NAO_INFORMADO',
                ativo: true
            }
        ];

        console.log('🏠 Inserindo tipos de endereço padrão...');

        let insertedCount = 0;
        let existingCount = 0;

        const now = new Date();
        
        for (const tipo of tiposEndereco) {
            // Adicionar timestamps aos dados
            const tipoComTimestamps = {
                ...tipo,
                createdAt: now,
                updatedAt: now
            };
            
            const [record, created] = await this.findOrCreate({
                where: { codigo: tipo.codigo },
                defaults: tipoComTimestamps
            });

            if (created) {
                insertedCount++;
                console.log(`✅ Criado: ${tipo.nome} (${tipo.codigo})`);
            } else {
                existingCount++;
            }
        }

        console.log(`📊 Resumo da inserção de tipos de endereço:`);
        console.log(`   • Novos tipos criados: ${insertedCount}`);
        console.log(`   • Tipos já existentes: ${existingCount}`);
        console.log(`   • Total de tipos: ${tiposEndereco.length}`);
        console.log('🏠 Tipos de endereço configurados com sucesso!\n');
    };

    return TipoEndereco;
};
