import '../models/livro.dart';

class BibliotecaService {
  final List<Livro> _livros = [];

  void adicionar(Livro livro) {
    _livros.add(livro);
    print('\nLivro "${livro.titulo}" cadastrado com sucesso.');
  }

  void listar() {
    print('\n========== LISTA DE LIVROS ==========');
    
    if (_livros.isEmpty) {
      print('Nenhum livro cadastrado ainda.');
    } else {
      _livros.forEach((livro) => print(livro));
    }
    
    print('=====================================');
  }

  bool atualizar(String id, Livro novoLivro) {
    int index = _livros.indexWhere((l) => l.id == id);

    if (index != -1) {
      _livros[index] = novoLivro;
      print('\nLivro atualizado com sucesso.');
      return true;
    }

    print('\nLivro não encontrado para atualização.');
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