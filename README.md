# 📚 Biblioteca CLI em Dart

Sistema de gerenciamento de livros desenvolvido em **Dart**, executado via linha de comando (CLI).
O projeto implementa operações de **CRUD** com validações de entrada e organização em camadas.

---

## 📌 Sobre o Projeto

Esta aplicação permite gerenciar uma coleção de livros diretamente pelo terminal, com foco em boas práticas como:

* Separação de responsabilidades
* Validação de dados de entrada
* Estrutura modular

Os dados são armazenados **em memória**, sendo perdidos ao encerrar a execução.

---

## ✨ Funcionalidades

* Cadastro de livros com ID automático
* Listagem de todos os registros
* Atualização de dados com preservação de valores anteriores
* Remoção de livros por ID
* Validação de entradas do usuário

---

## 🔒 Validações Implementadas

* Campos de texto não podem ser vazios
* O campo **ano** aceita apenas valores numéricos e até 4 dígitos.
* Durante a edição:

  * Campos vazios mantêm o valor anterior
  * Entrada inválida para ano não sobrescreve o valor existente

---

## 🏗️ Estrutura do Projeto

```bash
.
├── bin/
│   └── main.dart
└── lib/
    ├── models/
    │   └── livro.dart
    └── services/
        └── biblioteca_service.dart
```

---

## 🧩 Arquitetura

### `main.dart`

Responsável pela interface de linha de comando:

* Entrada e saída de dados
* Controle do fluxo da aplicação
* Interação com o usuário

### `Livro`

Modelo de dados que representa a entidade Livro:

* `id`
* `titulo`
* `autor`
* `ano`

### `BibliotecaService`

Camada de serviço responsável pela lógica de negócio:

* Gerenciamento da lista de livros (`List<Livro>`)
* Geração de IDs incrementais
* Implementação das operações CRUD

---

## ⚙️ Como Executar

### Pré-requisitos

* Dart SDK instalado

Verifique a instalação:

```bash
dart --version
```

---

### Execução

No diretório do projeto, execute:

```bash
dart run
```

ou

```bash
dart run bin/main.dart
```

---

## 💻 Exemplo de Uso

```text
===== SISTEMA DE BIBLIOTECA =====

1 - Cadastrar livro
2 - Listar livros
3 - Atualizar livro
4 - Remover livro
5 - Sair
```

---

## 📚 Conceitos Aplicados

* CRUD (Create, Read, Update, Delete)
* Programação orientada a objetos
* Estruturas de dados (listas)
* Tratamento de entrada do usuário
* Validação de dados

---

## ⚠️ Limitações

* Persistência em memória (sem banco de dados)
* Interface baseada exclusivamente em terminal



