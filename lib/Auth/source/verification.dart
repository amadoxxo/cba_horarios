// ENVIO DEL EMAIL FUTURE...

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../source.dart';

// Clase para el servicio de verificación
class VerificationService {
  // Uso de una funcion en django para el envio de los correos.
  Future djangoSendEmail(String toEmail, String confirmationCode, BuildContext context) async {
    String url = "";

    // URL de la API de Django para enviar el código de confirmación
    url = "$sourceApi/api/send_code/";

    // Encabezados para la solicitud HTTP
    final headers = {'Content-Type': 'application/json'};

    // Cuerpo de la solicitud en formato JSON
    final body = jsonEncode({
      'subject': 'Código de confirmación',
      'message': confirmationCode,
      'recipient_list': toEmail,
    });

    // Envío de la solicitud HTTP POST
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // Manejo de la respuesta de la solicitud
    if (response.statusCode == 200) {
      // Muestra un mensaje de éxito si el correo electrónico fue enviado correctamente
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Correo electrónico enviado exitosamente',
          ),
        )
      );
    } else {
      // Muestra un mensaje de error si hubo un problema al enviar el correo electrónico
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error al enviar correo electrónico: ${response.body}',
          ),
        )
      );
    }
  }
}
