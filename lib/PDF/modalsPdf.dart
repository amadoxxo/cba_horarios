// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:horarios_cba/constantsDesign.dart';

/// Muestra un diálogo de alerta que avisa al usuario que no hay registros para elaborar el reporte.
///
/// El diálogo contiene un título, un mensaje, una imagen y un botón de aceptar.
/// Si el usuario hace clic en el botón de aceptar, se cierra el diálogo.
///
/// Parámetros:
///
///   - `context` (BuildContext): El contexto de la aplicación.
void noHayPDFModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // Título del diálogo
        title: const Text(
          "¡No hay registros para elaborar el reporte!",
          textAlign: TextAlign.center,
        ),
        // Contenido del diálogo
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Mensaje informativo para el usuario
            const Text(
              "Por favor, elija los datos para proceder con la construcción del reporte.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            // Muestra una imagen circular del logo de la aplicación
            ClipOval(
              child: Container(
                width: 100, // Ajusta el tamaño según sea necesario
                height: 100, // Ajusta el tamaño según sea necesario
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                child: Image.asset(
                  "assets/img/logo.png",
                  fit: BoxFit.cover, // Ajusta la imagen al contenedor
                ),
              ),
            ),
          ],
        ),
        // Botones de acción dentro del diálogo
        actions: <Widget>[
          OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                // Construye un botón con los estilos de diseño especificados
                child: buildButton("Aceptar", () {
                  // Cierra el diálogo cuando se hace clic en el botón de aceptar
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
        ],
      );
    },
  );
}


