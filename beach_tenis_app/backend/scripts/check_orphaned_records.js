const sequelize = require('../config/database');
const Visit = require('../models/visit');
const Check = require('../models/check');
const User = require('../models/User');
const Client = require('../models/client');

/**
 * Script para verificar registros órfãos entre tabelas relacionadas
 * Identifica e lista registros que violam integridade referencial
 */

async function checkOrphanedRecords() {
    try {
        console.log('🔍 Iniciando verificação de registros órfãos...');

        // 1. Verificar visitas com check_id inexistente
        console.log('\n📋 Verificando visitas com check_id inexistente...');
        const orphanedVisits = await sequelize.query(`
            SELECT v.id, v.check_id, v.user_id, v.created_at
            FROM visits v
            LEFT JOIN checks c ON v.check_id = c.id
            WHERE c.id IS NULL
        `, {
            type: sequelize.QueryTypes.SELECT
        });

        if (orphanedVisits.length > 0) {
            console.log(`⚠️ Encontrados ${orphanedVisits.length} registros de visitas órfãs:`);
            orphanedVisits.forEach((visit, index) => {
                console.log(`  ${index + 1}. ID: ${visit.id}, Check ID inexistente: ${visit.check_id}, User ID: ${visit.user_id}`);
            });

            // Opção para corrigir: remover registros órfãos
            console.log('\n🧹 Deseja remover estes registros órfãos? Execute o comando:');
            console.log('   node scripts/fix_orphaned_records.js --delete-orphaned-visits');
        } else {
            console.log('✅ Não foram encontradas visitas órfãs.');
        }

        // 2. Verificar checks com client_id inexistente
        console.log('\n📋 Verificando checks com client_id inexistente...');
        const orphanedChecks = await sequelize.query(`
            SELECT c.id, c.client_id, c.user_id, c.created_at
            FROM checks c
            LEFT JOIN clients cl ON c.client_id = cl.id
            WHERE cl.id IS NULL
        `, {
            type: sequelize.QueryTypes.SELECT
        });

        if (orphanedChecks.length > 0) {
            console.log(`⚠️ Encontrados ${orphanedChecks.length} registros de checks órfãos:`);
            orphanedChecks.forEach((check, index) => {
                console.log(`  ${index + 1}. ID: ${check.id}, Client ID inexistente: ${check.client_id}, User ID: ${check.user_id}`);
            });

            // Opção para corrigir: remover registros órfãos
            console.log('\n🧹 Deseja remover estes registros órfãos? Execute o comando:');
            console.log('   node scripts/fix_orphaned_records.js --delete-orphaned-checks');
        } else {
            console.log('✅ Não foram encontrados checks órfãos.');
        }

        // 3. Verificar checks com user_id inexistente
        console.log('\n📋 Verificando checks com user_id inexistente...');
        const checksWithInvalidUser = await sequelize.query(`
            SELECT c.id, c.client_id, c.user_id, c.created_at
            FROM checks c
            LEFT JOIN users u ON c.user_id = u.id
            WHERE u.id IS NULL
        `, {
            type: sequelize.QueryTypes.SELECT
        });

        if (checksWithInvalidUser.length > 0) {
            console.log(`⚠️ Encontrados ${checksWithInvalidUser.length} checks com user_id inexistente:`);
            checksWithInvalidUser.forEach((check, index) => {
                console.log(`  ${index + 1}. ID: ${check.id}, User ID inexistente: ${check.user_id}`);
            });
        } else {
            console.log('✅ Não foram encontrados checks com user_id inexistente.');
        }

        // 4. Verificar visitas com user_id inexistente
        console.log('\n📋 Verificando visitas com user_id inexistente...');
        const visitsWithInvalidUser = await sequelize.query(`
            SELECT v.id, v.check_id, v.user_id, v.created_at
            FROM visits v
            LEFT JOIN users u ON v.user_id = u.id
            WHERE u.id IS NULL
        `, {
            type: sequelize.QueryTypes.SELECT
        });

        if (visitsWithInvalidUser.length > 0) {
            console.log(`⚠️ Encontrados ${visitsWithInvalidUser.length} visitas com user_id inexistente:`);
            visitsWithInvalidUser.forEach((visit, index) => {
                console.log(`  ${index + 1}. ID: ${visit.id}, User ID inexistente: ${visit.user_id}`);
            });
        } else {
            console.log('✅ Não foram encontradas visitas com user_id inexistente.');
        }

        console.log('\n🎉 Verificação de registros órfãos concluída!');

    } catch (error) {
        console.error('❌ Erro durante a verificação de registros órfãos:', error);
        throw error;
    }
}

// Executar o script se chamado diretamente
if (require.main === module) {
    checkOrphanedRecords()
        .then(() => {
            console.log('\n✅ Script executado com sucesso!');
            process.exit(0);
        })
        .catch((error) => {
            console.error('\n❌ Erro na execução do script:', error);
            process.exit(1);
        });
}

module.exports = { checkOrphanedRecords };
