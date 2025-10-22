const Joi = require('joi');

// Esquema de validação para operadores de filtro
const operatorSchema = Joi.string().valid(
    'eq', 'ne', 'gt', 'gte', 'lt', 'lte', 
    'cont', 'contL', 'excl', 'exclL', 
    'in', 'notin', 'isnull', 'notnull', 
    'starts', 'ends', 'between'
).required();

// Esquema de validação para filtros
const filterSchema = Joi.object({
    column: Joi.string().required().messages({
        'string.empty': 'A coluna não pode estar vazia',
        'any.required': 'A coluna é obrigatória'
    }),
    operator: operatorSchema.messages({
        'any.only': 'Operador {{#value}} não é válido. Operadores válidos: eq, ne, gt, gte, lt, lte, cont, contL, excl, exclL, in, notin, isnull, notnull, starts, ends, between',
        'any.required': 'O operador é obrigatório'
    }),
    value: Joi.alternatives()
        .conditional('operator', { 
            is: Joi.string().valid('isnull', 'notnull'), 
            then: Joi.any().optional(),
            otherwise: Joi.alternatives().try(
                Joi.string(), 
                Joi.number(), 
                Joi.boolean(), 
                Joi.array().items(Joi.any())
            ).required()
        }).messages({
            'any.required': 'O valor é obrigatório para o operador {{#operator}}'
        })
});

// Esquema de validação para joins
const joinSchema = Joi.object({
    table: Joi.string().required().messages({
        'string.empty': 'A tabela do join não pode estar vazia',
        'any.required': 'A tabela do join é obrigatória'
    }),
    alias: Joi.string().optional(),
    type: Joi.string().valid(
        'INNER', 'LEFT', 'RIGHT', 'FULL', 'OUTER', 'CROSS',
        'INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN', 'OUTER JOIN', 'FULL OUTER JOIN', 'CROSS JOIN'
    ).default('INNER').messages({
        'any.only': 'O tipo de join deve ser um dos tipos válidos (INNER, LEFT, RIGHT, FULL, OUTER, CROSS)'
    }),
    on: Joi.object({
        sourceColumn: Joi.string().required().messages({
            'string.empty': 'A coluna de origem não pode estar vazia',
            'any.required': 'A coluna de origem é obrigatória'
        }),
        targetColumn: Joi.string().required().messages({
            'string.empty': 'A coluna de destino não pode estar vazia',
            'any.required': 'A coluna de destino é obrigatória'
        })
    }).required().messages({
        'any.required': 'As condições de join são obrigatórias'
    })
});

// Esquema de validação para a requisição GET
const getSchema = Joi.object({
    entity: Joi.string().required().messages({
        'string.empty': 'A entidade não pode estar vazia',
        'any.required': 'A entidade é obrigatória'
    }),
    alias: Joi.string().optional(),
    action: Joi.string().valid('get').required().messages({
        'any.only': 'A ação deve ser "get" para consultas',
        'any.required': 'A ação é obrigatória'
    }),
    // Mantém compatibilidade com o formato antigo
    data: Joi.object({
        select: Joi.array().items(Joi.string()).optional()
    }).optional(),
    // Novo campo para seleção de colunas específicas
    select: Joi.array().items(Joi.string()).optional().description('Colunas específicas para selecionar'),
    // Novo campo para funções agregadas (COUNT, SUM, etc.)
    // Aceita tanto strings diretas quanto objetos estruturados
    addSelect: Joi.array().items(
        Joi.alternatives().try(
            // Formato de string direta para expressões SQL completas (ex: "COUNT(*) as total")
            Joi.string(),
            // Formato estruturado para maior controle e validação
            Joi.object({
                function: Joi.string().valid('COUNT', 'SUM', 'AVG', 'MIN', 'MAX', 'DISTINCT').required().messages({
                    'any.only': 'Função inválida. Funções válidas: COUNT, SUM, AVG, MIN, MAX, DISTINCT',
                    'any.required': 'A função é obrigatória para addSelect'
                }),
                column: Joi.string().required().messages({
                    'string.empty': 'A coluna não pode estar vazia',
                    'any.required': 'A coluna é obrigatória para a função'
                }),
                alias: Joi.string().optional().description('Alias para a expressão')
            })
        )
    ).optional().description('Funções agregadas para adicionar ao SELECT'),
    // Tipo de JOIN global para todos os joins
    joinType: Joi.string().valid('INNER', 'LEFT', 'RIGHT', 'OUTER', 'FULL OUTER', 'CROSS').optional()
        .description('Tipo de JOIN global para todos os joins'),
    joins: Joi.array().items(joinSchema).optional(),
    filter: Joi.array().items(filterSchema).optional(),
    groupBy: Joi.array().items(Joi.string()).optional(),
    orderBy: Joi.array().items(Joi.string()).optional(),
    offset: Joi.number().integer().min(0).optional().default(0),
    limit: Joi.number().integer().min(1).optional().default(100)
});

