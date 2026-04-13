class Livro {
  final String id, titulo, autor;
  final int ano;

  Livro({required this.id, required this.titulo, required this.autor, required this.ano});

  @override
  String toString() => 'ID: $id | Título: $titulo | Autor: $autor | Ano: $ano';
}