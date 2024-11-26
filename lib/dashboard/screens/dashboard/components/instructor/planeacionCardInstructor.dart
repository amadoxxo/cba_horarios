// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:horarios_cba/dashboard/listas/planeaciones.dart';
import 'package:horarios_cba/Planeacion/planeacionView.dart';
import 'package:horarios_cba/constantsDesign.dart';

class PlaneacionCardInstructor extends StatefulWidget {
  final Planeaciones planeacion;
  const PlaneacionCardInstructor({
    super.key,
    required this.planeacion,
  });

  @override
  State<PlaneacionCardInstructor> createState() =>
      _PlaneacionCardInstructorState();
}

class _PlaneacionCardInstructorState extends State<PlaneacionCardInstructor> {
  Color _getColor() {
    final random = Random();
    final hue = random.nextDouble() * 360;
    final saturation = random.nextDouble() * (0.5 - 0.2) + 0.2;
    final value = random.nextDouble() * (0.9 - 0.5) + 0.5;

    return HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 309,
      height: 574,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _getColor(),
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
                      "Planeación",
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
                      widget.planeacion.numero.toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontFamily: 'Calibri-Bold',
                          ),
                      textAlign: TextAlign.center,
                    )),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    SizedBox(
                      height: 350,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Programa:",
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
                              widget.planeacion.nombrePrograma,
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
                              "Competencia:",
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
                              widget.planeacion.nombreCompetencia,
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
                              "Resultado de aprendizaje:",
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
                              widget.planeacion.resultadoAprendizaje,
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
                              "Trabajo Directo: ${widget.planeacion.duracionPrensencial} Horas.",
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
                              "Trabajo Autónomo: ${widget.planeacion.duracionVirtual} Horas.",
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
                              "Duración Total: ${widget.planeacion.duracionTotal} Horas.",
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
                              "Horas Recomendadas: ${widget.planeacion.horasRecomendadas} Horas.",
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
                              "Días Recomendados: ${widget.planeacion.diasRecomendados} Días.",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Calibri-Bold',
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: defaultPadding,),
                            Text(
                              "Créditos: ${widget.planeacion.creditos} Créditos.",
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
                          ],
                        ),
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
                          icon: const Icon(Icons.remove_red_eye,
                              size: 25,
                              color: primaryColor), // Icono de ver más
                          onPressed: () {
                            // Acción al presionar el botón de ver más
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PlaneacionView()));
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
