// ignore_for_file: file_names

import 'dart:convert';
import 'package:horarios_cba/Models/aulaModel.dart';
import 'package:horarios_cba/Models/competenciaModel.dart';
import 'package:horarios_cba/Models/planeacionModel.dart';
import 'package:horarios_cba/Models/programacionModel.dart';
import 'package:horarios_cba/Models/programaModel.dart';
import 'package:horarios_cba/Models/resultadoAprendizajeModel.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:http/http.dart' as http;
import '../source.dart';

// modelo para los horarios
class Horariomodel {
  // id del horario
  final int id;
  // dia
  final String dia;
  // hora de inicio
  final String horaInicio;
  // hora de fin
  final String horaFin;
  // programacion relacionada al horario
  final ProgramacionModel programacion;
  // aula relacionada al horario
  final AulaModel aula;

  // constructor requiriendo todos los atributos
  Horariomodel({
    required this.id,
    required this.dia,
    required this.horaInicio,
    required this.horaFin,
    required this.programacion,
    required this.aula,
  });
}

// lista de horarios
List<Horariomodel> horarios = [];

// funcion para obtener los horarios de la base de datos
Future<List<Horariomodel>> getHorarios() async {
  // URL para obtener los datos de los horarios de la API.
  String url = "";

  url = "$sourceApi/api/horarios/".trimRight();

  // Realizar una solicitud GET a la URL para obtener los datos de los horarios
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    horarios.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var horariodata in decodedData) {
      horarios.add(Horariomodel(
        id: horariodata['id'] ?? 0,
        dia: horariodata['dia'] ?? '',
        horaInicio: horariodata['horaInicio'] ?? '',
        horaFin: horariodata['horaFin'] ?? '',
        programacion: ProgramacionModel(
          id: horariodata['programacion']['id'] ?? 0,
          trimestre: horariodata['programacion']['trimestre'] ?? 0,
          ficha: horariodata['programacion']['ficha'] ?? 0,
          diasAsignados: horariodata['programacion']['diasAsignados'] ?? 0,
          usuario: UsuarioModel(
            id: horariodata['programacion']['usuario']['id'] ?? 0,
            nombres: horariodata['programacion']['usuario']['nombres'] ?? "",
            apellidos:
                horariodata['programacion']['usuario']['apellidos'] ?? "",
            tipoDocumento:
                horariodata['programacion']['usuario']['tipoDocumento'] ?? "",
            numeroDocumento:
                horariodata['programacion']['usuario']['numeroDocumento'] ?? "",
            correoElectronico: horariodata['programacion']['usuario']
                    ['correoElectronico'] ??
                "",
            telefono: horariodata['programacion']['usuario']['telefono'] ?? "",
            telefonoCelular:
                horariodata['programacion']['usuario']['telefonoCelular'] ?? "",
            rol: horariodata['programacion']['usuario']['rol'] ?? "",
            cargo: horariodata['programacion']['usuario']['cargo'] ?? "",
            especialidad:
                horariodata['programacion']['usuario']['especialidad'] ?? "",
            foto: horariodata['programacion']['usuario']['foto'] ?? "",
            vocero: horariodata['programacion']['usuario']['vocero'] ?? false,
            titulacion:
                horariodata['programacion']['usuario']['titulacion'] ?? "",
            estado: horariodata['programacion']['usuario']['estado'] ?? false,
            enLinea: horariodata['programacion']['usuario']['enLinea'] ?? false,
            tipoInstructor:
                horariodata['programacion']['usuario']['tipoInstructor'] ?? "",
            area: horariodata['programacion']['usuario']['area'] ?? "",
            fechaRegistro:
                horariodata['programacion']['usuario']['fechaRegistro'] ?? "",
          ),
          planeacion: PlaneacionModel(
            id: horariodata['programacion']['planeacion']['id'] ?? 0,
            numero: horariodata['programacion']['planeacion']['numero'] ?? 0,
            trabajoDirecto: horariodata['programacion']['planeacion']
                    ['trabajoDirecto'] ??
                0,
            trabajoAutonomo: horariodata['programacion']['planeacion']
                    ['trabajoAutonomo'] ??
                0,
            duracionTotal:
                horariodata['programacion']['planeacion']['duracionTotal'] ?? 0,
            creditos:
                horariodata['programacion']['planeacion']['creditos'] ?? 0,
            horasRecomendadas: horariodata['programacion']['planeacion']
                    ['horasRecomendadas'] ??
                0,
            diasRecomendados: horariodata['programacion']['planeacion']
                    ['diasRecomendados'] ??
                0,
            resultadoAprendizaje: ResultadoAprendizajeModel(
              id: horariodata['programacion']['planeacion']
                      ['resultadoAprendizaje']['id'] ??
                  0,
              numero: horariodata['programacion']['planeacion']
                      ['resultadoAprendizaje']['numero'] ??
                  "",
              descripcion: horariodata['programacion']['planeacion']
                      ['resultadoAprendizaje']['descripcion'] ??
                  "",
              competencia: CompetenciaModel(
                id: horariodata['programacion']['planeacion']
                        ['resultadoAprendizaje']['competencia']['id'] ??
                    0,
                norma: horariodata['programacion']['planeacion']
                        ['resultadoAprendizaje']['competencia']['norma'] ??
                    "",
                codigo: horariodata['programacion']['planeacion']
                        ['resultadoAprendizaje']['competencia']['codigo'] ??
                    "",
                nombre: horariodata['programacion']['planeacion']
                        ['resultadoAprendizaje']['competencia']['nombre'] ??
                    "",
                duracion: horariodata['programacion']['planeacion']
                        ['resultadoAprendizaje']['competencia']['duracion'] ??
                    0,
                programa: ProgramaModel(
                  id: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['id'] ??
                      0,
                  nombre: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['nombre'] ??
                      "",
                  codigo: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['codigo'] ??
                      "",
                  version: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['version'] ??
                      0,
                  fechaInicio: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['fechaInicio'] ??
                      "",
                  fechaFin: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['fechaFin'] ??
                      "",
                  duracionLectiva: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['duracionLectiva'] ??
                      0,
                  duracionProductiva: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['duracionProductiva'] ??
                      0,
                  duracionTotal: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['duracionTotal'] ??
                      0,
                  tipoPrograma: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['tipoPrograma'] ??
                      "",
                  certificacion: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['certificacion'] ??
                      "",
                  descripcion: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['descripcion'] ??
                      "",
                  area: horariodata['programacion']['planeacion']
                              ['resultadoAprendizaje']['competencia']
                          ['programa']['area'] ??
                      "",
                ),
              ),
            ),
          ),
        ),
        aula: AulaModel(
          id: horariodata['aula']['id'] ?? 0,
          nombre: horariodata['aula']['nombre'] ?? "",
          capacidad: horariodata['aula']['capacidad'] ?? 0,
          ubicacion: horariodata['aula']['ubicacion'] ?? "",
          estado: horariodata['aula']['estado'] ?? false,
        ),
      ));
    }

    // retornar la lista de horarios
    return horarios;
  } else {
    // si hay un error, lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
