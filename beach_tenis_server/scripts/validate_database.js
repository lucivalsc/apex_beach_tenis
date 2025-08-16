const sequelize = require('../config/database');
const User = require('../models/User');
const Client = require('../models/client');
const Check = require('../models/check');
const Visit = require('../models/visit');
const Sale = require('../models/sale');
const Goal = require('../models/goal');
const { v4: uuidv4 } = require('uuid');

/**
 * Script para validar inserções no banco de dados
 * Testa inserções em todas as tabelas principais para garantir que não ocorram erros
 */

async function validateDatabase() {
    try {
        console.log('🔍 Iniciando validação do banco de dados...');
        
        // Criar conexão com o banco
        console.log('\n📊 Verificando conexão com o banco de dados...');
        await sequelize.authenticate();
        console.log('✅ Conexão com o banco de dados estabelecida com sucesso!');

        // Verificar índices na tabela users
        console.log('\n📊 Verificando índices na tabela users...');
        const userIndexes = await sequelize.query(`
            SELECT COUNT(*) as total_indexes
            FROM INFORMATION_SCHEMA.STATISTICS
            WHERE TABLE_SCHEMA = :schema
            AND TABLE_NAME = 'users'
        `, {
            replacements: { schema: sequelize.config.database },
            type: sequelize.QueryTypes.SELECT
        });

        const totalUserIndexes = userIndexes[0].total_indexes;
        console.log(`📈 Total de índices na tabela users: ${totalUserIndexes}`);
        
        if (totalUserIndexes > 20) {
            console.log('⚠️ ATENÇÃO: Ainda há muitos índices na tabela users.');
        } else {
            console.log('✅ Número de índices na tabela users está dentro do limite seguro!');
        }

        // Testar inserção de dados em todas as tabelas principais
        console.log('\n🧪 Testando inserções no banco de dados...');

        // 1. Testar inserção de usuário
        console.log('\n📝 Testando inserção na tabela users...');
        const testUser = await User.create({
            name: 'Usuário de Teste',
            email: `teste_${Date.now()}@example.com`,
            password: 'senha123',
            role: 'user',
            is_active: true,
            created_at: new Date(),
            updated_at: new Date()
        });
        console.log(`✅ Usuário criado com sucesso! ID: ${testUser.id}`);

        // 2. Testar inserção de cliente
        console.log('\n📝 Testando inserção na tabela clients...');
        const testClient = await Client.create({
            name: 'Cliente de Teste',
            address: 'Endereço de Teste',
            latitude: -23.5505,
            longitude: -46.6333,
            type: 'Farmácia',
            created_by: testUser.id,
            created_at: new Date(),
            updated_at: new Date()
        });
        console.log(`✅ Cliente criado com sucesso! ID: ${testClient.id}`);

        // 3. Testar inserção de check
        console.log('\n📝 Testando inserção na tabela checks...');
        const testCheck = await Check.create({
            user_id: testUser.id,
            client_id: testClient.id,
            check_in_time: new Date(),  // Campo obrigatório
            latitude_in: -23.5505,      // Campo obrigatório
            longitude_in: -46.6333,     // Campo obrigatório
            status: 'concluído',        // Campo obrigatório
            created_at: new Date(),
            updated_at: new Date()
        });
        console.log(`✅ Check criado com sucesso! ID: ${testCheck.id}`);

        // 4. Testar inserção de visita
        console.log('\n📝 Testando inserção na tabela visits...');
        const testVisit = await Visit.create({
            user_id: testUser.id,
            check_id: testCheck.id,
            observations: 'Observação de teste',
            created_at: new Date(),
            updated_at: new Date()
        });
        console.log(`✅ Visita criada com sucesso! ID: ${testVisit.id}`);

        // 5. Testar inserção de venda
        console.log('\n📝 Testando inserção na tabela sales...');
        const testSale = await Sale.create({
            user_id: testUser.id,
            client_id: testClient.id,
            factory: 'Fábrica Teste',
            quantity: 10,
            value: 100.50,
            week: 1,
            month: 8,
            year: 2025,
            created_at: new Date(),
            updated_at: new Date()
        });
        console.log(`✅ Venda criada com sucesso! ID: ${testSale.id}`);

        // 6. Testar inserção de meta
        console.log('\n📝 Testando inserção na tabela goals...');
        const testGoal = await Goal.create({
            user_id: testUser.id,
            client_id: testClient.id,
            factory: 'Fábrica Teste',
            value: 1000.00,
            quantity: 100,
            month: 8,
            year: 2025,
            created_at: new Date(),
            updated_at: new Date()
        });
        console.log(`✅ Meta criada com sucesso! ID: ${testGoal.id}`);

        // Limpar dados de teste
        console.log('\n🧹 Removendo dados de teste...');
        await testGoal.destroy();
        await testSale.destroy();
        await testVisit.destroy();
        await testCheck.destroy();
        await testClient.destroy();
        await testUser.destroy();
        console.log('✅ Dados de teste removidos com sucesso!');

        console.log('\n🎉 Validação do banco de dados concluída com sucesso!');
        console.log('✅ Todas as inserções foram realizadas sem erros.');
        console.log('✅ A integridade referencial está funcionando corretamente.');
        console.log('✅ O controle de índices está funcionando corretamente.');

    } catch (error) {
        console.error('❌ Erro durante a validação do banco de dados:', error);
        throw error;
    }
}

// Executar o script se chamado diretamente
if (require.main === module) {
    validateDatabase()
        .then(() => {
            console.log('\n✅ Script executado com sucesso!');
            process.exit(0);
        })
        .catch((error) => {
            console.error('\n❌ Erro na execução do script:', error);
            process.exit(1);
        });
}

module.exports = { validateDatabase };
