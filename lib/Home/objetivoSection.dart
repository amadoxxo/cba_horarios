// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/responsive.dart';

// Clase ObjetivoSection, que representa la sección de objetivos.
class ObjetivoSection extends StatelessWidget {
  const ObjetivoSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Verifica si la pantalla es escritorio o tablet.
    return Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Objetivo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Calibri-Bold',
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(
                              0.5), // Color y opacidad de la sombra
                          offset: const Offset(2,
                              2), // Desplazamiento de la sombra (horizontal, vertical)
                          blurRadius: 3, // Radio de desenfoque de la sombra
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "En el Centro de Biotecnología Agropecuaria, hemos desarrollado una aplicación de asignación de horarios para optimizar la gestión de recursos educativos. Esta herramienta asegura una distribución eficiente de aulas, laboratorios e instructores, mejorando la coordinación y el acceso a información en tiempo real, con el objetivo de ofrecer una experiencia educativa de calidad respaldada por soluciones tecnológicas.",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(
                                      0.5), // Color y opacidad de la sombra
                                  offset: const Offset(2,
                                      2), // Desplazamiento de la sombra (horizontal, vertical)
                                  blurRadius:
                                      3, // Radio de desenfoque de la sombra
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 400,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Container(
                              width: 350,
                              height: 350,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/img/sena1.webp",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        // Pantalla si es dispositivo movil
        : Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Objetivo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Calibri-Bold',
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(
                              0.5), // Color y opacidad de la sombra
                          offset: const Offset(2,
                              2), // Desplazamiento de la sombra (horizontal, vertical)
                          blurRadius: 3, // Radio de desenfoque de la sombra
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "En el Centro de Biotecnología Agropecuaria, hemos desarrollado una aplicación de asignación de horarios para optimizar la gestión de recursos educativos. Esta herramienta asegura una distribución eficiente de aulas, laboratorios e instructores, mejorando la coordinación y el acceso a información en tiempo real, con el objetivo de ofrecer una experiencia educativa de calidad respaldada por soluciones tecnológicas.",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(
                                  0.5), // Color y opacidad de la sombra
                              offset: const Offset(2,
                                  2), // Desplazamiento de la sombra (horizontal, vertical)
                              blurRadius: 3, // Radio de desenfoque de la sombra
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Container(
                              width: 350,
                              height: 350,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/img/sena1.webp",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
