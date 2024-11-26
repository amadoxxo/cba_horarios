// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:horarios_cba/Chatbot/Messages.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/source.dart';
import 'package:http/http.dart' as http; // Importa la librería http
import 'dart:convert'; // Importa para manejar JSON

// Clase ChatBot, que representa el widget de chatbot.
class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  FocusNode focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  // Lista de mensajes en la conversación
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
  }

  // Contenido de la pantalla de chatbot
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          foregroundColor: Colors.grey,
          // Botón de retroceso en la barra de navegación
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
              )),
          // Título de la aplicación en la barra de navegación
          title: Text(
            "Asistente virtual CBA",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Column(
          children: [
            // Pantalla de mensajes
            Expanded(child: MessagesScreen(messages: messages)),
            // Entrada de texto y botón de enviar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Card(
                        margin: const EdgeInsets.only(
                          left: 2,
                          right: 2,
                          bottom: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextFormField(
                          cursorColor: primaryColor,
                          controller: _controller,
                          focusNode: focusNode,
                          style: const TextStyle(color: Colors.black),
                          textAlignVertical: TextAlignVertical.top,
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          minLines: 1,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            border: InputBorder.none,
                            hintText:
                                "Escriba 'Hola' para comenzar la conversación...",
                            contentPadding: EdgeInsets.all(5),
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          onFieldSubmitted: (value) {
                            sendMessage(value);
                            _controller.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  // Botón de enviar mensaje
                  IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: primaryColor,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para enviar un mensaje
  sendMessage(String text) async {
    if (text.isEmpty) {
      // Mensaje vacío, no se hace nada
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se puede enviar un mensaje vacío.'),
        ),
      );
    } else {
      // Agrega el mensaje del usuario a la lista de mensajes
      setState(() {
        addMessage(
          {'message': text, 'isUserMessage': true},
        );
      });

      // Realizar la solicitud HTTP a la API de Django
      final response = await http.post(
        Uri.parse('$sourceApi/api/chatbot_response/'), // Cambia esto a tu URL
        headers: {
          'Content-Type':
              'application/json; charset=utf-8', // Asegúrate de especificar UTF-8
        },
        body: json.encode({
          'message': text, // Envía el mensaje al backend
        }),
      );

      if (response.statusCode == 200) {
        // Si el servidor devuelve una respuesta OK, parsea el JSON
        String responseBodyUtf8 = utf8.decode(response.bodyBytes);

        // Asegúrate de que responseData sea un Map
        Map<String, dynamic> responseData = jsonDecode(responseBodyUtf8);
        final botResponse = responseData['response'] ??
            'Error en la respuesta del servidor.'; // Asegúrate de que el backend devuelva esto

        // Agrega el mensaje del bot a la lista de mensajes
        setState(() {
          addMessage(
            {'message': botResponse, 'isUserMessage': false},
          );
        });
      } else {
        // Si el servidor no devuelve una respuesta OK, muestra un error
        setState(() {
          addMessage(
            {
              'message': 'Error en la respuesta del servidor.',
              'isUserMessage': false
            },
          );
        });
      }
    }
  }

// Función para agregar un mensaje a la lista de mensajes
  addMessage(Map<String, dynamic> message) {
    messages.add(message);
  }
}
