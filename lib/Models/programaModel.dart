// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para los programas
class ProgramaModel {
  // id del programa
  final int id;

  // nombre del programa
  final String nombre;

  // codigo del programa
  final String codigo;

  // version del programa
  final int version;

  // fecha de inicio del programa
  final String fechaInicio;

  // fecha de fin del programa
  final String fechaFin;

  // duracion lectiva del programa
  final int duracionLectiva;

  // duracion productiva del programa
  final int duracionProductiva;

  // duracion total del programa
  final int duracionTotal;

  // tipo de programa
  final String tipoPrograma;

  // tipo de certificación del programa
  final String certificacion;

  // descripción del programa
  final String descripcion;

  // area del programa
  final String area;

  // constructor requiriendo los atributos
  ProgramaModel(
      {required this.id,
      required this.nombre,
      required this.codigo,
      required this.version,
      required this.fechaInicio,
      required this.fechaFin,
      required this.duracionLectiva,
      required this.duracionProductiva,
      required this.duracionTotal,
      required this.tipoPrograma,
      required this.certificacion,
      required this.descripcion,
      required this.area});
}

// listado de los programas
List<ProgramaModel> programas = [];

// funcion para obtener los programas de la base de datos
Future<List<ProgramaModel>> getProgramas() async {
  // URL para obtener los datos de los programas de la API.
  String url = "";

  url = "$sourceApi/api/programas/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de los programas
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    programas.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var programadata in decodedData) {
      programas.add(ProgramaModel(
          id: programadata['id'] ?? 0,
          nombre: programadata['nombre'] ?? "",
          codigo: programadata['codigo'] ?? "",
          version: programadata['version'] ?? 0,
          fechaInicio: programadata['fechaInicio'] ?? "",
          fechaFin: programadata['fechaFin'] ?? "",
          duracionLectiva: programadata['duracionLectiva'] ?? 0,
          duracionProductiva: programadata['duracionProductiva'] ?? 0,
          duracionTotal: programadata['duracionTotal'] ?? 0,
          tipoPrograma: programadata['tipoPrograma'] ?? "",
          certificacion: programadata['certificacion'] ?? "",
          descripcion: programadata['descripcion'] ?? "",
          area: programadata['area'] ?? ""));
    }
    // Devolver la lista de programas
    return programas;
  } else {
    // Si la respuesta no fue exitosa, se lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
