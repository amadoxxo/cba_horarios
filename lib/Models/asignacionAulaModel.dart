// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/aulaModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para las asignaciones de aulas
class AsignacionAulaModel {
  // id de la asignacion
  final int id;
  // id del programa
  final int programa;
  // id del aula relacionada a la asignación
  final AulaModel aula;

  // constructor requiriendo los atributos
  AsignacionAulaModel({
    required this.id,
    required this.programa,
    required this.aula,
  });
}

// lista de asignaciones de aulas
List<AsignacionAulaModel> asignacionesAula = [];

// funcion para obtener las asignaciones de aulas de la base de datos
Future<List<AsignacionAulaModel>> getAsignacionesAula() async {
  // URL para obtener los datos de las asignaciones de aulas de la API.
  String url = "";

  url = "$sourceApi/api/asignacion_aula/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de las asignaciones de aulas
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    asignacionesAula.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);

    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var asignaciondata in decodedData) {
      asignacionesAula.add(AsignacionAulaModel(
        id: asignaciondata['id'] ?? 0,
        programa: asignaciondata['programa'] ?? 0,
        aula: AulaModel(
          id: asignaciondata['aula']['id'] ?? 0,
          nombre: asignaciondata['aula']['nombre'] ?? "",
          capacidad: asignaciondata['aula']['capacidad'] ?? 0,
          ubicacion: asignaciondata['aula']['ubicacion'] ?? "",
          estado: asignaciondata['aula']['estado'] ?? false,
        ),
      ));
    }

    // Devolver la lista de asignaciones de aulas
    return asignacionesAula;
  } else {
    // Devolver una excepción si la respuesta no fue exitosa
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
