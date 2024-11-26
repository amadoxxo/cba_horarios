class Aulas {
  final String nombre;
  final int capacidad;
  final String ubicacion;
  final String estado;

  Aulas({
    required this.nombre,
    required this.capacidad,
    required this.ubicacion,
    required this.estado,
  });
}

List<Aulas> listaAulas = [
  Aulas(
      nombre: "B12",
      capacidad: 25,
      ubicacion: "Bloque B, B12",
      estado: "Activo"),
  Aulas(
      nombre: "C10",
      capacidad: 25,
      ubicacion: "Bloque C, C10",
      estado: "Inactivo"),
  Aulas(
      nombre: "A9",
      capacidad: 20,
      ubicacion: "Bloque A, A9",
      estado: "Activo"),
  Aulas(
      nombre: "C10",
      capacidad: 25,
      ubicacion: "Bloque C, C10",
      estado: "Inactivo"),
  Aulas(
      nombre: "B12",
      capacidad: 19,
      ubicacion: "Bloque B, B12",
      estado: "Activo"),
  Aulas(
      nombre: "C10",
      capacidad: 25,
      ubicacion: "Bloque C, C10",
      estado: "Inactivo"),
  Aulas(
      nombre: "Sistemas 1",
      capacidad: 25,
      ubicacion: "Sistemas 1",
      estado: "Activo"),
  Aulas(
      nombre: "C1",
      capacidad: 20,
      ubicacion: "Bloque C, C1",
      estado: "Inactivo"),
  Aulas(
      nombre: "A1",
      capacidad: 18,
      ubicacion: "Bloque A, A1",
      estado: "Activo"),
  Aulas(
      nombre: "C2",
      capacidad: 25,
      ubicacion: "Bloque C, C2",
      estado: "Inactivo"),
];
