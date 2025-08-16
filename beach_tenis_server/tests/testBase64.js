/**
 * Script para testar a conversão de base64 para BLOB e vice-versa
 */
const VisitImage = require('../models/visitImage');
const sequelize = require('../config/database');
const User = require('../models/User');
const Visit = require('../models/visit');

// Função para testar a conversão de base64 para BLOB e vice-versa diretamente
async function testBase64Handling() {
    try {
        console.log('Iniciando teste de manipulação de dados base64...');
        
        // Conectar ao banco de dados
        await sequelize.authenticate();
        console.log('Conexão com o banco de dados estabelecida com sucesso.');
        
        // Dados de teste em base64 (pequena imagem de exemplo)
        const testBase64 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==';
        
        // Testar diretamente as funções de conversão
        console.log('Testando funções de conversão diretamente...');
        
        // Simular a conversão que aconteceria no modelo
        const convertBase64ToBuffer = (value) => {
            if (!value) return null;
            
            try {
                // Verifica se o valor já é um Buffer
                if (Buffer.isBuffer(value)) return value;
                
                // Verifica se é uma string base64
                if (typeof value === 'string') {
                    // Remove o prefixo de data URI se existir (ex: 'data:image/jpeg;base64,')
                    const base64Data = value.includes('base64,') ? value.split('base64,')[1] : value;
                    return Buffer.from(base64Data, 'base64');
                }
                
                return null;
            } catch (error) {
                console.error('Erro ao converter base64 para buffer:', error);
                return null;
            }
        };
        
        const convertBufferToBase64 = (value) => {
            if (!value) return null;
            
            try {
                // Verifica se o valor é um Buffer
                if (Buffer.isBuffer(value)) {
                    return value.toString('base64');
                }
                
                // Se já for uma string, assume que já está em base64
                if (typeof value === 'string') return value;
                
                return null;
            } catch (error) {
                console.error('Erro ao converter buffer para base64:', error);
                return null;
            }
        };
        
        // Converter base64 para buffer
        const buffer = convertBase64ToBuffer(testBase64);
        console.log('Buffer criado com sucesso, tamanho:', buffer ? buffer.length : 'null');
        
        // Converter buffer de volta para base64
        const base64Back = convertBufferToBase64(buffer);
        console.log('Base64 recuperado com sucesso, tamanho:', base64Back ? base64Back.length : 'null');
        
        // Verificar se a conversão foi bem-sucedida
        const originalBase64 = testBase64.includes('base64,') ? testBase64.split('base64,')[1] : testBase64;
        const conversionSuccessful = base64Back === originalBase64;
        
        console.log('Conversão bem-sucedida:', conversionSuccessful);
        console.log('Dados base64 originais (primeiros 30 caracteres):', originalBase64.substring(0, 30) + '...');
        console.log('Dados base64 recuperados (primeiros 30 caracteres):', 
            base64Back ? base64Back.substring(0, 30) + '...' : 'null');
        
        // Executar uma query SQL direta para testar a inserção e recuperação
        console.log('\nTestando inserção e recuperação direta via SQL...');
        
        // Criar uma tabela temporária para teste
        await sequelize.query(`
            CREATE TEMPORARY TABLE IF NOT EXISTS temp_blob_test (
                id INT AUTO_INCREMENT PRIMARY KEY,
                blob_data LONGBLOB
            )
        `);
        
        // Inserir dados na tabela temporária
        await sequelize.query(`
            INSERT INTO temp_blob_test (blob_data) VALUES (?)
        `, {
            replacements: [buffer]
        });
        
        // Recuperar dados da tabela temporária
        const [results] = await sequelize.query(`
            SELECT * FROM temp_blob_test WHERE id = LAST_INSERT_ID()
        `);
        
        if (results && results.length > 0) {
            const retrievedBuffer = results[0].blob_data;
            console.log('Dados recuperados com sucesso do banco de dados');
            console.log('Tamanho do buffer recuperado:', Buffer.isBuffer(retrievedBuffer) ? retrievedBuffer.length : 'não é um buffer');
            
            // Converter o buffer recuperado para base64
            const retrievedBase64 = Buffer.isBuffer(retrievedBuffer) ? retrievedBuffer.toString('base64') : null;
            console.log('Base64 recuperado do banco (primeiros 30 caracteres):', 
                retrievedBase64 ? retrievedBase64.substring(0, 30) + '...' : 'null');
        } else {
            console.log('Nenhum dado recuperado do banco de dados');
        }
        
        console.log('\nTeste concluído com sucesso!');
        

    } catch (error) {
        console.error('Erro durante o teste:', error);
    } finally {
        // Fechar conexão
        await sequelize.close();
        console.log('Conexão com o banco de dados fechada');
    }
}

// Executar o teste
testBase64Handling();
