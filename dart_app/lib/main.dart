import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  double _firstValue = 0;
  String _operation = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _firstValue = 0;
        _operation = '';
      } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        _firstValue = double.parse(_display);
        _operation = value;
        _display = '0';
      } else if (value == '=') {
        double secondValue = double.parse(_display);
        double result = 0;

        switch (_operation) {
          case '+':
            result = _firstValue + secondValue;
            break;
          case '-':
            result = _firstValue - secondValue;
            break;
          case '×':
            result = _firstValue * secondValue;
            break;
          case '÷':
            result = _firstValue / secondValue;
            break;
        }

        _display = result.toString();
      } else {
        if (_display == '0') {
          _display = value;
        } else {
          _display += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Column(
        children: [
          Display(display: _display),
          Expanded(
            child: ButtonGrid(onPressed: _onButtonPressed),
          ),
        ],
      ),
    );
  }
}

// COMPONENTE DISPLAY
class Display extends StatelessWidget {
  final String display;

  const Display({super.key, required this.display});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerRight,
      child: Text(
        display,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// COMPONENTE GRID DE BOTÕES
class ButtonGrid extends StatelessWidget {
  final Function(String) onPressed;

  const ButtonGrid({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final buttons = [
      '7', '8', '9', '÷',
      '4', '5', '6', '×',
      '1', '2', '3', '-',
      '0', 'C', '=', '+',
    ];

    return GridView.builder(
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) {
        return CalculatorButton(
          text: buttons[index],
          onTap: () => onPressed(buttons[index]),
        );
      },
    );
  }
}

// COMPONENTE BOTÃO
class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.pink[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
