// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para las competencias
class CompetenciaModel {
  // id de la competencia
  final int id;

  // norma de la competencia
  final String norma;

  // Código de la competencia
  final String codigo;

  // Nombre de la competencia
  final String nombre;

  // Duración de la competencia
  final int duracion;

  // Programa relacionado a la competencia
  final ProgramaModel programa;

  // Constructor requiriendo todos los atributos
  CompetenciaModel(
      {required this.id,
      required this.norma,
      required this.codigo,
      required this.nombre,
      required this.duracion,
      required this.programa});
}

// lista de competencias
List<CompetenciaModel> competencias = [];

// Obtener las competencias de la base de datos
Future<List<CompetenciaModel>> getCompetencias() async {
  // URL para obtener los datos de las competencias de la API.
  String url = "";

  url = "$sourceApi/api/competencias/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de las competencias
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    competencias.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var competenciadata in decodedData) {
      competencias.add(CompetenciaModel(
          id: competenciadata['id'] ?? 0,
          norma: competenciadata['norma'] ?? "",
          codigo: competenciadata['codigo'] ?? "",
          nombre: competenciadata['nombre'] ?? "",
          duracion: competenciadata['duracion'] ?? 0,
          programa: ProgramaModel(
            id: competenciadata['programa']['id'] ?? 0,
            nombre: competenciadata['programa']['nombre'] ?? "",
            codigo: competenciadata['programa']['codigo'] ?? "",
            version: competenciadata['programa']['version'] ?? 0,
            fechaInicio: competenciadata['programa']['fechaInicio'] ?? "",
            fechaFin: competenciadata['programa']['fechaFin'] ?? "",
            duracionLectiva:
                competenciadata['programa']['duracionLectiva'] ?? 0,
            duracionProductiva:
                competenciadata['programa']['duracionProductiva'] ?? 0,
            duracionTotal: competenciadata['programa']['duracionTotal'] ?? 0,
            tipoPrograma: competenciadata['programa']['tipoPrograma'] ?? "",
            certificacion: competenciadata['programa']['certificacion'] ?? "",
            descripcion: competenciadata['programa']['descripcion'] ?? "",
            area: competenciadata['programa']['area'] ?? "",
          )));
    }

    // Retornar la lista de competencias
    return competencias;
  } else {
    // Lanzar una excepción si la respuesta no fue exitosa
    throw Exception(
        'Fallo la solicitud HTTP con el estado ${response.statusCode}');
  }
}
