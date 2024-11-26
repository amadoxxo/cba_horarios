// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:horarios_cba/Home/conceptoList.dart';
import 'package:horarios_cba/constantsDesign.dart';

// Clase ConceptoCard, que representa una tarjeta de concepto.
class ConceptoCard extends StatefulWidget {
  // variable de tipo de la clase concepto
  final Concepto concepto;

  // Constructor requiriendo la variable concepto
  const ConceptoCard({super.key, required this.concepto});

  @override
  State<ConceptoCard> createState() => _ConceptoCardState();
}

class _ConceptoCardState extends State<ConceptoCard> {
  // Variables para la animación de la carta
  bool isBack = true;
  double angle = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Función para lograr el angulo para la animación de la carta
    void _flip() {
      setState(() {
        angle = (angle + pi) % (2 * pi);
      });
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        // Llamado a la función del angulo
        onTap: _flip,
        child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: angle),
            duration: const Duration(seconds: 1),
            builder: (BuildContext context, double val, __) {
              //Aquí cambiaremos el valor de isBack para poder modificar el contenido de la tarjeta.
              if (val >= (pi / 2)) {
                isBack = false;
              } else {
                isBack = true;
              }
              return (Transform(
                //Vamos a hacer que la tarjeta gire por su centro.
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(val),
                child: SizedBox(
                    width: 309,
                    height: 474,
                    child: isBack
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("assets/img/back.png"),
                              ),
                            ),
                          ) //Si está en la parte posterior, mostraremos aquí.
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..rotateY(
                                  pi), // Volteará horizontalmente el contenedor.
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: AssetImage(widget.concepto.imageUrl),
                                ),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 190,
                                  height: 350,
                                  child: Column(
                                    // Contenido de la carta
                                    children: [
                                      const SizedBox(height: defaultPadding),
                                      // Titulo del concepto
                                      Text(
                                        widget.concepto.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      // Descripción del concepto
                                      Flexible(
                                        child: SingleChildScrollView(
                                          child: Text(
                                            widget.concepto.description,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: defaultPadding,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) // De lo contrario, lo mostraremos aquí.
                    ),
              ));
            }),
      ),
    );
  }
}
