class Horarios {
  final String resultadoAprendizaje;

  final String instructor;

  final String planeacion;

  final String dia;

  final String horaInicio;

  final String horaFin;

  Horarios({
    required this.resultadoAprendizaje,
    required this.instructor,
    required this.planeacion,
    required this.dia,
    required this.horaInicio,
    required this.horaFin,
  });
}

List<Horarios> listaHorarios = [
  Horarios(
      resultadoAprendizaje: "MODELADO ARTEFACTOS SOFTWARE",
      instructor: "Natividad Panche Guevara",
      planeacion: "01",
      dia: "Lunes",
      horaInicio: "7:15 Am",
      horaFin: "12:00 M"),
  Horarios(
      resultadoAprendizaje: "MODELADO ARTEFACTOS SOFTWARE",
      instructor: "Natividad Panche Guevara",
      planeacion: "01",
      dia: "Lunes",
      horaInicio: "13:15 Pm",
      horaFin: "17:00 Pm"),
  Horarios(
      resultadoAprendizaje:
          "SOLUCIONAR PROBLEMAS ASOCIADOS CON EL SECTOR PRODUCTIVO CON BASE EN LOS PRINCIPIOS Y LEYES DE LA FÍSICA",
      instructor: "Marco Antonio Bohorquez Padilla",
      planeacion: "02",
      dia: "Martes",
      horaInicio: "7:15 Am",
      horaFin: "12:00 M"),
  Horarios(
      resultadoAprendizaje:
          "ANALIZAR LAS ESTRATEGIAS PARA LA PREVENCIÓN Y CONTROL DE LOS IMPACTOS AMBIENTALES Y DE LOS ACCIDENTES Y ENFERMEDADES LABORALES (ATEL) DE ACUERDO CON LAS POLÍTICAS ORGANIZACIONALES Y EL ENTORNO SOCIAL",
      instructor: "Ana María Obando Rojas",
      planeacion: "03",
      dia: "Miercoles",
      horaInicio: "7:15 Am",
      horaFin: "12:00 M"),
  Horarios(
      resultadoAprendizaje:
          "CONSTRUIR LA BASE DE DATOS PARA EL SOFTWARE A PARTIR DEL MODELO DE DATOS",
      instructor: "Jhon Sebastian Soacha Chavez",
      planeacion: "03",
      dia: "Miercoles",
      horaInicio: "13:15 Pm",
      horaFin: "17:00 Pm"),
  Horarios(
      resultadoAprendizaje:
          "EJECUTAR ACTIVIDADES DE ACONDICIONAMIENTO FÍSICO ORIENTADAS HACIA EL MEJORAMIENTO DE LA CONDICIÓN FÍSICA EN LOS CONTEXTOS PRODUCTIVO Y SOCIAL",
      instructor: "Margarita León Suarez",
      planeacion: "04",
      dia: "Jueves",
      horaInicio: "13:15 Pm",
      horaFin: "17:00 Pm"),
  Horarios(
      resultadoAprendizaje:
          "DISCUTIR SOBRE POSIBLES SOLUCIONES A PROBLEMAS DENTRO DE UN RANGO VARIADO DE CONTEXTOS SOCIALES Y LABORALES",
      instructor: "Noah Damian Castillo Mendoza ",
      planeacion: "05",
      dia: "Viernes",
      horaInicio: "7:15 Am",
      horaFin: "12:00 M"),
];
