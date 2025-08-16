const { Sequelize, Op } = require('sequelize');
const sequelize = require('../config/database');
const { Client, Check, User } = require('../models/index');
const schedulerService = require('../services/schedulerService');
const emailService = require('../services/emailService');
const pushNotificationService = require('../services/pushNotificationService');

/**
 * Obtém a lista de clientes inativos (sem visitas nos últimos 30 dias)
 */
const getInactiveClients = async (req, res) => {
    try {
        // Data atual
        const currentDate = new Date();
        
        // Data de 30 dias atrás
        const thirtyDaysAgo = new Date();
        thirtyDaysAgo.setDate(currentDate.getDate() - 30);
        
        // Buscar todos os clientes
        const clients = await Client.findAll({
            attributes: [
                'id', 
                'name', 
                'address', 
                'type',
                'created_at',
                [Sequelize.literal('(SELECT MAX(check_in_time) FROM checks WHERE checks.client_id = Client.id)'), 'last_visit_date']
            ],
            include: [{
                model: Check,
                attributes: [],
                required: false
            }],
            group: ['Client.id'],
            having: Sequelize.literal('MAX(checks.check_in_time) < :thirtyDaysAgo OR MAX(checks.check_in_time) IS NULL'),
            replacements: { thirtyDaysAgo: thirtyDaysAgo },
            raw: true
        });

        // Calcular dias desde a última visita para cada cliente
        const clientsWithDaysSinceLastVisit = clients.map(client => {
            const lastVisitDate = client.last_visit_date ? new Date(client.last_visit_date) : null;
            const daysSinceLastVisit = lastVisitDate 
                ? Math.floor((currentDate - lastVisitDate) / (1000 * 60 * 60 * 24)) 
                : null;
            
            return {
                ...client,
                days_since_last_visit: daysSinceLastVisit,
                last_visit_date: lastVisitDate
            };
        });

        return res.status(200).json({
            success: true,
            data: clientsWithDaysSinceLastVisit,
            failure: false
        });
    } catch (error) {
        console.error('Erro ao buscar clientes inativos:', error);
        return res.status(500).json({
            success: false,
            message: `Erro ao buscar clientes inativos: ${error.message}`,
            failure: true
        });
    }
};

/**
 * Executa verificação manual de clientes inativos e envia notificações
 */
const runInactiveClientsCheck = async (req, res) => {
    try {
        // Executar verificação imediata
        await schedulerService.runImmediateCheck();
        
        return res.status(200).json({
            success: true,
            message: 'Verificação de clientes inativos executada com sucesso. Notificações enviadas.',
            failure: false
        });
    } catch (error) {
        console.error('Erro ao executar verificação de clientes inativos:', error);
        return res.status(500).json({
            success: false,
            message: `Erro ao executar verificação de clientes inativos: ${error.message}`,
            failure: true
        });
    }
};

/**
 * Envia notificação de teste para um usuário específico
 */
const sendTestNotification = async (req, res) => {
    try {
        const { userId, notificationType } = req.body;
        
        if (!userId) {
            return res.status(400).json({
                success: false,
                message: 'ID do usuário é obrigatório',
                failure: true
            });
        }
        
        // Buscar o usuário
        const user = await User.findByPk(userId);
        
        if (!user) {
            return res.status(404).json({
                success: false,
                message: 'Usuário não encontrado',
                failure: true
            });
        }
        
        // Buscar alguns clientes inativos para teste
        const inactiveClients = await schedulerService.getInactiveClients();
        const sampleClients = inactiveClients.slice(0, 5); // Limitar a 5 clientes para o teste
        
        // Enviar notificação de acordo com o tipo
        if (notificationType === 'email' || !notificationType) {
            // Enviar e-mail de teste
            await emailService.sendInactiveClientsAlert(user.email, sampleClients);
        }
        
        if (notificationType === 'push' || !notificationType) {
            // Verificar se o usuário tem token FCM
            if (!user.fcm_token) {
                return res.status(400).json({
                    success: false,
                    message: 'Usuário não possui token FCM registrado para notificações push',
                    failure: true
                });
            }
            
            // Enviar notificação push de teste
            await pushNotificationService.sendInactiveClientsNotification(
                [user.role],
                sampleClients
            );
        }
        
        return res.status(200).json({
            success: true,
            message: `Notificação de teste enviada com sucesso para ${user.name} (${user.email})`,
            failure: false
        });
    } catch (error) {
        console.error('Erro ao enviar notificação de teste:', error);
        return res.status(500).json({
            success: false,
            message: `Erro ao enviar notificação de teste: ${error.message}`,
            failure: true
        });
    }
};

module.exports = {
    getInactiveClients,
    runInactiveClientsCheck,
    sendTestNotification
};
