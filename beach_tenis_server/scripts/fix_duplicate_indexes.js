const sequelize = require('../config/database');

/**
 * Script para remover índices duplicados do email na tabela users
 * Problema identificado: 62 índices duplicados (email, email_2, email_3, ..., email_62)
 */

async function fixDuplicateIndexes() {
    try {
        console.log('🔧 Iniciando remoção de índices duplicados do email...');

        // 1. Listar todos os índices de email
        console.log('\n📊 Verificando índices de email duplicados...');
        const emailIndexes = await sequelize.query(`
            SELECT 
                INDEX_NAME,
                COLUMN_NAME,
                NON_UNIQUE
            FROM INFORMATION_SCHEMA.STATISTICS 
            WHERE TABLE_SCHEMA = :schema
            AND TABLE_NAME = 'users'
            AND COLUMN_NAME = 'email'
            ORDER BY INDEX_NAME
        `, {
            replacements: { schema: sequelize.config.database },
            type: sequelize.QueryTypes.SELECT
        });

        console.log(`Encontrados ${emailIndexes.length} índices para a coluna email:`);
        emailIndexes.forEach(index => {
            console.log(`  - ${index.INDEX_NAME} (${index.COLUMN_NAME}) - Único: ${index.NON_UNIQUE === 0}`);
        });

        // 2. Remover todos os índices duplicados, mantendo apenas o primeiro
        console.log('\n🧹 Removendo índices duplicados do email...');
        
        let removedCount = 0;
        let keptFirst = false;

        for (const index of emailIndexes) {
            const indexName = index.INDEX_NAME;
            
            // Manter apenas o primeiro índice de email
            if (!keptFirst && indexName === 'email') {
                console.log(`  ✅ Mantendo índice original: ${indexName}`);
                keptFirst = true;
                continue;
            }

            // Remover todos os outros índices duplicados
            try {
                await sequelize.query(`DROP INDEX \`${indexName}\` ON users`);
                console.log(`  🗑️ Removido índice duplicado: ${indexName}`);
                removedCount++;
            } catch (error) {
                console.log(`  ⚠️ Erro ao remover ${indexName}: ${error.message}`);
            }
        }

        console.log(`\n📊 Resumo: ${removedCount} índices duplicados removidos`);

        // 3. Verificar contagem final de índices
        console.log('\n📈 Verificação final...');
        const finalIndexes = await sequelize.query(`
            SELECT COUNT(*) as total_indexes
            FROM INFORMATION_SCHEMA.STATISTICS 
            WHERE TABLE_SCHEMA = :schema
            AND TABLE_NAME = 'users'
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

        // 4. Criar apenas os índices essenciais se necessário
        if (totalIndexes <= 10) {
            console.log('\n🔨 Criando índices essenciais...');
            
            const essentialIndexes = [
                {
                    name: 'idx_users_role',
                    sql: 'CREATE INDEX IF NOT EXISTS `idx_users_role` ON `users`(`role`)',
                    description: 'Índice para role (consultas frequentes)'
                },
                {
                    name: 'idx_users_active',
                    sql: 'CREATE INDEX IF NOT EXISTS `idx_users_active` ON `users`(`is_active`)',
                    description: 'Índice para is_active'
                }
            ];

            for (const index of essentialIndexes) {
                try {
                    await sequelize.query(index.sql);
                    console.log(`  ✅ Criado: ${index.name} - ${index.description}`);
                } catch (error) {
                    console.log(`  ⚠️ Erro ao criar ${index.name}: ${error.message}`);
                }
            }
        }

        console.log('\n🎉 Correção de índices duplicados concluída com sucesso!');

    } catch (error) {
        console.error('❌ Erro durante a correção de índices duplicados:', error);
        throw error;
    }
}

// Executar o script se chamado diretamente
if (require.main === module) {
    fixDuplicateIndexes()
        .then(() => {
            console.log('\n✅ Script executado com sucesso!');
            process.exit(0);
        })
        .catch((error) => {
            console.error('\n❌ Erro na execução do script:', error);
            process.exit(1);
        });
}

module.exports = { fixDuplicateIndexes };
