const express = require('express');
const fs = require('fs').promises;
const path = require('path');
const os = require('os');
const archiver = require('archiver');
const { v4: uuidv4 } = require('uuid');
const sequelize = require('../config/database');
const { Op } = require('sequelize');
const models = require('../models');
const { ApiError, ErrorCodes, sendErrorResponse } = require('../utils/errorHandler');
const authenticateToken = require('../middleware/authMiddleware').authenticateToken;

// --- Configuração ---
const TEMP_DIR = path.join(os.tmpdir(), 'ontarget-json-processor');

async function ensureTempDir() {
    try {
        await fs.mkdir(TEMP_DIR, { recursive: true });
    } catch (error) {
        console.error('Erro crítico ao criar diretório temporário:', error);
        throw new Error(`Falha ao configurar diretórios: ${error.message}`);
    }
}
ensureTempDir().catch(console.error);

const router = express.Router();

// --- Definição de Tabelas ---
const TABELAS_SEM_FILTRO_USUARIO = [
    'users', 'client_types', 'specialities', 'services', 'brands', 'products'
];
const TABELAS_COM_FILTRO_USUARIO = [
    'checks', 'goals', 'sales', 'visits', 'sale_products', 'clients'
];
const TABELAS_INICIALIZACAO = [
    'users', 'client_types', 'specialities', 'services', 'brands'
];
const TODAS_AS_TABELAS = [
    ...TABELAS_SEM_FILTRO_USUARIO,
    ...TABELAS_COM_FILTRO_USUARIO
];


// --- Classe Principal de Processamento ---
class ProcessadorJSON {
    constructor(cdUserApp) {
        this.guid = uuidv4();
        this.caminhoTemporario = path.join(TEMP_DIR, this.guid);
        this.sequelize = sequelize;
        this.cdUserApp = cdUserApp;
    }

    async inicializar() {
        try {
            await fs.mkdir(this.caminhoTemporario, { recursive: true });
            await this.verificarConexaoBanco();
        } catch (error) {
            throw new ApiError(ErrorCodes.INITIALIZATION_ERROR, `Falha na inicialização: ${error.message}`);
        }
    }

    async verificarConexaoBanco() {
        try {
            await this.sequelize.authenticate();
        } catch (error) {
            if (error.original?.code === 'ER_ACCESS_DENIED_ERROR') {
                throw new ApiError(ErrorCodes.DATABASE_AUTH_ERROR, 'Falha na autenticação com o banco de dados.');
            }
            if (error.original?.code === 'ER_BAD_DB_ERROR') {
                throw new ApiError(ErrorCodes.DATABASE_NOT_FOUND, `Banco de dados não encontrado.`);
            }
            throw new ApiError(ErrorCodes.DATABASE_CONNECTION_ERROR, `Não foi possível conectar ao banco de dados.`);
        }
    }

    async iniciarProcesso(key) {
        try {
            const tabelasParaProcessar = key === 'start' ? TABELAS_INICIALIZACAO : TODAS_AS_TABELAS;
            const tabelasProcessadasComSucesso = await this.processarTabelas(tabelasParaProcessar);

            if (tabelasProcessadasComSucesso.length === 0) {
                throw new ApiError(ErrorCodes.NO_DATA_FOUND, 'Nenhuma tabela foi processada com sucesso.');
            }

            return await this.criarArquivoZip(tabelasProcessadasComSucesso);
        } catch (error) {
            if (error instanceof ApiError) throw error;
            throw new ApiError(ErrorCodes.PROCESSING_ERROR, `Falha durante o processamento: ${error.message}`);
        }
    }

    async processarTabelas(tabelas) {
        const tabelasProcessadas = [];
        for (const nomeTabela of tabelas) {
            try {
                await this.consultarESalvarDados(nomeTabela);
                tabelasProcessadas.push(nomeTabela);
            } catch (error) {
                console.error(`Falha ao processar a tabela ${nomeTabela}: ${error.message}`);
            }
        }
        return tabelasProcessadas;
    }

    async consultarESalvarDados(tabela) {
        const precisaFiltro = TABELAS_COM_FILTRO_USUARIO.includes(tabela);
        let rows = [];

        try {
            // Verificar se o modelo existe para a tabela
            const modelName = this.getModelNameForTable(tabela);
            const Model = models[modelName];

            if (!Model) {
                throw new Error(`Modelo não encontrado para a tabela: ${tabela}`);
            }

            let queryOptions = {
                raw: true
            };

            // Aplicar filtro se necessário
            if (precisaFiltro) {
                if (!this.cdUserApp) {
                    await this.salvarJsonEmArquivo({ ITENS: [] }, tabela);
                    return 0;
                }

                // Configurar o filtro baseado na tabela
                if (tabela === 'clients') {
                    queryOptions.where = { created_by: this.cdUserApp };
                } else {
                    queryOptions.where = { user_id: this.cdUserApp };
                }
            }

            // Buscar dados usando o modelo Sequelize
            rows = await Model.findAll(queryOptions);

            // Converter BigInt para string se necessário
            rows = rows.map(row => {
                const processedRow = {};
                for (const [key, value] of Object.entries(row)) {
                    processedRow[key] = typeof value === 'bigint' ? value.toString() : value;
                }
                return processedRow;
            });

            const jsonObject = {
                TABELA: tabela,
                TOTAL_REGISTROS: rows.length,
                DATA_PROCESSAMENTO: new Date().toISOString(),
                ITENS: rows,
            };
            await this.salvarJsonEmArquivo(jsonObject, tabela);
            return rows.length;
        } catch (error) {
            console.error(`Erro ao consultar dados da tabela ${tabela}:`, error);
            throw error;
        }
    }

