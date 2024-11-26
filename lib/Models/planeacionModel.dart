// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/competenciaModel.dart';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:horarios_cba/Models/resultadoAprendizajeModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para las planeaciones
class PlaneacionModel {
  // id de la planeación
  final int id;
  // número de la planeación
  final int numero;
  // trabajo directo de la planeación
  final int trabajoDirecto;
  // trabajo autonomo de la planeación
  final int trabajoAutonomo;
  // duración total de la planeación
  final int duracionTotal;
  // horas recomendadas de la planeación
  final int horasRecomendadas;
  // días recomendados de la planeación
  final double diasRecomendados;
  // creditos de la planeación
  final double creditos;
  // resultado de la planeación
  final ResultadoAprendizajeModel resultadoAprendizaje;

  // constructor requiriendo los atributos
  PlaneacionModel(
      {required this.id,
      required this.numero,
      required this.trabajoDirecto,
      required this.trabajoAutonomo,
      required this.duracionTotal,
      required this.resultadoAprendizaje,
      required this.horasRecomendadas,
      required this.diasRecomendados,
      required this.creditos});
}

// lista de las planeaciones
List<PlaneacionModel> planeaciones = [];

// función para obtener las planeaciones de la base de datos
Future<List<PlaneacionModel>> getPlaneaciones() async {
  // URL para obtener los datos de las planeaciones de la API.
  String url = "";

  url = "$sourceApi/api/planeaciones/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de las planeaciones
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    planeaciones.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var planeaciondata in decodedData) {
      planeaciones.add(PlaneacionModel(
        id: planeaciondata['id'] ?? 0,
        numero: planeaciondata['numero'] ?? 0,
        trabajoDirecto: planeaciondata['trabajoDirecto'] ?? 0,
        trabajoAutonomo: planeaciondata['trabajoAutonomo'] ?? 0,
        duracionTotal: planeaciondata['duracionTotal'] ?? 0,
        horasRecomendadas: planeaciondata['horasRecomendadas'] ?? 0,
        diasRecomendados: planeaciondata['diasRecomendados'] ?? 0,
        creditos: planeaciondata['creditos'] ?? 0,
        resultadoAprendizaje: ResultadoAprendizajeModel(
          id: planeaciondata['resultadoAprendizaje']['id'] ?? 0,
          numero: planeaciondata['resultadoAprendizaje']['numero'] ?? "",
          descripcion:
              planeaciondata['resultadoAprendizaje']['descripcion'] ?? "",
          competencia: CompetenciaModel(
            id: planeaciondata['resultadoAprendizaje']['competencia']['id'] ??
                0,
            norma: planeaciondata['resultadoAprendizaje']['competencia']
                    ['norma'] ??
                "",
            codigo: planeaciondata['resultadoAprendizaje']['competencia']
                    ['codigo'] ??
                "",
            nombre: planeaciondata['resultadoAprendizaje']['competencia']
                    ['nombre'] ??
                "",
            duracion: planeaciondata['resultadoAprendizaje']['competencia']
                    ['duracion'] ??
                0,
            programa: ProgramaModel(
              id: planeaciondata['resultadoAprendizaje']['competencia']
                      ['programa']['id'] ??
                  0,
              nombre: planeaciondata['resultadoAprendizaje']['competencia']
                      ['programa']['nombre'] ??
                  "",
              codigo: planeaciondata['resultadoAprendizaje']['competencia']
                      ['programa']['codigo'] ??
                  "",
              version: planeaciondata['resultadoAprendizaje']['competencia']
                      ['programa']['version'] ??
                  0,
              fechaInicio: planeaciondata['resultadoAprendizaje']['competencia']
                      ['programa']['fechaInicio'] ??
                  "",
              fechaFin: planeaciondata['resultadoAprendizaje']['competencia']
                      ['programa']['fechaFin'] ??
                  "",
              duracionLectiva: planeaciondata['resultadoAprendizaje']
                      ['competencia']['programa']['duracionLectiva'] ??
                  0,
              duracionProductiva: planeaciondata['resultadoAprendizaje']
                      ['competencia']['programa']['duracionProductiva'] ??
                  0,
              duracionTotal: planeaciondata['resultadoAprendizaje']
                      ['competencia']['programa']['duracionTotal'] ??
                  0,
              tipoPrograma: planeaciondata['resultadoAprendizaje']
                      ['competencia']['programa']['tipoPrograma'] ??
                  "",
              certificacion: planeaciondata['resultadoAprendizaje']
                      ['competencia']['programa']['certificacion'] ??
                  "",
              descripcion: planeaciondata['resultadoAprendizaje']['competencia']
                      ['programa']['descripcion'] ??
                  "",
              area: planeaciondata['resultadoAprendizaje']['competencia']
                      ['programa']['area'] ??
                  "",
            ),
          ),
        ),
      ));
    }

    // retornar la lista de planeaciones
    return planeaciones;
  } else {
    // Si la respuesta no es exitosa, lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
