# ManducaBank - Flutter Application

Este é o projeto base do **ManducaBank**, um aplicativo de banco digital desenvolvido em Flutter. O projeto segue princípios de Clean Code e uma arquitetura modularizada para facilitar a manutenção e escalabilidade.

## 🚀 Tecnologias Utilizadas

- **Flutter 3.x**
- **HTTP**: Para integração com a AwesomeAPI (Cotações).
- **SQFlite**: Para persistência de dados local (Banco de Dados).
- **Path**: Para gerenciamento de caminhos de arquivos.

## 📁 Estrutura do Projeto

```text
lib/
├── database/     # Configuração e Helpers do SQLite
├── models/       # Classes de modelo de dados
├── routes/       # Definição de rotas nomeadas
├── services/     # Integração com APIs externas
└── views/        # Telas da aplicação (UI)
```

---

## 🛠️ Guia de Configuração e Desenvolvimento

### 1. Requisitos Prévios
- Flutter SDK instalado e configurado.
- Android SDK (para rodar em Android).
- Visual Studio (para rodar em Windows Desktop).

### 2. Inicializando o Projeto (Setup para a Equipe)

Se você está baixando o projeto pela primeira vez:

```bash
# Clonar o repositório
git clone https://github.com/seu-usuario/manducabank.git

# Entrar no diretório do projeto
cd manducabank

# Baixar as dependências do Flutter
flutter pub get
```

### 3. Fluxo de Desenvolvimento Diário

Sempre trabalhe em branches para manter o código principal estável:

```bash
# Atualizar seu código local
git pull origin main

# Criar uma nova branch para sua tarefa
git checkout -b feature/nome-da-sua-feature

# Após desenvolver, adicione e commite
git add .
git commit -m "feat: descrição da melhoria"

# Enviar sua branch para o servidor
git push origin feature/nome-da-sua-feature
```

---

## ⚔️ Resolução de Conflitos

Se ao tentar fazer um `git pull` ou `git merge` você encontrar conflitos, siga estes passos:

1.  **Identifique os arquivos:** O Git listará os arquivos em conflito (ex: `CONFLICT (content): Merge conflict in lib/main.dart`).
2.  **Abra o arquivo:** Procure pelas marcações:
    -   `<<<<<<< HEAD`: Suas alterações locais.
    -   `=======`: Divisor.
    -   `>>>>>>> branch-name`: Alterações vindas do servidor.
3.  **Resolva manualmente:** Escolha qual código manter (ou combine ambos) e remova as marcações do Git.
4.  **Marque como resolvido:**
    ```bash
    git add <arquivo-resolvido>
    git commit -m "fix: resolve conflitos de merge"
    git push
    ```

---

## 📱 Como Executar

Para rodar o projeto em modo debug:

```bash
# Listar dispositivos disponíveis
flutter devices

# Executar no dispositivo escolhido
flutter run
```

---

## 👥 Equipe e Responsabilidades

### 🧑‍💻 Integrante 1: Lógica e Estrutura (Espinha Dorsal)
*   **Sistema de Rotas:** Setup completo de rotas nomeadas no `MaterialApp` e métodos de navegação.
*   **Integração de API:** Criação de classes de modelo (Data Classes) e serviço HTTP para cotações.
*   **Banco de Dados:** Configuração do SQLite, criação de tabelas e métodos CRUD para histórico.
*   **Arquitetura:** Organização em Clean Architecture (UI, Models, Services) e estruturação de arquivos.

### 🎨 Integrante 2: Front-end (Telas Base)
*   **UI Base:** Desenvolvimento da **Tela de Login** e **Tela Principal**.
*   **Widgets:** Implementação de Botões, Inputs e Widgets básicos conforme requisitos.
*   **Estilização:** Definição da identidade visual (cores, tipografia) e componentes reutilizáveis.

### 💸 Integrante 3: Front-end (Features Core)
*   **UI Core:** Desenvolvimento da **Tela de Cotação** e **Tela de Transferência**.
*   **Conexão de Dados:** Integração da interface com os serviços de API e Banco de Dados.
*   **Validações:** Regras de negócio em formulários e feedback visual (erro/sucesso) para o usuário.

### 🔌 Integrante 4: Integrações Nativas (Plugins)
*   **Câmera:** Implementação de leitura de QR Code ou foto de perfil.
*   **Compartilhamento:** Função de gerar e compartilhar comprovantes (ex: `share_plus`).
*   **Autenticação:** Integração de Login (Firebase Auth ou `local_auth` para biometria).

### 📦 Integrante 5: DevOps, Testes e Entrega
*   **Revisão:** Garantir a integração do código sem conflitos e cumprimento das regras do projeto.
*   **Testes:** Validação de navegação e passagem de argumentos entre rotas.
*   **Build:** Geração do APK otimizado (`--split-per-abi`) para entrega.
*   **Entrega:** Organização do pacote .ZIP final e submissão no prazo (31/05).

---
**ManducaBank** - Projeto Acadêmico/Exemplo.
