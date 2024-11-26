// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:horarios_cba/Aula/Editar/aulaFormularioEditar.dart';
import 'package:horarios_cba/dashboard/listas/aulas.dart';
import 'package:horarios_cba/constantsDesign.dart';

class AulaCard extends StatefulWidget {
  final Aulas aula;
  final int index;
  const AulaCard({super.key, required this.aula, required this.index});

  @override
  State<AulaCard> createState() => _AulaCardState();
}

class _AulaCardState extends State<AulaCard> {
  // Lista de imágenes que se repetirán cíclicamente
  final List<String> imagenesAulas = [
    "assets/img/fondoAula1.webp",
    "assets/img/fondoAula2.webp",
    "assets/img/fondoAula3.webp",
    "assets/img/fondoAula4.webp",
    "assets/img/fondoAula5.webp",
  ];

  @override
  Widget build(BuildContext context) {
    // Calcula el índice de la imagen correspondiente según el índice de la tarjeta
    int indexImagen = widget.index % imagenesAulas.length;

    return Container(
      width: 309,
      height: 374,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // Asigna la imagen de fondo correspondiente
        image: DecorationImage(
            image: AssetImage(imagenesAulas[indexImagen]), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.5)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Flexible(
                        child: Text(
                      "Aula",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.white,
                          fontFamily: 'Calibri-Bold',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Flexible(
                        child: Text(
                      widget.aula.nombre,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontFamily: 'Calibri-Bold',
                          ),
                      textAlign: TextAlign.center,
                    )),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Capacidad: ${widget.aula.capacidad} Personas",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontFamily: 'Calibri-Bold',
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          Text(
                            "Ubicación: ${widget.aula.ubicacion}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontFamily: 'Calibri-Bold',
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          Text(
                            "Estado: ${widget.aula.estado}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontFamily: 'Calibri-Bold',
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(20), // Borde redondeado
                          boxShadow: const [
                            BoxShadow(
                              color: primaryColor, // Color de la sombra
                              offset: Offset(
                                  2.0, 2.0), // Desplazamiento de la sombra
                              blurRadius: 3.0, // Radio de desenfoque
                              spreadRadius: 1.0, // Radio de expansión
                            ),
                            BoxShadow(
                              color: primaryColor, // Color de la sombra
                              offset: Offset(
                                  0.0, 0.0), // Desplazamiento de la sombra
                              blurRadius: 0.0, // Radio de desenfoque
                              spreadRadius: 0.0, // Radio de expansión
                            ),
                          ],
                          color: Colors.white, // Color de fondo
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit,
                              size: 25,
                              color: primaryColor), // Icono de edición
                          onPressed: () {
                            // Acción al presionar el botón de editar
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AulaFormularioEditar()));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
