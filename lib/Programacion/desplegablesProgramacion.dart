// ignore_for_file: file_names

class ProgramaProgramacion {
  final String titulo;
  final String tipo;
  final int valor;

  ProgramaProgramacion(
      {required this.titulo,
      required this.tipo,
      required this.valor});
}

List<ProgramaProgramacion> programasProgramacion = [
  ProgramaProgramacion(
      titulo: "Análisis y desarrollo de software",
      tipo: "Tecnico",
      valor: 1),
  ProgramaProgramacion(
      titulo: "Programación orientada a objetos",
      tipo: "Tecnico",
      valor: 2),
  ProgramaProgramacion(
      titulo: "Mantenimiento de equipos de cómputo",
      tipo: "Tecnico",
      valor: 3),
];

class PlaneacionProgramacion {
  String titulo;
  int valor;

  PlaneacionProgramacion({required this.titulo, required this.valor});
}

List<PlaneacionProgramacion> planeacionesProgramacion = [
  PlaneacionProgramacion(titulo: "1001", valor: 1),
  PlaneacionProgramacion(titulo: "1002", valor: 2),
  PlaneacionProgramacion(titulo: "1003", valor: 3),
];

class FichaProgramacion {
  final String titulo;
  final int valor;

  FichaProgramacion({required this.titulo, required this.valor});
}

List<FichaProgramacion> fichasProgramacion = [
  FichaProgramacion(titulo: "2558780", valor: 1),
  FichaProgramacion(titulo: "2558781", valor: 2),
  FichaProgramacion(titulo: "2558782", valor: 3),
];

class TrimestreProgramacion {
  final String titulo;
  final int valor;

  TrimestreProgramacion({required this.titulo, required this.valor});
}

List<TrimestreProgramacion> trimestresProgramacion = [
  TrimestreProgramacion(titulo: "Trimestre 1", valor: 1),
  TrimestreProgramacion(titulo: "Trimestre 2", valor: 2),
  TrimestreProgramacion(titulo: "Trimestre 3", valor: 3),
];

class InstructorProgramacion {
  final String titulo;
  final String subtitulo;
  final int valor;

  InstructorProgramacion(
      {required this.titulo, required this.subtitulo, required this.valor});
}

List<InstructorProgramacion> instructoresProgramacion = [
  InstructorProgramacion(titulo: "Juan Pablo Pérez Gómez", subtitulo: "Software", valor: 1),
  InstructorProgramacion(titulo: "Juan Carlos Gómez", subtitulo: "Software", valor: 2),
  InstructorProgramacion(titulo: "María Pérez", subtitulo: "Software", valor: 3),
];

