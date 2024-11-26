// ignore_for_file: file_names

class EstadoAula {
  String titulo;
  bool valor;

  EstadoAula({required this.titulo, required this.valor});
}

List<EstadoAula> estadosAula = [
  EstadoAula(titulo: "Activo", valor: true),
  EstadoAula(titulo: "Inactivo", valor: false),
];