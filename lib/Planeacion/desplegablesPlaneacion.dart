// ignore_for_file: file_names

class ProgramaPlaneacion {
  final String titulo;
  final String tipo;
  final int valor;

  ProgramaPlaneacion(
      {required this.titulo,
      required this.tipo,
      required this.valor});
}

List<ProgramaPlaneacion> programasPlaneacion = [
  ProgramaPlaneacion(
      titulo: "Análisis y desarrollo de software",
      tipo: "Tecnico",
      valor: 1),
  ProgramaPlaneacion(
      titulo: "Programación orientada a objetos",
      tipo: "Tecnico",
      valor: 2),
  ProgramaPlaneacion(
      titulo: "Mantenimiento de equipos de cómputo",
      tipo: "Tecnico",
      valor: 3),
];

class CompetenciaPlaneacion {
  final String titulo;
  final int valor;

  CompetenciaPlaneacion({required this.titulo, required this.valor});
}

List<CompetenciaPlaneacion> competenciasPlaneacion = [
  CompetenciaPlaneacion(
      titulo: "Desarrollo de Aplicaciones Web y Móviles", valor: 1),
  CompetenciaPlaneacion(
      titulo: "Análisis y Diseño de Sistemas de Información", valor: 2),
  CompetenciaPlaneacion(titulo: "Programación de Software", valor: 3),
];

class NumeroResultadoPlaneacion {
  final String titulo;
  final String valor;

  NumeroResultadoPlaneacion({required this.titulo, required this.valor});
}

List<NumeroResultadoPlaneacion> numerosResultadoPlaneacion = [
  NumeroResultadoPlaneacion(titulo: "Rap. 1", valor: "Rap. 1"),
  NumeroResultadoPlaneacion(titulo: "Rap. 2", valor: "Rap. 2"),
  NumeroResultadoPlaneacion(titulo: "Rap. 3", valor: "Rap. 3"),
  NumeroResultadoPlaneacion(titulo: "Rap. 4", valor: "Rap. 4"),
  NumeroResultadoPlaneacion(titulo: "Rap. 5", valor: "Rap. 5"),
  NumeroResultadoPlaneacion(titulo: "Rap. 6", valor: "Rap. 6"),
  NumeroResultadoPlaneacion(titulo: "Rap. 7", valor: "Rap. 7"),
  NumeroResultadoPlaneacion(titulo: "Rap. 8", valor: "Rap. 8"),
  NumeroResultadoPlaneacion(titulo: "Rap. 9", valor: "Rap. 9"),
  NumeroResultadoPlaneacion(titulo: "Rap. 10", valor: "Rap. 10"),
  NumeroResultadoPlaneacion(titulo: "Rap. 11", valor: "Rap. 11"),
  NumeroResultadoPlaneacion(titulo: "Rap. 12", valor: "Rap. 12"),
  NumeroResultadoPlaneacion(titulo: "Rap. 13", valor: "Rap. 13"),
  NumeroResultadoPlaneacion(titulo: "Rap. 14", valor: "Rap. 14"),
  NumeroResultadoPlaneacion(titulo: "Rap. 15", valor: "Rap. 15"),
];


