// ignore_for_file: file_names

class Coordinador {
  String titulo;
  String subtitulo;

  Coordinador({required this.titulo, required this.subtitulo});
}

List<Coordinador> listaCoordinadores = [
  Coordinador(
      titulo: "Fernanda Romero Rojas", subtitulo: "Acondicionamiento físico"),
  Coordinador(titulo: "Juan Fernando León Padilla", subtitulo: "Respostería"),
  Coordinador(titulo: "Miranda Roa Davila", subtitulo: "Software"),
  Coordinador(titulo: "Kevin Damian Suarez Manrique", subtitulo: "Porcinos"),
  Coordinador(titulo: "Luz Martinez Suñiga", subtitulo: "Ingles"),
];

class ProgramaCoordinador {
  final String nombre;
  final String fechaInicio;
  final String fechaFinal;
  final int duracionLectiva;
  final int duracionProductiva;
  final int duracionTotal;
  final String area;

  ProgramaCoordinador({
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFinal,
    required this.duracionLectiva,
    required this.duracionProductiva,
    required this.duracionTotal,
    required this.area,
  });
}

List<ProgramaCoordinador> listaProgramasCoordinador = [
  ProgramaCoordinador(
      nombre: "ADSO",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Software"),
  ProgramaCoordinador(
      nombre: "Cocina",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Postres"),
  ProgramaCoordinador(
      nombre: "Entrenamientro Deportivo",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Acondicionamiento físico"),
  ProgramaCoordinador(
      nombre: "Produccion Animal",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Porcinos"),
  ProgramaCoordinador(
      nombre: "Especies Menores",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Lacteos"),
  ProgramaCoordinador(
      nombre: "ADSO",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Software"),
  ProgramaCoordinador(
      nombre: "Cocina",
      fechaInicio: "25/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Bebidas"),
  ProgramaCoordinador(
      nombre: "Entrenamientro Deportivo",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Acondicionamiento Físico"),
  ProgramaCoordinador(
      nombre: "Produccion Animal",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Porcinos"),
  ProgramaCoordinador(
      nombre: "Especies Menores",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12,
      area: "Carnicos"),
];
