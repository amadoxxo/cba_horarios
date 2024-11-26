// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:horarios_cba/constantsDesign.dart';

import 'package:widget_zoom/widget_zoom.dart';

// Clase MyMessageCard, que representa una tarjeta de mensaje recibido.
class MyMessageCard extends StatefulWidget {
  // Propiedades
  final String message;
  final String date;
  final String dateMark;
  final bool imagen;

  // Contructor requiriendo las propiedades
  const MyMessageCard(
      {super.key,
      required this.message,
      required this.date,
      required this.dateMark,
      required this.imagen});

  @override
  State<MyMessageCard> createState() => _MyMessageCardState();
}

class _MyMessageCardState extends State<MyMessageCard> {
  // Diseño de la tarjeta de mensaje enviado
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: background1,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              // Contenido de la tarjeta
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: widget.imagen // Verifica si el mensaje es una imagen
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      // Zoom de la imagen
                      child: WidgetZoom(
                        heroAnimationTag: widget.message,
                        zoomWidget: Image.network(
                          widget.message,
                          fit: BoxFit.fill, // Ajuste de la imagen
                          width: 200,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) {
                            // Error al cargar la imagen
                            return Text(
                              "Error al cargar la imagen.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                    // Contenido de la tarjeta si no es una imagen
                    : Text(
                        widget.message,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
              ),
              // Fecha de enviado y verificador si el mensaje fue leido
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      formatHora(widget.date),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 20,
                      color: widget.dateMark != "" ? primaryColor : Colors.grey, // Verifica si el mensaje fue leido
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
