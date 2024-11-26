// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/competenciaModel.dart';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para los resultados de aprendizaje
class ResultadoAprendizajeModel {
  // id del resultado
  final int id;
  // numero del resultado
  final String numero;
  // descripcion del resultado
  final String descripcion;
  // competencia relacionada al resultado
  final CompetenciaModel competencia;

  // constructor requiriendo cada atributo
  ResultadoAprendizajeModel({
    required this.id,
    required this.numero,
    required this.descripcion,
    required this.competencia,
  });
}

// listado de resultados
List<ResultadoAprendizajeModel> resultados = [];

// funcion para obtener los resultados de aprendizaje de la base de datos
Future<List<ResultadoAprendizajeModel>> getResultados() async {
  // URL para obtener los datos de los resultados de aprendizaje de la API.
  String url = "";

  url = "$sourceApi/api/resultado_aprendizaje/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de los resultados
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    resultados.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var resultadodata in decodedData) {
      resultados.add(ResultadoAprendizajeModel(
        id: resultadodata['id'] ?? 0,
        numero: resultadodata['numero'] ?? "",
        descripcion: resultadodata['descripcion'] ?? "",
        competencia: CompetenciaModel(
          id: resultadodata['competencia']['id'] ?? 0,
          norma: resultadodata['competencia']['norma'] ?? "",
          codigo: resultadodata['competencia']['codigo'] ?? "",
          nombre: resultadodata['competencia']['nombre'] ?? "",
          duracion: resultadodata['competencia']['duracion'] ?? 0,
          programa: ProgramaModel(
            id: resultadodata['competencia']['programa']['id'] ?? 0,
            nombre: resultadodata['competencia']['programa']['nombre'] ?? "",
            codigo: resultadodata['competencia']['programa']['codigo'] ?? "",
            version: resultadodata['competencia']['programa']['version'] ?? 0,
            fechaInicio:
                resultadodata['competencia']['programa']['fechaInicio'] ?? "",
            fechaFin:
                resultadodata['competencia']['programa']['fechaFin'] ?? "",
            duracionLectiva: resultadodata['competencia']['programa']
                    ['duracionLectiva'] ??
                0,
            duracionProductiva: resultadodata['competencia']['programa']
                    ['duracionProductiva'] ??
                0,
            duracionTotal:
                resultadodata['competencia']['programa']['duracionTotal'] ?? 0,
            tipoPrograma:
                resultadodata['competencia']['programa']['tipoPrograma'] ?? "",
            certificacion:
                resultadodata['competencia']['programa']['certificacion'] ?? "",
            descripcion:
                resultadodata['competencia']['programa']['descripcion'] ?? "",
            area: resultadodata['competencia']['programa']['area'] ?? "",
          ),
        ),
      ));
    }

    // Retornar la lista de resultados
    return resultados;
  } else {
    // Retornar una excepción si la respuesta no fue exitosa
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
