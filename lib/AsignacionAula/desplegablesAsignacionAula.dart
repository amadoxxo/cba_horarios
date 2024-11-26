// ignore_for_file: file_names

class Aula {
  String titulo;
  int subtitulo;

  Aula({required this.titulo, required this.subtitulo});
}

List<Aula> listaAulas = [
  Aula(titulo: "Aula C2", subtitulo: 23),
  Aula(titulo: "Aula B9", subtitulo: 19),
  Aula(titulo: "Aula A3", subtitulo: 20),
  Aula(titulo: "Aula Sistemas 1 ", subtitulo: 18),
  Aula(titulo: "Aula H5", subtitulo: 23),
];

class ProgramaAula {
  final String nombre;
  final String fechaInicio;
  final String fechaFinal;
  final int duracionLectiva;
  final int duracionProductiva;
  final int duracionTotal;
  final String area;

  ProgramaAula({
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFinal,
    required this.duracionLectiva,
    required this.duracionProductiva,
    required this.duracionTotal,
    required this.area,
  });
}

List<ProgramaAula> listaProgramasAulas = [
  ProgramaAula(
      nombre: "ADSO",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Software"),
  ProgramaAula(
      nombre: "Cocina",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Postres"),
  ProgramaAula(
      nombre: "Entrenamientro Deportivo",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Acondicionamiento físico"),
  ProgramaAula(
      nombre: "Produccion Animal",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Porcinos"),
  ProgramaAula(
      nombre: "Especies Menores",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Lacteos"),
  ProgramaAula(
      nombre: "ADSO",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Software"),
  ProgramaAula(
      nombre: "Cocina",
      fechaInicio: "25/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Bebidas"),
  ProgramaAula(
      nombre: "Entrenamientro Deportivo",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Acondicionamiento Físico"),
  ProgramaAula(
      nombre: "Produccion Animal",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Porcinos"),
  ProgramaAula(
      nombre: "Especies Menores",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Carnicos"),
];
