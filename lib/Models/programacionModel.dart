// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/competenciaModel.dart';
import 'package:horarios_cba/Models/planeacionModel.dart';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:horarios_cba/Models/resultadoAprendizajeModel.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para las programaciones
class ProgramacionModel {
  // id de la programación
  final int id;

  // id del trimestre
  final int trimestre;

  // id de la ficha
  final int ficha;

  // dias asignados
  final double diasAsignados;

  // usuario relacionado a la programación
  final UsuarioModel usuario;

  // planeacion relacionada a la programación
  final PlaneacionModel planeacion;

  // constructor requiriendo todos los atributos
  ProgramacionModel({
    required this.id,
    required this.trimestre,
    required this.ficha,
    required this.diasAsignados,
    required this.usuario,
    required this.planeacion,
  });
}

// obtiene la lista de programaciones
List<ProgramacionModel> programaciones = [];

// función para obtener las programaciones de la base de datos
Future<List<ProgramacionModel>> getProgramaciones() async {
  // URL para obtener los datos de las programaciones de la API.
  String url = "";

  url = "$sourceApi/api/programaciones/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de las programaciones
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    programaciones.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var programaciondata in decodedData) {
      programaciones.add(ProgramacionModel(
        id: programaciondata['id'] ?? 0,
        trimestre: programaciondata['trimestre'] ?? 0,
        ficha: programaciondata['ficha'] ?? 0,
        diasAsignados: programaciondata['diasAsignados'] ?? 0,
        usuario: UsuarioModel(
          id: programaciondata['usuario']['id'] ?? 0,
          nombres: programaciondata['usuario']['nombres'] ?? "",
          apellidos: programaciondata['usuario']['apellidos'] ?? "",
          tipoDocumento: programaciondata['usuario']['tipoDocumento'] ?? "",
          numeroDocumento: programaciondata['usuario']['numeroDocumento'] ?? "",
          correoElectronico:
              programaciondata['usuario']['correoElectronico'] ?? "",
          telefono: programaciondata['usuario']['telefono'] ?? "",
          telefonoCelular: programaciondata['usuario']['telefonoCelular'] ?? "",
          rol: programaciondata['usuario']['rol'] ?? "",
          cargo: programaciondata['usuario']['cargo'] ?? "",
          especialidad: programaciondata['usuario']['especialidad'] ?? "",
          foto: programaciondata['usuario']['foto'] ?? "",
          vocero: programaciondata['usuario']['vocero'] ?? false,
          titulacion: programaciondata['usuario']['titulacion'] ?? "",
          estado: programaciondata['usuario']['estado'] ?? false,
          enLinea: programaciondata['usuario']['enLinea'] ?? false,
          tipoInstructor: programaciondata['usuario']['tipoInstructor'] ?? "",
          area: programaciondata['usuario']['area'] ?? "",
          fechaRegistro: programaciondata['usuario']['fechaRegistro'] ?? "",
        ),
        planeacion: PlaneacionModel(
          id: programaciondata['planeacion']['id'] ?? 0,
          numero: programaciondata['planeacion']['numero'] ?? 0,
          trabajoDirecto: programaciondata['planeacion']['trabajoDirecto'] ?? 0,
          trabajoAutonomo:
              programaciondata['planeacion']['trabajoAutonomo'] ?? 0,
          duracionTotal: programaciondata['planeacion']['duracionTotal'] ?? 0,
          horasRecomendadas:
              programaciondata['planeacion']['horasRecomendadas'] ?? 0,
          diasRecomendados:
              programaciondata['planeacion']['diasRecomendados'] ?? 0,
          creditos: programaciondata['planeacion']['creditos'] ?? 0,
          resultadoAprendizaje: ResultadoAprendizajeModel(
            id: programaciondata['planeacion']['resultadoAprendizaje']['id'] ??
                0,
            numero: programaciondata['planeacion']['resultadoAprendizaje']
                    ['numero'] ??
                "",
            descripcion: programaciondata['planeacion']['resultadoAprendizaje']
                    ['descripcion'] ??
                "",
            competencia: CompetenciaModel(
              id: programaciondata['planeacion']['resultadoAprendizaje']
                      ['competencia']['id'] ??
                  0,
              norma: programaciondata['planeacion']['resultadoAprendizaje']
                      ['competencia']['norma'] ??
                  "",
              codigo: programaciondata['planeacion']['resultadoAprendizaje']
                      ['competencia']['codigo'] ??
                  "",
              nombre: programaciondata['planeacion']['resultadoAprendizaje']
                      ['competencia']['nombre'] ??
                  "",
              duracion: programaciondata['planeacion']['resultadoAprendizaje']
                      ['competencia']['duracion'] ??
                  0,
              programa: ProgramaModel(
                id: programaciondata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['id'] ??
                    0,
                nombre: programaciondata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['nombre'] ??
                    "",
                codigo: programaciondata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['codigo'] ??
                    "",
                version: programaciondata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['version'] ??
                    0,
                fechaInicio: programaciondata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['fechaInicio'] ??
                    "",
                fechaFin: programaciondata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['fechaFin'] ??
                    "",
                duracionLectiva: programaciondata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['duracionLectiva'] ??
                    0,
                duracionProductiva: programaciondata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['duracionProductiva'] ??
                    0,
                duracionTotal: programaciondata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['duracionTotal'] ??
                    0,
                tipoPrograma: programaciondata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['tipoPrograma'] ??
                    "",
                certificacion: programaciondata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['certificacion'] ??
                    "",
                descripcion: programaciondata['planeacion']
                            ['resultadoAprendizaje']['competencia']['programa']
                        ['descripcion'] ??
                    "",
                area: programaciondata['planeacion']['resultadoAprendizaje']
                        ['competencia']['programa']['area'] ??
                    "",
              ),
            ),
          ),
        ),
      ));
    }

    // retorna la lista de programaciones
    return programaciones;
  } else {
    // Si la respuesta no fue exitosa, lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
