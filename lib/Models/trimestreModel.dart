// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/fichaModel.dart';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para los trimestres
class Trimestremodel {
  // id del trimestre
  final int id;

  // numero del trimestre
  final String numero;

  // fecha de inicio del trimestre
  final String fechaInicio;

  // fecha de fin del trimestre
  final String fechaFin;

  // estado del trimestre
  final String estado;

  // ficha relacionada al trimestre
  final FichaModel ficha;

  // constructor requiriendo cada atributo
  Trimestremodel(
      {required this.id,
      required this.numero,
      required this.fechaInicio,
      required this.fechaFin,
      required this.estado,
      required this.ficha});
}

// listado de trimestres
List<Trimestremodel> trimestres = [];

// funcion para obtener los trimestres de la base de datos
Future<List<Trimestremodel>> getTrimestres() async {
  // URL para obtener los datos de los trimestres de la API.
  String url = "";

  url = "$sourceApi/api/trimestres/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de los trimestres
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    trimestres.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var trimestredata in decodedData) {
      trimestres.add(
        Trimestremodel(
            id: trimestredata['id'] ?? 0,
            numero: trimestredata['numero'] ?? "",
            fechaInicio: trimestredata['fechaInicio'] ?? "",
            fechaFin: trimestredata['fechaFin'] ?? "",
            estado: trimestredata['estado'] ?? "",
            ficha: FichaModel(
                id: trimestredata['ficha']['id'] ?? 0,
                codigo: trimestredata['ficha']['codigo'] ?? "",
                descripcion: trimestredata['ficha']['descripcion'] ?? "",
                fechaInicio: trimestredata['ficha']['fechaInicio'] ?? "",
                fechaFin: trimestredata['ficha']['fechaFin'] ?? "",
                lugar: trimestredata['ficha']['lugar'] ?? "",
                tipoOferta: trimestredata['ficha']['tipoOferta'] ?? "",
                modalidad: trimestredata['ficha']['modalidad'] ?? "",
                estado: trimestredata['ficha']['estado'] ?? false,
                programa: ProgramaModel(
                  id: trimestredata['ficha']['programa']['id'] ?? 0,
                  nombre: trimestredata['ficha']['programa']['nombre'] ?? "",
                  codigo: trimestredata['ficha']['programa']['codigo'] ?? "",
                  version: trimestredata['ficha']['programa']['version'] ?? 0,
                  fechaInicio:
                      trimestredata['ficha']['programa']['fechaInicio'] ?? "",
                  fechaFin:
                      trimestredata['ficha']['programa']['fechaFin'] ?? "",
                  duracionLectiva: trimestredata['ficha']['programa']
                          ['duracionLectiva'] ??
                      0,
                  duracionProductiva: trimestredata['ficha']['programa']
                          ['duracionProductiva'] ??
                      0,
                  duracionTotal:
                      trimestredata['ficha']['programa']['duracionTotal'] ?? 0,
                  tipoPrograma:
                      trimestredata['ficha']['programa']['tipoPrograma'] ?? "",
                  certificacion:
                      trimestredata['ficha']['programa']['certificacion'] ?? "",
                  descripcion:
                      trimestredata['ficha']['programa']['descripcion'] ?? "",
                  area: trimestredata['ficha']['programa']['area'] ?? "",
                ))),
      );
    }

    // Retornar la lista de trimestres
    return trimestres;
  } else {
    // Lanzar una excepción si el código de estado no es 200
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
