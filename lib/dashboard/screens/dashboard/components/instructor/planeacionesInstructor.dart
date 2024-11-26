// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:horarios_cba/dashboard/listas/planeaciones.dart';
import 'package:horarios_cba/dashboard/screens/dashboard/components/instructor/planeacionCardInstructor.dart';
import 'package:horarios_cba/constantsDesign.dart';

// Vista que muestra las tarjetas de planeaciones, adaptándose a diferentes dispositivos.
class PlaneacionesInstructor extends StatelessWidget {
  PlaneacionesInstructor({
    super.key,
  });

  // Controlador del scroll.
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Encabezado de las tarjetas de planeaciones
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Planeaciones Pedagógicas",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontFamily: 'Calibri-Bold'),
            ),
          ],
        ),
        // Espacio adicional antes del listado de tarjetas de planeaciones
        const SizedBox(height: defaultPadding),
        // Contenedor que muestra las tarjetas de planeaciones
        SizedBox(
          height: 600,
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(children: List.generate(listaPlaneaciones.length, (index){
                return Padding(
                  padding: const EdgeInsets.only(right: defaultPadding),
                  child: PlaneacionCardInstructor(
                    planeacion: listaPlaneaciones[index],
                  ),
                );
              }),),
            ),
          ),
        ),
      ],
    );
  }
}
