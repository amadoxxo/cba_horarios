// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para las asignacion de coordinadores
class AsignacionCoordinadorModel {
  // id de la asignacion
  final int id;
  // id del coordinador
  final int usuario;
  // id del programa relacionado a la asignacion
  final ProgramaModel programa;

  // constructor requiriendo los atributos
  AsignacionCoordinadorModel({
    required this.id,
    required this.usuario,
    required this.programa,
  });
}

// lista de las asignaciones de coordinadores
List<AsignacionCoordinadorModel> asignacionesCoordinador = [];

// funcion para obtener las asignaciones de coordinadores de la base de datos
Future<List<AsignacionCoordinadorModel>> getAsignacionesCoordinador() async {
  // URL para obtener los datos de las asignaciones de coordinadores de la API.
  String url = "";

  url = "$sourceApi/api/asignacion_coordinador/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de las asignaciones de coordinadores
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    asignacionesCoordinador.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);

    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var asignaciondata in decodedData) {
      asignacionesCoordinador.add(AsignacionCoordinadorModel(
        id: asignaciondata['id'] ?? 0,
        usuario: asignaciondata['usuario'] ?? 0,
        programa: ProgramaModel(
          id: asignaciondata['programa']['id'] ?? 0,
          nombre: asignaciondata['programa']['nombre'] ?? "",
          codigo: asignaciondata['programa']['codigo'] ?? "",
          version: asignaciondata['programa']['version'] ?? 0,
          fechaInicio: asignaciondata['programa']['fechaInicio'] ?? "",
          fechaFin: asignaciondata['programa']['fechaFin'] ?? "",
          duracionLectiva: asignaciondata['programa']['duracionLectiva'] ?? 0,
          duracionProductiva:
              asignaciondata['programa']['duracionProductiva'] ?? 0,
          duracionTotal: asignaciondata['programa']['duracionTotal'] ?? 0,
          tipoPrograma: asignaciondata['programa']['tipoPrograma'] ?? "",
          certificacion: asignaciondata['programa']['certificacion'] ?? "",
          descripcion: asignaciondata['programa']['descripcion'] ?? "",
          area: asignaciondata['programa']['area'] ?? "",
        ),
      ));
    }

    // retornar la lista de asignaciones de coordinadores
    return asignacionesCoordinador;
  } else {
    // Si la respuesta no es exitosa, lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
