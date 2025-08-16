const swaggerUi = require('swagger-ui-express');
const swaggerSpecs = require('../docs/swagger');

module.exports = (app) => {
    try {
        // Configuração do Swagger UI
        app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpecs, {
            explorer: true,
            customCss: '.swagger-ui .topbar { display: none }',
            customSiteTitle: "API OnTarget - Documentação"
        }));

        // Endpoint para obter a especificação OpenAPI em formato JSON
        app.get('/api-docs.json', (req, res) => {
            res.setHeader('Content-Type', 'application/json');
            res.send(swaggerSpecs);
        });

        console.log('Documentação Swagger disponível em: /api-docs');
    } catch (error) {
        console.error('Erro ao configurar Swagger:', error);
    }
};
