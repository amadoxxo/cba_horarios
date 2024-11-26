// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/competenciaModel.dart';
import 'package:horarios_cba/Models/planeacionModel.dart';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:horarios_cba/Models/resultadoAprendizajeModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para las tematicas
class TematicaModel {
  // id de la tematica
  final int id;
  // descripcion de la tematica
  final String descripcion;
  // planeacion relacionada a la tematica
  final PlaneacionModel planeacion;

  // constructor requiriendo cada atributo
  TematicaModel(
      {required this.id, required this.descripcion, required this.planeacion});
}

// listado de tematicas
List<TematicaModel> tematicas = [];

// funcion para obtener las tematicas de la base de datos
Future<List<TematicaModel>> getTematicas() async {
  // URL para obtener los datos de las tematicas de la API.
  String url = "";

  url = "$sourceApi/api/tematicas/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de las tematicas
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    tematicas.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);

    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var tematicadata in decodedData) {
      tematicas.add(TematicaModel(
        id: tematicadata['id'] ?? 0,
        descripcion: tematicadata['descripcion'] ?? "",
        planeacion: PlaneacionModel(
          id: tematicadata['planeacion']['id'] ?? 0,
          numero: tematicadata['planeacion']['numero'] ?? 0,
          trabajoDirecto: tematicadata['planeacion']['trabajoDirecto'] ?? 0,
          trabajoAutonomo: tematicadata['planeacion']['trabajoAutonomo'] ?? 0,
          duracionTotal: tematicadata['planeacion']['duracionTotal'] ?? 0,
          horasRecomendadas:
              tematicadata['planeacion']['horasRecomendadas'] ?? 0,
          diasRecomendados: tematicadata['planeacion']['diasRecomendados'] ?? 0,
          creditos: tematicadata['planeacion']['creditos'] ?? 0,
          resultadoAprendizaje: ResultadoAprendizajeModel(
            id: tematicadata['planeacion']['resultadoAprendizaje']['id'] ?? 0,
            numero: tematicadata['planeacion']['resultadoAprendizaje']
                    ['numero'] ??
                "",
            descripcion: tematicadata['planeacion']['resultadoAprendizaje']
                    ['descripcion'] ??
                "",
            competencia: CompetenciaModel(
              id: tematicadata['planeacion']['resultadoAprendizaje']
                      ['competencia']['id'] ??
                  0,
              norma: tematicadata['planeacion']['resultadoAprendizaje']
                      ['competencia']['norma'] ??
                  "",
              codigo: tematicadata['planeacion']['resultadoAprendizaje']
                      ['competencia']['codigo'] ??
                  "",
              nombre: tematicadata['planeacion']['resultadoAprendizaje']
                      ['competencia']['nombre'] ??
                  "",
              duracion: tematicadata['planeacion']['resultadoAprendizaje']
                      ['competencia']['duracion'] ??
                  0,
              programa: ProgramaModel(
                id: tematicadata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['id'] ??
                    0,
                nombre: tematicadata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['nombre'] ??
                    "",
                codigo: tematicadata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['codigo'] ??
                    "",
                version: tematicadata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['version'] ??
                    0,
                fechaInicio: tematicadata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['fechaInicio'] ??
                    "",
                fechaFin: tematicadata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['fechaFin'] ??
                    "",
                duracionLectiva: tematicadata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['duracionLectiva'] ??
                    0,
                duracionProductiva: tematicadata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['duracionProductiva'] ??
                    0,
                duracionTotal: tematicadata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['duracionTotal'] ??
                    0,
                tipoPrograma: tematicadata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['tipoPrograma'] ??
                    "",
                certificacion: tematicadata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['certificacion'] ??
                    "",
                descripcion: tematicadata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['descripcion'] ??
                    "",
                area: tematicadata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['area'] ??
                    "",
              ),
            ),
          ),
        ),
      ));
    }

    // Retornar la lista de tematicas
    return tematicas;
  } else {
    // Lanzar una excepción si el código de estado no es 200
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