    // Método auxiliar para obter o nome do modelo a partir do nome da tabela
    getModelNameForTable(tableName) {
        // Mapeamento de nomes de tabelas para nomes de modelos
        const tableToModelMap = {
            'users': 'User',
            'client_types': 'ClientType',
            'specialities': 'Speciality',
            'services': 'Service',
            'brands': 'Brand',
            'products': 'Product',
            'checks': 'Check',
            'goals': 'Goal',
            'sales': 'Sale',
            'visits': 'Visit',
            'sale_products': 'SaleProduct',
            'clients': 'Client'
        };

        return tableToModelMap[tableName] || this.convertToModelName(tableName);
    }

    // Método para converter nome de tabela para nome de modelo (singular e PascalCase)
    convertToModelName(tableName) {
        // Remover 's' final se existir e converter para PascalCase
        const singular = tableName.endsWith('s') ? tableName.slice(0, -1) : tableName;
        return singular.charAt(0).toUpperCase() + singular.slice(1);
    }

    async salvarJsonEmArquivo(jsonObject, nomeArquivo) {
        const filePath = path.join(this.caminhoTemporario, `${nomeArquivo}.json`);
        try {
            const jsonString = JSON.stringify(jsonObject, (key, value) =>
                typeof value === 'bigint' ? value.toString() : value, 2
            );
            await fs.writeFile(filePath, jsonString, 'utf8');
        } catch (error) {
            throw new ApiError(ErrorCodes.FILE_WRITE_ERROR, `Falha ao salvar o arquivo ${nomeArquivo}.json: ${error.message}`);
        }
    }

    async criarArquivoZip(tabelas) {
        return new Promise((resolve, reject) => {
            const zipFileName = `dados_${new Date().toISOString().replace(/[:.]/g, '-')}.zip`;
            const zipPath = path.join(this.caminhoTemporario, zipFileName);
            const output = require('fs').createWriteStream(zipPath);
            const archive = archiver('zip', { zlib: { level: 9 } });

            output.on('close', () => resolve(zipPath));
            archive.on('error', err => reject(new ApiError(ErrorCodes.FILE_COMPRESSION_ERROR, `Erro ao criar arquivo ZIP: ${err.message}`)));
            archive.pipe(output);
            for (const tabela of tabelas) {
                const filePath = path.join(this.caminhoTemporario, `${tabela}.json`);
                archive.file(filePath, { name: `${tabela}.json` });
            }
            archive.finalize();
        });
    }

    async limparArquivos() {
        if (this.caminhoTemporario) {
            await fs.rm(this.caminhoTemporario, { recursive: true, force: true }).catch(err => {
                console.error(`Erro ao limpar arquivos temporários: ${err.message}`);
            });
        }
    }
}

// --- Rota do Express ---
router.get('/processar-dados', authenticateToken, async (req, res) => {
    const { key, idFilial, cd_user } = req.query;

    if (!key || !['start', 'full'].includes(key)) {
        return sendErrorResponse(new ApiError(ErrorCodes.INVALID_PARAMETER_VALUE, 'Parâmetro "key" deve ser "start" ou "full"'), res);
    }
    if (!cd_user) {
        return sendErrorResponse(new ApiError(ErrorCodes.MISSING_REQUIRED_PARAMETER, 'Parâmetro obrigatório: "cd_user"'), res);
    }

    let processador = new ProcessadorJSON(cd_user);

    try {
        await processador.inicializar();
        const zipPath = await processador.iniciarProcesso(key);
        const fileName = path.basename(zipPath);

        res.setHeader('Content-Type', 'application/zip');
        res.setHeader('Content-Disposition', `attachment; filename="${fileName}"`);
        res.setHeader('X-Processed-GUID', processador.guid);

        const fileStream = require('fs').createReadStream(zipPath);

        // FIX 4: Lógica de limpeza robusta
        // Limpa os arquivos DEPOIS que o stream for fechado.
        fileStream.on('close', () => {
            processador.limparArquivos();
        });

        fileStream.pipe(res);

    } catch (error) {
        // Se um erro ocorrer, limpa os arquivos e envia a resposta de erro
        await processador.limparArquivos();
        if (!res.headersSent) {
            const apiError = error instanceof ApiError ? error : new ApiError(ErrorCodes.INTERNAL_SERVER_ERROR, `Ocorreu um erro inesperado.`);
            return sendErrorResponse(apiError, res);
        } else {
            console.error("Erro após o envio dos headers:", error);
        }
    }
});

module.exports = router;