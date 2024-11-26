// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/fichaModel.dart';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para los lideres de ficha
class LiderFichaModel {
  // id de la inscripción
  final int id;
  // id del instructor
  final int usuario;
  // id de la ficha relacionada al lider de ficha
  final FichaModel ficha;

  // constructor requiriendo todos los atributos
  LiderFichaModel(
      {required this.id, required this.usuario, required this.ficha});
}

// lista de lideres de ficha
List<LiderFichaModel> lideres = [];

// funcion para obtener los lideres de la base de datos
Future<List<LiderFichaModel>> getLideres() async {
  // URL para obtener los datos de los lideres de la API.
  String url = "";

  url = "$sourceApi/api/lider_ficha/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de los lideres
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    lideres.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var inscripciondata in decodedData) {
      lideres.add(LiderFichaModel(
          id: inscripciondata['id'] ?? 0,
          usuario: inscripciondata['usuario'] ?? 0,
          ficha: FichaModel(
            id: inscripciondata['ficha']['id'] ?? 0,
            codigo: inscripciondata['ficha']['codigo'] ?? "",
            descripcion: inscripciondata['ficha']['descripcion'] ?? "",
            fechaInicio: inscripciondata['ficha']['fechaInicio'] ?? "",
            fechaFin: inscripciondata['ficha']['fechaFin'] ?? "",
            lugar: inscripciondata['ficha']['lugar'] ?? "",
            tipoOferta: inscripciondata['ficha']['tipoOferta'] ?? "",
            modalidad: inscripciondata['ficha']['modalidad'] ?? "",
            estado: inscripciondata['ficha']['estado'] ?? false,
            programa: ProgramaModel(
              id: inscripciondata['ficha']['programa']['id'] ?? 0,
              nombre: inscripciondata['ficha']['programa']['nombre'] ?? "",
              codigo: inscripciondata['ficha']['programa']['codigo'] ?? "",
              version: inscripciondata['ficha']['programa']['version'] ?? 0,
              fechaInicio:
                  inscripciondata['ficha']['programa']['fechaInicio'] ?? "",
              fechaFin: inscripciondata['ficha']['programa']['fechaFin'] ?? "",
              duracionLectiva:
                  inscripciondata['ficha']['programa']['duracionLectiva'] ?? 0,
              duracionProductiva: inscripciondata['ficha']['programa']
                      ['duracionProductiva'] ??
                  0,
              duracionTotal:
                  inscripciondata['ficha']['programa']['duracionTotal'] ?? 0,
              tipoPrograma:
                  inscripciondata['ficha']['programa']['tipoPrograma'] ?? "",
              certificacion:
                  inscripciondata['ficha']['programa']['certificacion'] ?? "",
              descripcion:
                  inscripciondata['ficha']['programa']['descripcion'] ?? "",
              area: inscripciondata['ficha']['programa']['area'] ?? "",
            ),
          )));
    }
    // retornar la lista de lideres
    return lideres;
  } else {
    // Si la respuesta no fue exitosa, lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
