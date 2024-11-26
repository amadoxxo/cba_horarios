// ignore_for_file: file_names

class ProgramacionHorario {
  final String titulo;
  final String subtitulo;
  final int valor;
  ProgramacionHorario({required this.titulo, required this.subtitulo, required this.valor});
}

List<ProgramacionHorario> programacionesHorario = [
  ProgramacionHorario(titulo: "Karen Garcia Calderon", subtitulo: "1009", valor: 1),
  ProgramacionHorario(titulo: "Joel Aguirre Mirador", subtitulo: "1010", valor: 2),
  ProgramacionHorario(titulo: "Erika Viviana Suame Rojas", subtitulo: "1011", valor: 3),
  ProgramacionHorario(titulo: "Jose Eder Muñoz Duarte", subtitulo: "1012", valor: 4),
];

class AulaHorario {
  final String titulo;
  final int valor;
  AulaHorario({required this.titulo, required this.valor});
}

List<AulaHorario> aulasHorario = [
  AulaHorario(titulo: "Aula C1", valor: 1),
  AulaHorario(titulo: "Aula A2", valor: 2),
  AulaHorario(titulo: "Aula B9", valor: 3),
  AulaHorario(titulo: "Aula Sistemas 1", valor: 4),
];

class DiaHorario {
   final String titulo;
   final String valor;
   DiaHorario({required this.titulo, required this.valor});
}

List<DiaHorario> diasHorario = [
  DiaHorario(titulo: "Lunes", valor: "Lunes"),
  DiaHorario(titulo: "Martes", valor: "Martes"),
  DiaHorario(titulo: "Miercoles", valor: "Miercoles"),
  DiaHorario(titulo: "Jueves", valor: "Jueves"),
  DiaHorario(titulo: "Viernes", valor: "Viernes"),
  DiaHorario(titulo: "Sabado", valor: "Sabado"),
  DiaHorario(titulo: "Domingo", valor: "Domingo"),
];