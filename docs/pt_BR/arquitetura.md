[← Índice](README.md)

# 1\. Arquitetura geral

**nhopkg** é um gerenciador de pacotes universal projetado para funcionar em qualquer distribuição GNU/Linux. Sua arquitetura foca em simplicidade, portabilidade e transparência.

## Linguagem e compatibilidade

  * Escrito principalmente em **Bash** , com esforço explícito para manter compatibilidade com `sh`.
  * Projetado para funcionar até mesmo em ambientes mínimos como **BusyBox**.
  * Sem dependência de runtimes externos como Python, Perl ou Rust.



## Formatos de pacotes

  * `.nho`: pacotes binários prontos para instalar.
  * `.srcnho`: pacotes fonte contendo receitas de compilação (`nhoid`).



## Estrutura de um pacote `.nho`

  * `nhoid`: metadados do pacote.
  * `data.tar.zst`: arquivos compactados.
  * `signature.gpg` (opcional): assinatura GPG.



## Portabilidade e minimalismo

O nhopkg é destinado a:

  * Distribuições personalizadas (LFS / BLFS).
  * Sistemas embarcados ou com poucos recursos.
  * Ambientes de produção que exigem controle total e reprodutibilidade.
