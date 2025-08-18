#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re
import glob
import sys

"""
Script para padronizar nomes de colunas nos modelos Sequelize
Converte:
- camelCase para snake_case nos nomes de colunas
- Padroniza createdAt/updated_at para created_at/updated_at
- Ajusta as configurações de timestamps
"""

def camel_to_snake(name):
    """Converte camelCase para snake_case"""
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

def process_file(file_path):
    """Processa um arquivo de modelo para padronizar nomes de colunas"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Contador de alterações
    changes = 0
    
    # Padronizar definição de campos timestamp
    # Substituir createdAt: { ... } por createdAt: { ... }
    pattern_created = r'createdAt:\s*{([^}]*)}'
    if re.search(pattern_created, content):
        content = re.sub(pattern_created, r'createdAt: {\1}', content)
        changes += 1
    
    # Substituir updatedAt: { ... } por updatedAt: { ... }
    pattern_updated = r'updatedAt:\s*{([^}]*)}'
    if re.search(pattern_updated, content):
        content = re.sub(pattern_updated, r'updatedAt: {\1}', content)
        changes += 1
    
    # Padronizar configuração de timestamps
    # Substituir timestamps: true sem mapeamento
    pattern_timestamps = r'timestamps:\s*true,(?!\s*createdAt)'
    if re.search(pattern_timestamps, content):
        content = re.sub(pattern_timestamps, r'timestamps: true,\n        createdAt: \'created_at\',\n        updatedAt: \'updated_at\',', content)
        changes += 1
    
    # Substituir createdAt: 'createdAt' por createdAt: 'createdAt'
    pattern_created_map = r"createdAt:\s*['|\"]createdAt['|\"]"
    if re.search(pattern_created_map, content):
        content = re.sub(pattern_created_map, r"createdAt: 'createdAt'", content)
        changes += 1
    
    # Substituir updatedAt: 'updatedAt' por updatedAt: 'updatedAt'
    pattern_updated_map = r"updatedAt:\s*['|\"]updated_at['|\"]"
    if re.search(pattern_updated_map, content):
        content = re.sub(pattern_updated_map, r"updatedAt: 'updatedAt'", content)
        changes += 1
    
    # Padronizar defaultValue para timestamps
    pattern_default = r'defaultValue:\s*Sequelize\.NOW'
    if re.search(pattern_default, content):
        content = re.sub(pattern_default, r'defaultValue: DataTypes.NOW', content)
        changes += 1
    
    # Padronizar método insertDefaultValues para incluir timestamps
    pattern_insert = r'(\s+)return\s+([A-Za-z]+)\.bulkCreate\(\s*\[\s*({[^}]*}(?:\s*,\s*{[^}]*})*)\s*\]\s*\)'
    
    def add_timestamps_to_bulk(match):
        indent = match.group(1)
        model_name = match.group(2)
        items_text = match.group(3)
        
        # Verificar se já tem timestamps
        if 'createdAt' in items_text or 'createdAt' in items_text:
            return match.group(0)
        
        # Adicionar timestamps a cada objeto
        items = re.findall(r'{([^}]*)}', items_text)
        new_items = []
        
        for item in items:
            if item.strip().endswith(','):
                new_item = item + ' createdAt: new Date(), updatedAt: new Date()'
            else:
                new_item = item + ', createdAt: new Date(), updatedAt: new Date()'
            new_items.append('{' + new_item + '}')
        
        return f'{indent}return {model_name}.bulkCreate([\n{indent}  ' + ',\n{indent}  '.join(new_items) + f'\n{indent}])'
    
    if re.search(pattern_insert, content):
        content = re.sub(pattern_insert, add_timestamps_to_bulk, content)
        changes += 1
    
    # Se houve alterações, salvar o arquivo
    if changes > 0:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"✅ Arquivo {os.path.basename(file_path)} atualizado com {changes} alterações")
        return True
    else:
        print(f"⏭️ Arquivo {os.path.basename(file_path)} não precisou de alterações")
        return False

def main():
    """Função principal"""
    # Diretório dos modelos
    models_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'models')
    
    # Verificar se o diretório existe
    if not os.path.isdir(models_dir):
        print(f"❌ Diretório de modelos não encontrado: {models_dir}")
        return 1
    
    # Listar todos os arquivos .js no diretório de modelos
    model_files = glob.glob(os.path.join(models_dir, '*.js'))
    
    # Excluir index.js e arquivos que não são modelos
    model_files = [f for f in model_files if os.path.basename(f) != 'index.js']
    
    print(f"🔍 Encontrados {len(model_files)} arquivos de modelo para processar")
    
    # Processar cada arquivo
    updated_files = 0
    for file_path in model_files:
        if process_file(file_path):
            updated_files += 1
    
    print(f"\n✅ Processamento concluído! {updated_files} arquivos foram atualizados.")
    return 0

if __name__ == "__main__":
    sys.exit(main())
