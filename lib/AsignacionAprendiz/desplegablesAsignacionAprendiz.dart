// ignore_for_file: file_names

class FichasAprendiz {
  int id;
  String codigo;
  String programa;

  FichasAprendiz(
      {required this.id, required this.codigo, required this.programa});
}

List<FichasAprendiz> fichasAprendiz = [
  FichasAprendiz(
      id: 1, codigo: '2532154', programa: 'Analisis y Desarrollo de Software'),
  FichasAprendiz(
      id: 2,
      codigo: '2598763',
      programa: 'Mantenimiento de Equipos de Computo'),
  FichasAprendiz(
      id: 3, codigo: '2593432', programa: 'Diseño de Interfaz de Usuario'),
];

class Aprendiz {
  final String nombresApellidos;
  final String tipoDocumento;
  final String numeroDocumento;
  final String correoElectronico;
  final String telefonoCelular;

  Aprendiz({
    required this.nombresApellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.correoElectronico,
    required this.telefonoCelular,
  });
}

List<Aprendiz> listaAprendices = [
  Aprendiz(
    nombresApellidos: "Luisa Andrea Romero",
    tipoDocumento: "Cedula",
    numeroDocumento: "1106362548",
    correoElectronico: "romero@gmail.com",
    telefonoCelular: "3128954763",
  ),
  Aprendiz(
    nombresApellidos: "Laura Carrillo Lopez",
    tipoDocumento: "Cedula",
    numeroDocumento: "1106362447",
    correoElectronico: "carrilo@gmail.com",
    telefonoCelular: "3002023354",
  ),
  Aprendiz(
    nombresApellidos: "Aura Poveda Carreño",
    tipoDocumento: "Tarjeta",
    numeroDocumento: "110654789",
    correoElectronico: "carreño@gmail.com",
    telefonoCelular: "3015004748",
  ),
  Aprendiz(
    nombresApellidos: "Kevin villa Rodriguez",
    tipoDocumento: "Cedula",
    numeroDocumento: "1005823241",
    correoElectronico: "Villa@gmail.com",
    telefonoCelular: "3114789524",
  ),
  Aprendiz(
    nombresApellidos: "Rodrigo Lievano",
    tipoDocumento: "Cedula",
    numeroDocumento: "100362447",
    correoElectronico: "lievano@gmail.com",
    telefonoCelular: "3002023354",
  ),
  Aprendiz(
    nombresApellidos: "Paula Milena Rojas Roa",
    tipoDocumento: "Cedula",
    numeroDocumento: "28789423",
    correoElectronico: "rojas@gmail.com",
    telefonoCelular: "3135789541",
  ),
  Aprendiz(
    nombresApellidos: "Samara Ticora Soacha",
    tipoDocumento: "Cedula",
    numeroDocumento: "100487859",
    correoElectronico: "ticora@gmail.com",
    telefonoCelular: "3232023354",
  ),
  Aprendiz(
    nombresApellidos: "Emmanuel castro villa",
    tipoDocumento: "Cedula",
    numeroDocumento: "1106362777",
    correoElectronico: "castro@gmail.com",
    telefonoCelular: "3502023354",
  ),
  Aprendiz(
    nombresApellidos: "Lina Mora Roa",
    tipoDocumento: "Cedula",
    numeroDocumento: "11063627845",
    correoElectronico: "mora@gmail.com",
    telefonoCelular: "3187053354",
  ),
  Aprendiz(
    nombresApellidos: "Juan Jurado Duarte",
    tipoDocumento: "Cedula",
    numeroDocumento: "1006362447",
    correoElectronico: "jurado@gmail.com",
    telefonoCelular: "3502023354",
  ),
];
