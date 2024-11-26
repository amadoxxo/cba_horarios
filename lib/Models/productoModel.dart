// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/competenciaModel.dart';
import 'package:horarios_cba/Models/planeacionModel.dart';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:horarios_cba/Models/resultadoAprendizajeModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para los productos
class ProductoModel {
  // id del producto
  final int id;
  // descripcion del producto
  final String descripcion;
  // planeacion relacionada al producto
  final PlaneacionModel planeacion;

  // constructor requiriendo todos los atributos
  ProductoModel(
      {required this.id, required this.descripcion, required this.planeacion});
}

// obtiene la lista de productos
List<ProductoModel> productos = [];

// función para obtener los productos de la base de datos
Future<List<ProductoModel>> getProductos() async {
  // URL para obtener los datos de los productos de la API.
  String url = "";

  url = "$sourceApi/api/productos/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de los productos
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    productos.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var productodata in decodedData) {
      productos.add(ProductoModel(
        id: productodata['id'] ?? 0,
        descripcion: productodata['descripcion'] ?? "",
        planeacion: PlaneacionModel(
          id: productodata['planeacion']['id'] ?? 0,
          numero: productodata['planeacion']['numero'] ?? 0,
          trabajoDirecto: productodata['planeacion']['trabajoDirecto'] ?? 0,
          trabajoAutonomo: productodata['planeacion']['trabajoAutonomo'] ?? 0,
          duracionTotal: productodata['planeacion']['duracionTotal'] ?? 0,
          horasRecomendadas:
              productodata['planeacion']['horasRecomendadas'] ?? 0,
          diasRecomendados: productodata['planeacion']['diasRecomendados'] ?? 0,
          creditos: productodata['planeacion']['creditos'] ?? 0,
          resultadoAprendizaje: ResultadoAprendizajeModel(
            id: productodata['planeacion']['resultadoAprendizaje']['id'] ?? 0,
            numero: productodata['planeacion']['resultadoAprendizaje']
                    ['numero'] ??
                "",
            descripcion: productodata['planeacion']['resultadoAprendizaje']
                    ['descripcion'] ??
                "",
            competencia: CompetenciaModel(
              id: productodata['planeacion']['resultadoAprendizaje']
                      ['competencia']['id'] ??
                  0,
              norma: productodata['planeacion']['resultadoAprendizaje']
                      ['competencia']['norma'] ??
                  "",
              codigo: productodata['planeacion']['resultadoAprendizaje']
                      ['competencia']['codigo'] ??
                  "",
              nombre: productodata['planeacion']['resultadoAprendizaje']
                      ['competencia']['nombre'] ??
                  "",
              duracion: productodata['planeacion']['resultadoAprendizaje']
                      ['competencia']['duracion'] ??
                  0,
              programa: ProgramaModel(
                id: productodata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['id'] ??
                    0,
                nombre: productodata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['nombre'] ??
                    "",
                codigo: productodata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['codigo'] ??
                    "",
                version: productodata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['version'] ??
                    0,
                fechaInicio: productodata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['fechaInicio'] ??
                    "",
                fechaFin: productodata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['fechaFin'] ??
                    "",
                duracionLectiva: productodata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['duracionLectiva'] ??
                    0,
                duracionProductiva: productodata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['duracionProductiva'] ??
                    0,
                duracionTotal: productodata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['duracionTotal'] ??
                    0,
                tipoPrograma: productodata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['tipoPrograma'] ??
                    "",
                certificacion: productodata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['certificacion'] ??
                    "",
                descripcion: productodata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['descripcion'] ??
                    "",
                area: productodata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['area'] ??
                    "",
              ),
            ),
          ),
        ),
      ));
    }

    // Devolver la lista de productos
    return productos;
  } else {
    // Si la respuesta no es exitosa, lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
