import 'dart:io';
import '../lib/services/biblioteca_service.dart';

void main() {
  final service = BibliotecaService();
  bool executando = true;

  print('\n===== SISTEMA DE BIBLIOTECA =====');

  while (executando) {
    print('1 - Cadastrar livro');
    print('2 - Listar livros');
    print('3 - Atualizar livro');
    print('4 - Remover livro');
    print('5 - Sair');

    stdout.write('\nEscolha uma opção: ');
    final opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        print('\n--- Novo cadastro ---');

        final titulo = lerTextoNaoVazio('Título: ');
        final autor = lerTextoNaoVazio('Autor: ');
        final ano = lerAnoValido('Ano: ');

        service.adicionar(titulo, autor, ano);
        break;

      case '2':
        service.listar();
        break;

      case '3':
        final idAtu = lerTextoNaoVazio('\nInforme o ID do livro: ');
        final livroAntigo = service.buscarPorId(idAtu);

        if (livroAntigo != null) {
          print('Editando: ${livroAntigo.titulo}');

          stdout.write('Novo título: ');
          final nTituloInput = stdin.readLineSync();

          stdout.write('Novo autor: ');
          final nAutorInput = stdin.readLineSync();

          stdout.write('Novo ano: ');
          final nAnoInput = stdin.readLineSync();

          final nTitulo = (nTituloInput == null || nTituloInput.trim().isEmpty)
              ? livroAntigo.titulo
              : nTituloInput;

          final nAutor = (nAutorInput == null || nAutorInput.trim().isEmpty)
              ? livroAntigo.autor
              : nAutorInput;

          int nAno;
          if (nAnoInput == null || nAnoInput.trim().isEmpty) {
            nAno = livroAntigo.ano;
          } else {
            final parsed = int.tryParse(nAnoInput);
            if (parsed == null) {
              print('Ano inválido. Mantendo valor anterior.');
              nAno = livroAntigo.ano;
            } else {
              nAno = parsed;
            }
          }

          service.atualizar(idAtu, nTitulo, nAutor, nAno);
        } else {
          print('\nLivro não encontrado.');
        }
        break;

      case '4':
        final idRem = lerTextoNaoVazio('\nInforme o ID do livro: ');
        service.remover(idRem);
        break;

      case '5':
        print('\nEncerrando o sistema...');
        executando = false;
        break;

      default:
        print('\nOpção inválida. Tente novamente.');
    }
  }
}

String lerTextoNaoVazio(String mensagem) {
  while (true) {
    stdout.write(mensagem);
    final input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) {
      print('Este campo não pode ser vazio.');
      continue;
    }

    return input;
  }
}

int lerAnoValido(String mensagem) {
  while (true) {
    stdout.write(mensagem);
    final input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) {
      print('Este campo não pode ser vazio.');
      continue;
    }

    if (input.length > 4) {
      print('O ano deve ter no máximo 4 dígitos.');
      continue;
    }

    final numero = int.tryParse(input);

    if (numero == null) {
      print('Digite apenas números.');
      continue;
    }

    return numero;
  }
}
