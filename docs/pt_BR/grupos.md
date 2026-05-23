[← Índice](README.md)

# 7\. Grupos de pacotes

**nhopkg** permite organizar pacotes em grupos lógicos usando o campo `# Group:` no arquivo `nhoid`.

## Definindo um grupo
    
    
    # Group: graphics

## Instalando por grupo
    
    
    sudo nhopkg --install-group graphics

## Como funciona

  1. Varre os repositórios sincronizados
  2. Encontra entradas de grupo correspondentes
  3. Resolve dependências
  4. Instala todos os pacotes do grupo

Grupos são ideais para definir perfis de sistema como `base`, `desktop` ou `server`.

