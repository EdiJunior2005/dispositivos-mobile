import '../models/livro.dart';

class BibliotecaService {
  final List<Livro> _livros = [];
  int _proximoId = 1;

  void adicionar(String titulo, String autor, int ano) {
    final novoLivro = Livro(
      id: _proximoId.toString(),
      titulo: titulo,
      autor: autor,
      ano: ano,
    );

    _livros.add(novoLivro);
    print('\nLivro cadastrado com ID: $_proximoId');
    _proximoId++;
  }

  void listar() {
    print('\n========== LISTA DE LIVROS ==========');

    if (_livros.isEmpty) {
      print('Nenhum livro cadastrado.');
    } else {
      _livros.forEach((livro) => print(livro));
    }

    print('=====================================');
  }

  bool atualizar(String id, String nTitulo, String nAutor, int nAno) {
    int index = _livros.indexWhere((l) => l.id == id);

    if (index != -1) {
      _livros[index] = Livro(
        id: id,
        titulo: nTitulo,
        autor: nAutor,
        ano: nAno,
      );

      print('\nLivro atualizado com sucesso.');
      return true;
    }

    print('\nLivro não encontrado.');
    return false;
  }

  bool remover(String id) {
    int tamanhoInicial = _livros.length;
    _livros.removeWhere((l) => l.id == id);

    if (_livros.length < tamanhoInicial) {
      print('\nLivro removido com sucesso.');
      return true;
    }

    print('\nLivro não encontrado para remoção.');
    return false;
  }

  Livro? buscarPorId(String id) {
    try {
      return _livros.firstWhere((l) => l.id == id);
    } catch (e) {
      return null;
    }
  }
}