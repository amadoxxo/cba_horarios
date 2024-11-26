// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:horarios_cba/Chat/screens/web_chat_screen.dart';
import 'package:horarios_cba/Chat/WidgetsChat/contacts_list_web.dart';
import 'package:horarios_cba/Models/mensajeModel.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';


// Screen del chat para la web
class WebLayoutChat extends StatefulWidget {
  // Variable para recibir el usuario autenticado
  final UsuarioModel usuarioAutenticado;

  // Constructor requiriendo el usuario autenticado
  const WebLayoutChat({super.key, required this.usuarioAutenticado});

  @override
  State<WebLayoutChat> createState() => _WebLayoutChatState();
}

class _WebLayoutChatState extends State<WebLayoutChat> {
  // Lista de contactos
  List<UsuarioModel> contactos = [];

  // Variable para el usuario receptor
  UsuarioModel? usuarioReceptor;

  @override
  void initState() {
    super.initState();
    // Cargar contactos iniciales
    llamarContactos();
    // Actualizar contactos periodicamente
    actualizarcontactosPeriodicamente();
  }

  // Función para actualizar contactos periodicamente en un intervalo de tiempo
  void actualizarcontactosPeriodicamente() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 1));
      llamarContactos();
    }
  }

  // Función para llamar contactos
  Future<void> llamarContactos() async {
    // Obtener los contactos y los mensajes
    List<UsuarioModel> usuarios = await getUsuarios();
    List<MensajeModel> mensajes = await getMensajes();

    // Filtra los usuarios con los que se ha tenido una conversación, excluyendo al usuario autenticado
    List<UsuarioModel> contactosConConversacion = usuarios
        .where((usuario) =>
            usuario.id !=
                widget.usuarioAutenticado
                    .id && usuario.estado && // Asegúrate de que el usuario autenticado no aparezca
            mensajes.any((mensaje) =>
                (mensaje.usuarioReceptor == widget.usuarioAutenticado.id &&
                    mensaje.usuarioEmisor == usuario.id &&
                    !mensaje.eliminarReceptor) ||
                (mensaje.usuarioEmisor == widget.usuarioAutenticado.id &&
                    mensaje.usuarioReceptor == usuario.id &&
                    !mensaje.eliminarEmisor)))
        .toList();

    // Elimina duplicados asegurando que cada usuario aparezca solo una vez
    if (mounted) {
      setState(() {
        contactos = contactosConConversacion.toSet().toList();
        if (contactos.isEmpty) {
          usuarioReceptor = null;
        }
      });
    }
  }

  // Cuerpo de la pantalla
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Lista de contactos y encabezado del chat en la web ubicado en la parte izquierda
            ContactsListWeb(
              onUsuarioSeleccionado: (UsuarioModel usuario) {
                // Actualiza el usuario receptor con el usuario seleccionado en el callback para inciar una conversación
                setState(() {
                  usuarioReceptor = usuario;
                });
              },
              usuarioAutenticado: widget.usuarioAutenticado,
              contactos: contactos,
            ),
            // Pantalla de chat en la web si hay un usuario receptor
            if (usuarioReceptor != null)
              WebChatScreen(
                usuario: usuarioReceptor!,
                usuarioAutenticado: widget.usuarioAutenticado,
              )
            // Pantalla de bienvenida en la web si no hay un usuario receptor
            else
              Container(
                color: background1,
                width: MediaQuery.of(context).size.width * 0.75,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        width: MediaQuery.of(context).size.width *
                            0.2, // 20% del ancho de la pantalla
                        height: MediaQuery.of(context).size.width *
                            0.2, // 20% del ancho de la pantalla
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        // Coloca aquí tu imagen de logo
                        child: Image.asset('assets/img/logo.png'),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Bienvenido al chat CBA Mosquera',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
