// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:horarios_cba/Home/conceptoCard.dart';
import 'package:horarios_cba/Home/conceptoList.dart';
import 'package:horarios_cba/constantsDesign.dart';

// Clase ConceptoSection, que representa la sección de conceptos.
class ConceptoSection extends StatelessWidget {
  ConceptoSection({super.key});

  // Controlador del scroll.
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Contendedor de la sección de conceptos
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Conceptos Principales",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Calibri-Bold',
                shadows: [
                  Shadow(
                    color: Colors.black
                        .withOpacity(0.5), // Color y opacidad de la sombra
                    offset: const Offset(2,
                        2), // Desplazamiento de la sombra (horizontal, vertical)
                    blurRadius: 3, // Radio de desenfoque de la sombra
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        // Lista de tarjetas de conceptos.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children: List.generate(conceptoList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: defaultPadding),
                      child: ConceptoCard(concepto: conceptoList[index]),
                    );
                  }),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