// Esquema de validação para a requisição POST
const postSchema = Joi.object({
    entity: Joi.string().required().messages({
        'string.empty': 'A entidade não pode estar vazia',
        'any.required': 'A entidade é obrigatória'
    }),
    action: Joi.string().valid('post').required().messages({
        'any.only': 'A ação deve ser "post" para inserções',
        'any.required': 'A ação é obrigatória'
    }),
    data: Joi.alternatives().try(
        Joi.object().min(1),
        Joi.array().items(Joi.object().min(1))
    ).required().messages({
        'any.required': 'Os dados são obrigatórios para inserção',
        'alternatives.types': 'Os dados devem ser um objeto ou um array de objetos',
        'object.min': 'O objeto de dados não pode estar vazio',
        'array.base': 'Os dados devem ser um objeto ou um array de objetos'
    })
});

// Esquema de validação para a requisição PUT/PATCH
const putSchema = Joi.object({
    entity: Joi.string().required().messages({
        'string.empty': 'A entidade não pode estar vazia',
        'any.required': 'A entidade é obrigatória'
    }),
    action: Joi.string().valid('put', 'patch').required().messages({
        'any.only': 'A ação deve ser "put" ou "patch" para atualizações',
        'any.required': 'A ação é obrigatória'
    }),
    data: Joi.object().required().messages({
        'any.required': 'Os dados são obrigatórios para atualização'
    }),
    filter: Joi.array().items(filterSchema).required().min(1).messages({
        'any.required': 'Filtros são obrigatórios para atualização',
        'array.min': 'Pelo menos um filtro é necessário para atualização'
    })
});

// Esquema de validação para a requisição DELETE
const deleteSchema = Joi.object({
    entity: Joi.string().required().messages({
        'string.empty': 'A entidade não pode estar vazia',
        'any.required': 'A entidade é obrigatória'
    }),
    action: Joi.string().valid('delete').required().messages({
        'any.only': 'A ação deve ser "delete" para exclusões',
        'any.required': 'A ação é obrigatória'
    }),
    filter: Joi.array().items(filterSchema).required().min(1).messages({
        'any.required': 'Filtros são obrigatórios para exclusão',
        'array.min': 'Pelo menos um filtro é necessário para exclusão'
    })
});

// Middleware de validação para requisições DBM
const validateDbmRequest = (req, res, next) => {
    const { action } = req.body;
    let schema;

    // Selecionar o esquema de validação com base na ação
    switch (action) {
        case 'get':
            schema = getSchema;
            break;
        case 'post':
            schema = postSchema;
            break;
        case 'put':
        case 'patch':
            schema = putSchema;
            break;
        case 'delete':
            schema = deleteSchema;
            break;
        default:
            return res.status(400).json({ 
                success: false, 
                message: 'Ação inválida. Ações válidas: get, post, put, patch, delete', 
                failure: true 
            });
    }

    // Validar a requisição
    const { error, value } = schema.validate(req.body, { abortEarly: false });
    
    if (error) {
        const errorMessages = error.details.map(detail => detail.message);
        return res.status(400).json({ 
            success: false, 
            message: 'Erro de validação', 
            errors: errorMessages,
            failure: true 
        });
    }

    // Se a validação passar, atualizar o corpo da requisição com os valores validados
    req.body = value;
    next();
};

module.exports = {
    validateDbmRequest
};
