// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para las asignacion de instructores
class AsignacionInstructorModel {
  // id de la asignacion
  final int id;
  // id del programa
  final int programa;
  // id del usuario
  final UsuarioModel usuario;

  // constructor requiriendo todos los atributos
  AsignacionInstructorModel({
    required this.id,
    required this.programa,
    required this.usuario,
  });
}

// lista de la asignacion de instructores
List<AsignacionInstructorModel> asignacionesInstructor = [];

// funcion para obtener las asignaciones de instructores de la base de datos
Future<List<AsignacionInstructorModel>> getAsignacionesInstructor() async {
  // URL para obtener los datos de las asignaciones de instructores de la API.
  String url = "";

  url = "$sourceApi/api/asignacion_instructor/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de las asignaciones de instructores
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    asignacionesInstructor.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var asignacionInstructordata in decodedData) {
      asignacionesInstructor.add(AsignacionInstructorModel(
        id: asignacionInstructordata['id'] ?? 0,
        programa: asignacionInstructordata['programa'] ?? 0,
        usuario: UsuarioModel(
          id: asignacionInstructordata['usuario']['id'] ?? 0,
          nombres: asignacionInstructordata['usuario']['nombres'] ?? "",
          apellidos: asignacionInstructordata['usuario']['apellidos'] ?? "",
          tipoDocumento:
              asignacionInstructordata['usuario']['tipoDocumento'] ?? "",
          numeroDocumento:
              asignacionInstructordata['usuario']['numeroDocumento'] ?? "",
          correoElectronico:
              asignacionInstructordata['usuario']['correoElectronico'] ?? "",
          telefono: asignacionInstructordata['usuario']['telefono'] ?? "",
          telefonoCelular:
              asignacionInstructordata['usuario']['telefonoCelular'] ?? "",
          rol: asignacionInstructordata['usuario']['rol'] ?? "",
          cargo: asignacionInstructordata['usuario']['cargo'] ?? "",
          especialidad:
              asignacionInstructordata['usuario']['especialidad'] ?? "",
          foto: asignacionInstructordata['usuario']['foto'] ?? "",
          vocero: asignacionInstructordata['usuario']['vocero'] ?? false,
          titulacion: asignacionInstructordata['usuario']['titulacion'] ?? "",
          estado: asignacionInstructordata['usuario']['estado'] ?? false,
          enLinea: asignacionInstructordata['usuario']['enLinea'] ?? false,
          tipoInstructor:
              asignacionInstructordata['usuario']['tipoInstructor'] ?? "",
          area: asignacionInstructordata['usuario']['area'] ?? "",
          fechaRegistro:
              asignacionInstructordata['usuario']['fechaRegistro'] ?? "",
        ),
      ));
    }

    // retornar la lista de asignaciones de instructores
    return asignacionesInstructor;
  } else {
    // Si la respuesta no es exitosa, lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
