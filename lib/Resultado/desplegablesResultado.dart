// ignore_for_file: file_names

class ProgramaResultado {
  final String titulo;
  final String tipo;
  final int valor;

  ProgramaResultado(
      {required this.titulo, required this.tipo, required this.valor});
}

List<ProgramaResultado> programasResultado = [
  ProgramaResultado(
      titulo: "Análisis y desarrollo de software", tipo: "Tecnico", valor: 1),
  ProgramaResultado(
      titulo: "Programación orientada a objetos", tipo: "Tecnico", valor: 2),
  ProgramaResultado(
      titulo: "Mantenimiento de equipos de cómputo", tipo: "Tecnico", valor: 3),
];

class CompetenciaResultado {
  final String titulo;
  final int valor;

  CompetenciaResultado({required this.titulo, required this.valor});
}

List<CompetenciaResultado> competenciasResultado = [
  CompetenciaResultado(
      titulo: "Desarrollo de Aplicaciones Web y Móviles", valor: 1),
  CompetenciaResultado(
      titulo: "Análisis y Diseño de Sistemas de Información", valor: 2),
  CompetenciaResultado(titulo: "Programación de Software", valor: 3),
];

class NumeroResultado {
  final String titulo;
  final String valor;

  NumeroResultado({required this.titulo, required this.valor});
}

List<NumeroResultado> numerosResultado = [
  NumeroResultado(titulo: "Rap. 1", valor: "Rap. 1"),
  NumeroResultado(titulo: "Rap. 2", valor: "Rap. 2"),
  NumeroResultado(titulo: "Rap. 3", valor: "Rap. 3"),
  NumeroResultado(titulo: "Rap. 4", valor: "Rap. 4"),
  NumeroResultado(titulo: "Rap. 5", valor: "Rap. 5"),
  NumeroResultado(titulo: "Rap. 6", valor: "Rap. 6"),
  NumeroResultado(titulo: "Rap. 7", valor: "Rap. 7"),
  NumeroResultado(titulo: "Rap. 8", valor: "Rap. 8"),
  NumeroResultado(titulo: "Rap. 9", valor: "Rap. 9"),
  NumeroResultado(titulo: "Rap. 10", valor: "Rap. 10"),
  NumeroResultado(titulo: "Rap. 11", valor: "Rap. 11"),
  NumeroResultado(titulo: "Rap. 12", valor: "Rap. 12"),
  NumeroResultado(titulo: "Rap. 13", valor: "Rap. 13"),
  NumeroResultado(titulo: "Rap. 14", valor: "Rap. 14"),
  NumeroResultado(titulo: "Rap. 15", valor: "Rap. 15"),
];
