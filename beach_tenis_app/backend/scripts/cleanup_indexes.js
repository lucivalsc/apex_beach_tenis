const sequelize = require('../config/database');

/**
 * Script para limpar índices excessivos e recriar apenas os essenciais
 * Resolve o problema: "Too many keys specified; max 64 keys allowed"
 */

async function cleanupIndexes() {
    try {
        console.log('🔧 Iniciando limpeza de índices...');

        // 1. Listar todos os índices atuais da tabela users
        console.log('\n📊 Verificando índices atuais da tabela users...');
        const currentIndexes = await sequelize.query(`
            SELECT 
                INDEX_NAME,
                COLUMN_NAME,
                NON_UNIQUE,
                INDEX_TYPE
            FROM INFORMATION_SCHEMA.STATISTICS 
            WHERE TABLE_SCHEMA = :schema
            AND TABLE_NAME = 'users'
            ORDER BY INDEX_NAME, SEQ_IN_INDEX
        `, {
            replacements: { schema: sequelize.config.database },
            type: sequelize.QueryTypes.SELECT
        });

        console.log(`Encontrados ${currentIndexes.length} índices na tabela users:`);
        currentIndexes.forEach(index => {
            console.log(`  - ${index.INDEX_NAME} (${index.COLUMN_NAME}) - Único: ${index.NON_UNIQUE === 0}`);
        });

        // 2. Listar foreign keys que referenciam users
        console.log('\n🔗 Verificando foreign keys que referenciam users...');
        const foreignKeys = await sequelize.query(`
            SELECT 
                CONSTRAINT_NAME,
                TABLE_NAME,
                COLUMN_NAME
            FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
            WHERE REFERENCED_TABLE_SCHEMA = :schema
            AND REFERENCED_TABLE_NAME = 'users'
        `, {
            replacements: { schema: sequelize.config.database },
            type: sequelize.QueryTypes.SELECT
        });

        console.log(`Encontradas ${foreignKeys.length} foreign keys referenciando users:`);
        foreignKeys.forEach(fk => {
            console.log(`  - ${fk.TABLE_NAME}.${fk.COLUMN_NAME} (${fk.CONSTRAINT_NAME})`);
        });

        // 3. Remover índices desnecessários (manter apenas os essenciais)
        console.log('\n🧹 Removendo índices desnecessários...');
        
        const indexesToKeep = [
            'PRIMARY',           // Chave primária
            'email',            // Índice único do email
            'idx_users_email',  // Variações do índice de email
            'idx_users_email_unique'
        ];

        for (const index of currentIndexes) {
            const indexName = index.INDEX_NAME;
            
            // Pular índices essenciais
            if (indexesToKeep.some(keep => indexName.includes(keep))) {
                console.log(`  ✅ Mantendo índice essencial: ${indexName}`);
                continue;
            }

            // Remover índices desnecessários
            try {
                await sequelize.query(`DROP INDEX \`${indexName}\` ON users`);
                console.log(`  🗑️ Removido índice: ${indexName}`);
            } catch (error) {
                console.log(`  ⚠️ Erro ao remover ${indexName}: ${error.message}`);
            }
        }

        // 4. Recriar apenas índices essenciais
        console.log('\n🔨 Recriando índices essenciais...');
        
        const essentialIndexes = [
            {
                name: 'idx_users_email_unique',
                sql: 'CREATE UNIQUE INDEX IF NOT EXISTS `idx_users_email_unique` ON `users`(`email`)',
                description: 'Índice único para email'
            },
            {
                name: 'idx_users_manager_id',
                sql: 'CREATE INDEX IF NOT EXISTS `idx_users_manager_id` ON `users`(`manager_id`)',
                description: 'Índice para manager_id (foreign key)'
            },
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

        // 5. Verificação final
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

        console.log(`Total de índices após limpeza: ${finalIndexes[0].total_indexes}`);
        
        if (finalIndexes[0].total_indexes > 20) {
            console.log('⚠️ ATENÇÃO: Ainda há muitos índices. Pode ser necessária limpeza manual adicional.');
        } else {
            console.log('✅ Número de índices dentro do limite seguro!');
        }

        console.log('\n🎉 Limpeza de índices concluída com sucesso!');

    } catch (error) {
        console.error('❌ Erro durante a limpeza de índices:', error);
        throw error;
    }
}

// Executar o script se chamado diretamente
if (require.main === module) {
    cleanupIndexes()
        .then(() => {
            console.log('\n✅ Script executado com sucesso!');
            process.exit(0);
        })
        .catch((error) => {
            console.error('\n❌ Erro na execução do script:', error);
            process.exit(1);
        });
}

module.exports = { cleanupIndexes };
