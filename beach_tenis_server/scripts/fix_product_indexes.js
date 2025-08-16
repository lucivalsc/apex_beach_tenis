const sequelize = require('../config/database');

/**
 * Script para remover índices duplicados na tabela products
 * Similar ao script fix_duplicate_indexes.js para a tabela users
 */

async function fixProductIndexes() {
    try {
        console.log('🔧 Iniciando remoção de índices duplicados na tabela products...');

        // 1. Listar todos os índices da tabela products
        console.log('\n📊 Verificando índices na tabela products...');
        const productIndexes = await sequelize.query(`
            SELECT 
                INDEX_NAME,
                COLUMN_NAME,
                NON_UNIQUE
            FROM INFORMATION_SCHEMA.STATISTICS 
            WHERE TABLE_SCHEMA = :schema
            AND TABLE_NAME = 'products'
            ORDER BY INDEX_NAME, SEQ_IN_INDEX
        `, {
            replacements: { schema: sequelize.config.database },
            type: sequelize.QueryTypes.SELECT
        });

        // Agrupar índices por nome para identificar colunas múltiplas
        const indexGroups = {};
        productIndexes.forEach(index => {
            if (!indexGroups[index.INDEX_NAME]) {
                indexGroups[index.INDEX_NAME] = [];
            }
            indexGroups[index.INDEX_NAME].push(index);
        });

        console.log(`Encontrados ${Object.keys(indexGroups).length} índices na tabela products:`);
        
        for (const [indexName, columns] of Object.entries(indexGroups)) {
            const columnNames = columns.map(col => col.COLUMN_NAME).join(', ');
            const isUnique = columns[0].NON_UNIQUE === 0 ? 'Único' : 'Não único';
            console.log(`  - ${indexName} (${columnNames}) - ${isUnique}`);
        }

        // 2. Identificar índices essenciais para manter
        const essentialIndexes = ['PRIMARY'];
        
        // Identificar índices duplicados para remover
        const indexesToRemove = Object.keys(indexGroups).filter(indexName => {
            // Manter índices essenciais
            if (essentialIndexes.includes(indexName)) {
                return false;
            }
            
            // Identificar índices duplicados por padrão de nome (ex: name_2, name_3)
            const baseIndexName = indexName.replace(/_\d+$/, '');
            return indexName !== baseIndexName || Object.keys(indexGroups).includes(baseIndexName);
        });

        // 3. Remover índices duplicados
        console.log('\n🧹 Removendo índices duplicados...');
        
        let removedCount = 0;

        for (const indexName of indexesToRemove) {
            try {
                await sequelize.query(`DROP INDEX \`${indexName}\` ON products`);
                console.log(`  🗑️ Removido índice: ${indexName}`);
                removedCount++;
            } catch (error) {
                console.log(`  ⚠️ Erro ao remover ${indexName}: ${error.message}`);
            }
        }

        console.log(`\n📊 Resumo: ${removedCount} índices removidos`);

        // 4. Verificar contagem final de índices
        console.log('\n📈 Verificação final...');
        const finalIndexes = await sequelize.query(`
            SELECT COUNT(DISTINCT INDEX_NAME) as total_indexes
            FROM INFORMATION_SCHEMA.STATISTICS 
            WHERE TABLE_SCHEMA = :schema
            AND TABLE_NAME = 'products'
        `, {
            replacements: { schema: sequelize.config.database },
            type: sequelize.QueryTypes.SELECT
        });

        const totalIndexes = finalIndexes[0].total_indexes;
        console.log(`Total de índices após limpeza: ${totalIndexes}`);
        
        if (totalIndexes > 20) {
            console.log('⚠️ ATENÇÃO: Ainda há muitos índices. Pode ser necessária limpeza adicional.');
        } else {
            console.log('✅ Número de índices dentro do limite seguro!');
        }

        // 5. Criar apenas os índices essenciais se necessário
        if (totalIndexes <= 5) {
            console.log('\n🔨 Criando índices essenciais...');
            
            const essentialIndexesToCreate = [
                {
                    name: 'idx_products_name',
                    sql: 'CREATE INDEX IF NOT EXISTS `idx_products_name` ON `products`(`name`)',
                    description: 'Índice para name (consultas frequentes)'
                },
                {
                    name: 'idx_products_active',
                    sql: 'CREATE INDEX IF NOT EXISTS `idx_products_active` ON `products`(`active`)',
                    description: 'Índice para active'
                }
            ];

            for (const index of essentialIndexesToCreate) {
                try {
                    await sequelize.query(index.sql);
                    console.log(`  ✅ Criado: ${index.name} - ${index.description}`);
                } catch (error) {
                    console.log(`  ⚠️ Erro ao criar ${index.name}: ${error.message}`);
                }
            }
        }

        console.log('\n🎉 Correção de índices na tabela products concluída com sucesso!');

    } catch (error) {
        console.error('❌ Erro durante a correção de índices:', error);
        throw error;
    }
}

// Executar o script se chamado diretamente
if (require.main === module) {
    fixProductIndexes()
        .then(() => {
            console.log('\n✅ Script executado com sucesso!');
            process.exit(0);
        })
        .catch((error) => {
            console.error('\n❌ Erro na execução do script:', error);
            process.exit(1);
        });
}

module.exports = { fixProductIndexes };
