class AsignacionAulas {
  final String aula;
  final String estadoAula;
  final int capacidad;
  final String nombrePrograma;
  final String tipoPrograma;

  AsignacionAulas({
    required this.aula,
    required this.estadoAula,
    required this.capacidad,
    required this.nombrePrograma,
    required this.tipoPrograma,
  });
}

List<AsignacionAulas> listaAsignacionAulas = [
  AsignacionAulas(
      aula: "C2",
      estadoAula: "Libre",
      capacidad: 25,
      nombrePrograma: "Analisis y desarrollo de software",
      tipoPrograma: "Tecnologo"),
  AsignacionAulas(
      aula: "B12",
      estadoAula: "Libre",
      capacidad: 20,
      nombrePrograma: "Recursos Humanos",
      tipoPrograma: "Tecnologo"),
  AsignacionAulas(
      aula: "A9",
      estadoAula: "Libre",
      capacidad: 22,
      nombrePrograma: "Diseño Grafico",
      tipoPrograma: "Tecnico"),
  AsignacionAulas(
      aula: "C1",
      estadoAula: "Libre",
      capacidad: 19,
      nombrePrograma: "Analisis y desarrollo de software",
      tipoPrograma: "Tecnologo"),
  AsignacionAulas(
      aula: "C10",
      estadoAula: "Libre",
      capacidad: 20,
      nombrePrograma: "Produccion Pecuaria",
      tipoPrograma: "Tecnico"),
  AsignacionAulas(
      aula: "C4",
      estadoAula: "Libre",
      capacidad: 20,
      nombrePrograma: "Recursos Humanos",
      tipoPrograma: "Tecnico"),
  AsignacionAulas(
      aula: "Sistemas 1",
      estadoAula: "Libre",
      capacidad: 20,
      nombrePrograma: "Analisis y desarrollo de software",
      tipoPrograma: "Tecnologo"),
  AsignacionAulas(
      aula: "Sistemas 2",
      estadoAula: "Libre",
      capacidad: 20,
      nombrePrograma: "Entrenamiento Deportivo",
      tipoPrograma: "Tecnologo"),
  AsignacionAulas(
      aula: "A2",
      estadoAula: "Libre",
      capacidad: 15,
      nombrePrograma: "Produccion animal",
      tipoPrograma: "Tecnologo"),
  AsignacionAulas(
      aula: "H1",
      estadoAula: "Libre",
      capacidad: 25,
      nombrePrograma: "Especies menores",
      tipoPrograma: "Tecnologo"),
];
