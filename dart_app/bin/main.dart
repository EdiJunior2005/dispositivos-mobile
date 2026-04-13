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

        stdout.write('Título: ');
        final titulo = stdin.readLineSync() ?? '';

        stdout.write('Autor: ');
        final autor = stdin.readLineSync() ?? '';

        stdout.write('Ano: ');
        final ano = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        service.adicionar(titulo, autor, ano);
        break;

      case '2':
        service.listar();
        break;

      case '3':
        stdout.write('\nInforme o ID do livro: ');
        final idAtu = stdin.readLineSync() ?? '';

        final livroAntigo = service.buscarPorId(idAtu);

        if (livroAntigo != null) {
          print('Editando: ${livroAntigo.titulo}');

          stdout.write('Novo título: ');
          final nTitulo = stdin.readLineSync() ?? '';

          stdout.write('Novo autor: ');
          final nAutor = stdin.readLineSync() ?? '';

          stdout.write('Novo ano: ');
          final nAno = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

          service.atualizar(idAtu, nTitulo, nAutor, nAno);
        } else {
          print('\nLivro não encontrado.');
        }
        break;

      case '4':
        stdout.write('\nInforme o ID do livro: ');
        final idRem = stdin.readLineSync() ?? '';

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