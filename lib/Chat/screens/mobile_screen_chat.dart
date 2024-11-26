import 'package:flutter/material.dart';
import 'package:horarios_cba/Chat/screens/buscador_screen_chat.dart';
import 'package:horarios_cba/Chat/WidgetsChat/contacts_list.dart';
import 'package:horarios_cba/Models/mensajeModel.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';


// Screen del chat para movil
class MobileScreenChat extends StatefulWidget {
  // Variable para recibir el usuario autenticado
  final UsuarioModel usuarioAutenticado;

  // Constructor requiriendo el usuario autenticado
  const MobileScreenChat({super.key, required this.usuarioAutenticado});

  @override
  State<MobileScreenChat> createState() => _MobileScreenChatState();
}

class _MobileScreenChatState extends State<MobileScreenChat> {
  // Lista de contactos
  List<UsuarioModel> contactos = [];

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
            usuario.id != widget.usuarioAutenticado.id &&
            usuario
                .estado && // Asegúrate de que el usuario autenticado no aparezca
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
      });
    }
  }

  // Cuerpo de la pantalla
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Encabezado del chat
        appBar: AppBar(
          // Regresa a la pantalla anterior
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
          ),
          backgroundColor: background1,
          elevation: 0,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                // Coloca aquí tu imagen de logo
                child: Image.asset('assets/img/logo.png'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              const Text(
                'CBA Mosquera',
                style: TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            // Botón para ir al buscador de contactos
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuscadorScreenChat(
                                usuarioAutenticado: widget.usuarioAutenticado,
                              )));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                )),
          ],
        ),
        // Lista de contactos
        body: ContactsList(
          usuarioAutenticado: widget.usuarioAutenticado,
          contactos: contactos,
        ),
      ),
    );
  }
}
