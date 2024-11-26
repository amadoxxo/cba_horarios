// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para las fichas
class FichaModel {
  // id de la ficha
  final int id;
  // codigo de la ficha
  final String codigo;
  // descripción de la ficha
  final String descripcion;
  // fecha de inicio de la ficha
  final String fechaInicio;
  // fecha de fin de la ficha
  final String fechaFin;
  // lugar donde se encontrará la ficha
  final String lugar;
  // tipo de oferta de la ficha
  final String tipoOferta;
  // modalidad de la ficha
  final String modalidad;
  // estado de la ficha
  final bool estado;
  // programa relacionado a la ficha
  final ProgramaModel programa;

  // constructor requiriendo todos los atributos
  FichaModel(
      {required this.id,
      required this.codigo,
      required this.descripcion,
      required this.fechaInicio,
      required this.fechaFin,
      required this.lugar,
      required this.tipoOferta,
      required this.modalidad,
      required this.estado,
      required this.programa});
}

// lista de las fichas
List<FichaModel> fichas = [];

// funcion para obtener las fichas de la base de datos
Future<List<FichaModel>> getFichas() async {
  // URL para obtener los datos de las fichas de la API.
  String url = "";

  url = "$sourceApi/api/fichas/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de las fichas
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    fichas.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);

    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var fichadata in decodedData) {
      fichas.add(FichaModel(
        id: fichadata['id'] ?? 0,
        codigo: fichadata['codigo'] ?? "",
        descripcion: fichadata['descripcion'] ?? "",
        fechaInicio: fichadata['fechaInicio'] ?? "",
        fechaFin: fichadata['fechaFin'] ?? "",
        lugar: fichadata['lugar'] ?? "",
        tipoOferta: fichadata['tipoOferta'] ?? "",
        modalidad: fichadata['modalidad'] ?? "",
        estado: fichadata['estado'] ?? false,
        programa: ProgramaModel(
          id: fichadata['programa']['id'] ?? 0,
          nombre: fichadata['programa']['nombre'] ?? "",
          codigo: fichadata['programa']['codigo'] ?? "",
          version: fichadata['programa']['version'] ?? 0,
          fechaInicio: fichadata['programa']['fechaInicio'] ?? "",
          fechaFin: fichadata['programa']['fechaFin'] ?? "",
          duracionLectiva: fichadata['programa']['duracionLectiva'] ?? 0,
          duracionProductiva: fichadata['programa']['duracionProductiva'] ?? 0,
          duracionTotal: fichadata['programa']['duracionTotal'] ?? 0,
          tipoPrograma: fichadata['programa']['tipoPrograma'] ?? "",
          certificacion: fichadata['programa']['certificacion'] ?? "",
          descripcion: fichadata['programa']['descripcion'] ?? "",
          area: fichadata['programa']['area'] ?? "",
        ),
      ));
    }
    // Retornar la lista de las fichas
    return fichas;
  } else {
    // Retornar una excepción si la respuesta no fue exitosa
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
