# To-Do List com Flutter + Riverpod

## Descrição da Aplicação

Esta aplicação é uma **lista de tarefas (To-Do List)** desenvolvida em **Flutter**, permitindo que o usuário:

- Adicione novas tarefas
- Marque tarefas como concluídas
- Edite o título de uma tarefa
- Exclua tarefas com confirmação
- Visualize tarefas concluídas com estilo diferenciado

O objetivo do projeto é demonstrar o uso de **gestão de estado moderna** utilizando o **Riverpod**, além de boas práticas de organização e interface amigável.

---

## Gestão de Estado (State Management)

A gestão de estado da aplicação foi implementada utilizando o **Flutter Riverpod**, que oferece uma forma segura, escalável e reativa de gerenciar estados.

### Estrutura utilizada

- **Model (`Task`)**  
  Representa uma tarefa com os campos:
  - `title` (String)
  - `completed` (bool)

- **StateNotifier (`TaskNotifier`)**  
  Responsável por:
  - Adicionar tarefas
  - Remover tarefas
  - Alternar o status de concluída
  - Editar o título de uma tarefa

- **StateNotifierProvider (`taskProvider`)**  
  Expõe o estado da lista de tarefas para a interface, permitindo que a UI reaja automaticamente às mudanças.

### Benefícios do Riverpod no projeto

- Separação clara entre lógica e interface
- Atualizações automáticas da UI
- Código mais organizado e testável
- Evita dependência direta de `BuildContext`

---

## Instruções para Execução

### Pré-requisitos

- Flutter SDK instalado
- Dart SDK (incluso no Flutter)
- Android Studio, VS Code ou outro editor compatível
- Emulador Android/iOS ou dispositivo físico

### Passos para executar o projeto

1. Clone o repositório:
   