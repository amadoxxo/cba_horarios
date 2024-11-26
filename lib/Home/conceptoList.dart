// ignore_for_file: file_names

// Clase que representa un concepto.
class Concepto {
  // Titulo del concepto
  final String title;
  // Descripción del concepto
  final String description;
  // Imagen del concepto
  final String imageUrl;

  // Constructor requiriendo todos los atributos
  Concepto({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

// Listado de conceptos
List<Concepto> conceptoList = [
  Concepto(
      title: "Programa",
      description:
          "Conjunto de cursos y actividades del SENA que desarrollan habilidades y conocimientos en biotecnología agropecuaria, preparando a los aprendices para el mundo laboral con competencias alineadas al sector productivo.",
      imageUrl: "assets/img/sena2.jpg"),
  Concepto(
      title: "Competencia",
      description:
          "Capacidad integral de aplicar conocimientos, habilidades y actitudes para resolver problemas y ejecutar tareas específicas, alineada con las demandas del sector productivo para un desempeño laboral efectivo.",
      imageUrl: "assets/img/sena3.jpg"),
  Concepto(
      title: "Resultado de aprendizaje",
      description:
          "Logro verificable al finalizar una etapa formativa, que incluye conocimientos, habilidades y competencias demostradas, asegurando la preparación del aprendiz para su campo profesional.",
      imageUrl: "assets/img/sena4.jpg"),
  Concepto(
      title: "Ficha",
      description:
          "Grupo de aprendices con un programa de formación específico, identificado por un número único para gestionar instructores, recursos y horarios, organizando el proceso educativo según el plan establecido.",
      imageUrl: "assets/img/sena5.jpg"),
  Concepto(
      title: "Planeación Pedagógica",
      description:
          "Proceso de diseñar y organizar actividades y contenidos educativos para alcanzar objetivos de aprendizaje, definiendo qué y cómo enseñar, los recursos a usar, y la evaluación del progreso, garantizando un aprendizaje estructurado y efectivo.",
      imageUrl: "assets/img/sena6.jpg"),
];
