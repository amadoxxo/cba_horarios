// ignore_for_file: file_names

class ProgramaFicha {
  final String titulo;
  final String tipo;
  final int valor;

  ProgramaFicha(
      {required this.titulo, required this.tipo, required this.valor});
}

List<ProgramaFicha> programasFicha = [
  ProgramaFicha(
      titulo: "Análisis y desarrollo de software", tipo: "Tecnico", valor: 1),
  ProgramaFicha(
      titulo: "Programación orientada a objetos", tipo: "Tecnico", valor: 2),
  ProgramaFicha(
      titulo: "Mantenimiento de equipos de cómputo", tipo: "Tecnico", valor: 3),
];

class LiderFicha {
  final String titulo;
  final String subtitulo;
  final int valor;

  LiderFicha(
      {required this.titulo, required this.subtitulo, required this.valor});
}

List<LiderFicha> lideresFicha = [
  LiderFicha(titulo: "Juan Pablo Pérez Gómez", subtitulo: "Software", valor: 1),
  LiderFicha(titulo: "Juan Carlos Gómez", subtitulo: "Software", valor: 2),
  LiderFicha(titulo: "María Pérez", subtitulo: "Software", valor: 3),
];

class TipoOfertaFicha {
  String titulo;
  String valor;
  TipoOfertaFicha({required this.titulo, required this.valor});
}

List<TipoOfertaFicha> tipoOfertasFicha = [
  TipoOfertaFicha(
    titulo: 'Oferta',
    valor: 'Oferta',
  ),
  TipoOfertaFicha(
    titulo: 'Cadena de Formación',
    valor: 'Cadena de Formación',
  ),
];

class ModalidadFicha {
  String titulo;
  String valor;
  ModalidadFicha({required this.titulo, required this.valor});
}

List<ModalidadFicha> modalidadesFicha = [
  ModalidadFicha(
    titulo: 'Presencial',
    valor: 'Presencial',
  ),
  ModalidadFicha(
    titulo: 'Virtual',
    valor: 'Virtual',
  ),
  ModalidadFicha(
    titulo: 'A Distancia',
    valor: 'A Distancia',
  ),
  ModalidadFicha(
    titulo: 'Mixta (B-Learning)',
    valor: 'Mixta (B-Learning)',
  ),
  ModalidadFicha(
    titulo: 'Contrato de Aprendizaje',
    valor: 'Contrato de Aprendizaje',
  ),
  ModalidadFicha(
    titulo: 'Articulación con la Media',
    valor: 'Articulación con la Media',
  ),
  ModalidadFicha(
    titulo: 'Escuela-Taller',
    valor: 'Escuela-Taller',
  ),
];
