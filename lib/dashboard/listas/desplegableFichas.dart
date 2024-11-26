// ignore_for_file: file_names

class Desplegablefichas {
  int id;
  String codigo;
  String programa;

  Desplegablefichas({required this.id, required this.codigo, required this.programa});
}

List<Desplegablefichas> fichasDesplegables = [
  Desplegablefichas(id: 1, codigo: '2532154', programa: 'Analisis y Desarrollo de Software'),
  Desplegablefichas(id: 2, codigo: '2598763', programa: 'Mantenimiento de Equipos de Computo'),
  Desplegablefichas(id: 3, codigo: '2593432', programa: 'Diseño de Interfaz de Usuario'),
];