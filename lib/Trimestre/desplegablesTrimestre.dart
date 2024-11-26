// ignore_for_file: file_names

class FichaTrimestre {
  final String titulo;
  final String subtitulo;
  final int valor;

  FichaTrimestre({
    required this.titulo,
    required this.subtitulo,
    required this.valor,
  });
}

List<FichaTrimestre> fichasTrimestre = [
  FichaTrimestre(
      titulo: "2559890",
      subtitulo: "Análisis y desarrollo de software",
      valor: 1),
  FichaTrimestre(
      titulo: "2559891",
      subtitulo: "Análisis y desarrollo de software",
      valor: 2),
  FichaTrimestre(
      titulo: "2559892",
      subtitulo: "Análisis y desarrollo de software",
      valor: 3),
  FichaTrimestre(
      titulo: "2559893",
      subtitulo: "Análisis y desarrollo de software",
      valor: 4),
];

class NumeroTrimestre {
  final String titulo;
  final String valor;

  NumeroTrimestre({
    required this.titulo,
    required this.valor,
  });
}

List<NumeroTrimestre> numerosTrimestre = [
  NumeroTrimestre(titulo: "Trimestre 1", valor: "Trimestre 1"),
  NumeroTrimestre(titulo: "Trimestre 2", valor: "Trimestre 2"),
  NumeroTrimestre(titulo: "Trimestre 3", valor: "Trimestre 3"),
  NumeroTrimestre(titulo: "Trimestre 4", valor: "Trimestre 4"),
  NumeroTrimestre(titulo: "Trimestre 5", valor: "Trimestre 5"),
  NumeroTrimestre(titulo: "Trimestre 6", valor: "Trimestre 6"),
  NumeroTrimestre(titulo: "Trimestre 7", valor: "Trimestre 7"),
  NumeroTrimestre(titulo: "Trimestre 8", valor: "Trimestre 8"),
];
