class Programa {
  final String nombre;
  final String fechaInicio;
  final String fechaFinal;
  final int duracionLectiva;
  final int duracionProductiva;
  final int duracionTotal;

  Programa({
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFinal,
    required this.duracionLectiva,
    required this.duracionProductiva,
    required this.duracionTotal,
  });
}

List<Programa> listaProgramas = [
  Programa(
      nombre: "ADSO",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12),
  Programa(
      nombre: "Cocina",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12),
  Programa(
      nombre: "Entrenamientro Deportivo",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12),
  Programa(
      nombre: "Produccion Animal",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12),
  Programa(
      nombre: "Especies Menores",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12),
  Programa(
      nombre: "ADSO",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12),
  Programa(
      nombre: "Cocina",
      fechaInicio: "25/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12),
  Programa(
      nombre: "Entrenamientro Deportivo",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12),
  Programa(
      nombre: "Produccion Animal",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12),
  Programa(
      nombre: "Especies Menores",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2025",
      duracionLectiva: 6,
      duracionProductiva: 6,
      duracionTotal: 12),
];
