// ignore_for_file: file_names, dangling_library_doc_comments
/// Clase que representa una opción de tipo de documento.
///
/// Esta clase tiene dos atributos: [titulo] y [valor].
/// [titulo] es el título a mostrar en la opción y [valor] es el valor asociado a esa opción.


class TipoDocumentoUsuario {
  /// Título de la opción.
  final String? titulo;

  /// Valor asociado a la opción.
  final String? valor;

  /// Constructor que inicializa el título y el valor de la opción.
  ///
  /// El parámetro [titulo] es el título a mostrar en la opción.
  /// El parámetro [valor] es el valor asociado a esa opción.
  TipoDocumentoUsuario(this.titulo, this.valor);
}

/// Lista de opciones de tipo de documento.
///
/// Cada opción es una instancia de la clase [TipoDocumentoUsuario] que tiene
/// dos atributos: [titulo] y [valor].
/// [titulo] es el título a mostrar en la opción y [valor] es el valor asociado a esa opción.
///
/// Cada opción representa un tipo de documento válido para un usuario.
final List optionsTipoDocumento = [
  // Opción para tarjeta de identidad
  TipoDocumentoUsuario(
    'Tarjeta de Identidad', // Título de la opción
    'TI', // Valor asociado a la opción
  ),
  // Opción para cédula ciudadana
  TipoDocumentoUsuario(
    'Cedula Ciudadanía', // Título de la opción
    "CC", // Valor asociado a la opción
  ),
  // Opción para cédula extranjera
  TipoDocumentoUsuario(
    'Cedula Extranjería', // Título de la opción
    "CE", // Valor asociado a la opción
  ),
  // Opción para pasaporte
  TipoDocumentoUsuario(
    'Pasaporte', // Título de la opción
    "PAS", // Valor asociado a la opción
  ),
  // Opción para número de identificación tributaria
  TipoDocumentoUsuario(
    'Número de identificación tributaria', // Título de la opción
    "NIT", // Valor asociado a la opción
  ),
];

class RolesUsuario {
  String titulo;

  String valor;

  RolesUsuario(this.titulo, this.valor);
}

List<RolesUsuario> roles = [
  RolesUsuario('Aprendiz', 'Aprendiz'),
  RolesUsuario('Instructor', 'Instructor'),
  RolesUsuario('Coordinador', 'Coordinador'),
  RolesUsuario('Administrador', 'Administrador'),
];

class TipoInstructorUsuario {
  String titulo;
  String valor;
  TipoInstructorUsuario(this.titulo, this.valor);
}

List<TipoInstructorUsuario> tipoInstructores = [
  TipoInstructorUsuario('Planta', 'Planta'),
  TipoInstructorUsuario('Contratista', 'Contratista'),
];

class AreaInstructorUsuario {
  String titulo;
  String valor;
  AreaInstructorUsuario(this.titulo, this.valor);
}

List<AreaInstructorUsuario> areaInstructores = [
  AreaInstructorUsuario('Software', 'Software'), 
  AreaInstructorUsuario('Gastronomía', 'Gastronomía'),
  AreaInstructorUsuario('Recursos Humanos', 'Recursos Humanos'),
];