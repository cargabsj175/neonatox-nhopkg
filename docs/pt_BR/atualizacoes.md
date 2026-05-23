[← Índice](README.md)

# 8\. Atualizações seguras

O comando `--upgrade` (ou `-y`) permite atualizar todos os pacotes instalados para suas versões mais recentes disponíveis nos repositórios configurados.

Diferente de outros gerenciadores de pacotes, o **nhopkg** segue um fluxo de atualização robusto e previsível, minimizando o risco de corrupção parcial do sistema.

## Fluxo de atualização

  1. Sincroniza os repositórios.
  2. Lista os pacotes instalados.
  3. Compara versões instaladas e disponíveis.
  4. Monta um plano de atualização e solicita confirmação.
  5. Baixa todas as dependências necessárias.
  6. Instala as dependências primeiro.
  7. Remove versões antigas dos pacotes.
  8. Instala as novas versões.
  9. Executa atualizações pós-instalação do sistema.
  10. Atualiza o banco de dados local.

**Comportamento principal:** versões antigas são removidas _antes_ de instalar as novas para evitar conflitos de arquivos.

## Verificações de segurança

  * Verificação de checksum SHA256
  * Compatibilidade de arquitetura
  * Verificação de assinatura GPG (se ativada)
    
    
    # Atualizar o sistema
    sudo nhopkg --upgrade
    sudo nhopkg -y

