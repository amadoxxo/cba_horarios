// ignore_for_file: file_names

class ProgramaCompetencia {
  final String titulo;
  final String tipo;
  final int valor;

  ProgramaCompetencia(
      {required this.titulo,
      required this.tipo,
      required this.valor});
}

List<ProgramaCompetencia> programasCompetencia = [
  ProgramaCompetencia(
      titulo: "Análisis y desarrollo de software",
      tipo: "Tecnico",
      valor: 1),
  ProgramaCompetencia(
      titulo: "Programación orientada a objetos",
      tipo: "Tecnico",
      valor: 2),
  ProgramaCompetencia(
      titulo: "Mantenimiento de equipos de cómputo",
      tipo: "Tecnico",
      valor: 3),
];
