class Programas {
  final String nombre;
  final String codigo;
  final String tipoPrograma;
  final String fechaInicio;
  final String fechaFinal;
  final int duracionTotal;

  Programas({
    required this.nombre,
    required this.codigo,
    required this.tipoPrograma,
    required this.fechaInicio,
    required this.fechaFinal,
    required this.duracionTotal,
  });
}

List<Programas> listaProgramas = [
  Programas(
      nombre: "Cocina",
      codigo: "2878924",
      tipoPrograma: "Tecnologo",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2024",
      duracionTotal: 8),
  Programas(
      nombre: "ADSO",
      codigo: "2789563",
      tipoPrograma: "Tecnologo",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2024",
      duracionTotal: 8),
  Programas(
      nombre: "Entrenamientro Deportivo",
      codigo: "28789256",
      tipoPrograma: "Tecnologo",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2024",
      duracionTotal: 8),
  Programas(
      nombre: "Produccion Animal",
      codigo: "3695874",
      tipoPrograma: "Tecnologo",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2024",
      duracionTotal: 8),
  Programas(
      nombre: "Especies Menores",
      codigo: "8254789",
      tipoPrograma: "Tecnologo",
      fechaInicio: "22/01/2023",
      fechaFinal: "22/01/2024",
      duracionTotal: 8),
  Programas(
      nombre: "Cocina",
      codigo: "2878923",
      tipoPrograma: "Tecnico",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2024",
      duracionTotal: 4),
  Programas(
      nombre: "ADSO",
      codigo: "2789563",
      tipoPrograma: "Tecnico",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2024",
      duracionTotal: 4),
  Programas(
      nombre: "Entrenamientro Deportivo",
      codigo: "28789257",
      tipoPrograma: "Tecnico",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2024",
      duracionTotal: 4),
  Programas(
      nombre: "Produccion Animal",
      codigo: "3695873",
      tipoPrograma: "Tecnico",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2024",
      duracionTotal: 4),
  Programas(
      nombre: "Especies Menores",
      codigo: "8254788",
      tipoPrograma: "Tecnico",
      fechaInicio: "22/05/2023",
      fechaFinal: "22/05/2024",
      duracionTotal: 4),
];
