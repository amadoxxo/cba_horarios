// ignore_for_file: file_names

class Instructor {
  String titulo;
  String subtitulo;

  Instructor({required this.titulo, required this.subtitulo});
}

List<Instructor> listaInstructores = [
  Instructor(
      titulo: "Fernanda Romero Rojas", subtitulo: "Acondicionamiento físico"),
  Instructor(titulo: "Juan Fernando León Padilla", subtitulo: "Respostería"),
  Instructor(titulo: "Miranda Roa Davila", subtitulo: "Software"),
  Instructor(titulo: "Kevin Damian Suarez Manrique", subtitulo: "Porcinos"),
  Instructor(titulo: "Luz Martinez Suñiga", subtitulo: "Ingles"),
];

class ProgramaInstructor {
  final String nombre;
  final String fechaInicio;
  final String fechaFinal;
  final int duracionLectiva;
  final int duracionProductiva;
  final int duracionTotal;
  final String area;

  ProgramaInstructor({
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFinal,
    required this.duracionLectiva,
    required this.duracionProductiva,
    required this.duracionTotal,
    required this.area,
  });
}

List<ProgramaInstructor> listaProgramasInstructor = [
  ProgramaInstructor(
      nombre: "ADSO",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Software"),
  ProgramaInstructor(
      nombre: "Cocina",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Postres"),
  ProgramaInstructor(
      nombre: "Entrenamientro Deportivo",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Acondicionamiento físico"),
  ProgramaInstructor(
      nombre: "Produccion Animal",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Porcinos"),
  ProgramaInstructor(
      nombre: "Especies Menores",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Lacteos"),
  ProgramaInstructor(
      nombre: "ADSO",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Software"),
  ProgramaInstructor(
      nombre: "Cocina",
      fechaInicio: "25/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Bebidas"),
  ProgramaInstructor(
      nombre: "Entrenamientro Deportivo",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Acondicionamiento Físico"),
  ProgramaInstructor(
      nombre: "Produccion Animal",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Porcinos"),
  ProgramaInstructor(
      nombre: "Especies Menores",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Carnicos"),
];
