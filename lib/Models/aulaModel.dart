// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para las aulas
class AulaModel {
  // id del aula
  final int id;
  // nombre del aula
  final String nombre;
  // capacidad del aula
  final int capacidad;
  // ubicación del aula
  final String ubicacion;
  // estado del aula
  final bool estado;

  // constructor requiriendo todos los atributos
  AulaModel({
    required this.id,
    required this.nombre,
    required this.capacidad,
    required this.ubicacion,
    required this.estado,
  });
}

// lista de aulas
List<AulaModel> aulas = [];

// funcion para obtener las aulas de la base de datos
Future<List<AulaModel>> getAulas() async {
  // URL para obtener los datos de las aulas de la API.
  String url = "";

  url = "$sourceApi/api/aulas/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de las aulas
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    aulas.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);

    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var auladata in decodedData) {
      aulas.add(AulaModel(
        id: auladata['id'] ?? 0,
        nombre: auladata['nombre'] ?? "",
        capacidad: auladata['capacidad'] ?? 0,
        ubicacion: auladata['ubicacion'] ?? "",
        estado: auladata['estado'] ?? false,
      ));
    }

    // retornar la lista de aulas
    return aulas;
  } else {
    // si la respuesta no fue exitosa, se lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
