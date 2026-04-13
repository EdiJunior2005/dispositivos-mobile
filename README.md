# 🧮 Calculadora em Flutter

Aplicação de calculadora desenvolvida em Flutter utilizando a linguagem Dart, com foco em componentização e boas práticas de desenvolvimento mobile.

---

## 🚀 Tecnologias utilizadas

- Flutter
- Dart

---

## 📱 Funcionalidades

- Operações básicas:
  - Adição (+)
  - Subtração (-)
  - Multiplicação (×)
  - Divisão (÷)
- Botão para limpar (C)
- Tratamento de erro (ex: divisão por zero)
- Atualização em tempo real do display

---

## 🧩 Componentização

O projeto foi estruturado utilizando componentização, separando a interface em partes reutilizáveis:

- **Display** → responsável por mostrar os valores na tela  
- **ButtonGrid** → organiza os botões da calculadora  
- **CalculatorButton** → componente reutilizável para os botões  

Essa abordagem melhora a organização, reutilização e manutenção do código.

---

## 🧠 Estrutura do projeto

- `CalculatorPage` → controla a lógica da aplicação  
- `Display` → exibição dos valores  
- `ButtonGrid` → layout dos botões  
- `CalculatorButton` → botão reutilizável  

---

## ▶️ Como executar o projeto

1. Instale o Flutter:
   https://docs.flutter.dev/get-started/install

2. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/seu-repositorio.git