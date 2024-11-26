import 'package:flutter/material.dart';
import 'package:horarios_cba/Chat/WidgetsChat/web_profile_bar.dart';
import 'package:horarios_cba/Models/mensajeModel.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';


// Lista de contactos para la web.
class ContactsListWeb extends StatefulWidget {
  // propiedades para poder generar la conversación
  final UsuarioModel usuarioAutenticado;
  final List<UsuarioModel> contactos;
  final Function(UsuarioModel) onUsuarioSeleccionado; // Define el callback

  // constructor requiriendo el usuario autenticado, la lista de contactos y el callback para generar la conversación
  const ContactsListWeb({
    super.key,
    required this.usuarioAutenticado,
    required this.contactos,
    required this.onUsuarioSeleccionado,
  });

  @override
  State<ContactsListWeb> createState() => _ContactsListWebState();
}

class _ContactsListWebState extends State<ContactsListWeb> {
  // lista de mensajes
  List<MensajeModel> mensajes = [];
  // variable para controlar el estado de carga
  bool isLoading = true;

  // Controlador para manejar el texto del buscador
  TextEditingController searchController = TextEditingController();
  // Lista filtrada de contactos
  List<UsuarioModel> contactosFiltrados = [];

  @override
  void initState() {
    super.initState();
    // Cargar mensajes inicialmente.
    cargarMensajes();
    // Actualizar periódicamente.
    actualizarMensajesPeriodicamente();
  }

  // Cargar los mensajes.
  Future<void> cargarMensajes() async {
    // recibir los nuevos mensajes obtenidos de la API
    try {
      List<MensajeModel> nuevosMensajes = await getMensajes();
      if (mounted) {
        setState(() {
          mensajes = nuevosMensajes;
          isLoading = false;
          // Inicializar la lista de contactos filtrados solo si no hay búsqueda activa
          if (searchController.text.isEmpty) {
            contactosFiltrados = widget.contactos;
          }
        });
      }
      // Manejar error si es necesario
    } catch (error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      // Manejar error si es necesario
    }
  }

  // Actualizar los mensajes periódicamente en un intervalo de tiempo.
  void actualizarMensajesPeriodicamente() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 1));
      cargarMensajes();
    }
  }

  // Método para filtrar contactos según el texto ingresado
  void filtrarContactos(String query) {
    List<UsuarioModel> contactosFiltradosTemp =
        widget.contactos.where((contacto) {
      String nombreCompleto =
          "${contacto.nombres} ${contacto.apellidos}".toLowerCase();
      return nombreCompleto.contains(query.toLowerCase());
    }).toList();

    setState(() {
      contactosFiltrados = contactosFiltradosTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Si el estado de carga es verdadero, mostrar un indicador de carga.
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Si el estado de carga es falso, mostrar la lista de contactos.
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado en la parte superior izquierda del inicio del chat en la web
            WebProfileBar(usuarioAutenticado: widget.usuarioAutenticado),
            // Buscar contactos
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: background1,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.search, size: 20),
                  ),
                  hintStyle: const TextStyle(fontSize: 14),
                  hintText: 'Buscar o iniciar una nueva conversación',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
                style: const TextStyle(color: Colors.black),
                // Evento onChanged para actualizar la búsqueda en tiempo real
                onChanged: (value) {
                  filtrarContactos(value);
                },
                // Evento onSubmitted para manejar el envío del texto
                onSubmitted: (value) {
                  filtrarContactos(value);
                },
              ),
            ),
            // Lista de contactos
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: contactosFiltrados.length,
                itemBuilder: (context, index) {
                  // asigna el contacto de la lista filtrada
                  UsuarioModel contacto = contactosFiltrados[index];
                  // Obtener el último mensaje de la conversación entre el usuario autenticado y el contacto
                  MensajeModel? ultimoMensaje = mensajes.lastWhere(
                    (mensaje) =>
                        (mensaje.usuarioReceptor ==
                                widget.usuarioAutenticado.id &&
                            mensaje.usuarioEmisor == contacto.id &&
                            !mensaje.eliminarReceptor) ||
                        (mensaje.usuarioEmisor ==
                                widget.usuarioAutenticado.id &&
                            mensaje.usuarioReceptor == contacto.id &&
                            !mensaje.eliminarEmisor),
                    orElse: () => MensajeModel(
                      id: 0,
                      usuarioReceptor: 0,
                      usuarioEmisor: 0,
                      contenido: '',
                      fechaEnviado: '',
                      fechaLeido: '',
                      imagen: false,
                      tipo: '',
                      eliminarEmisor: false,
                      eliminarReceptor: false,
                    ),
                  );

                  // Tarjeta del contacto
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Seleccionar el contacto para iniciar una conversación
                          setState(() {
                            widget.onUsuarioSeleccionado(contacto);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          // Nombre del contacto
                          child: ListTile(
                            title: Text(
                              "${contacto.nombres} ${contacto.apellidos}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            // Ultimo mensaje de la conversación
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                ultimoMensaje
                                        .imagen // Verificar si el último mensaje es una imagen
                                    ? "Imagen"
                                    : ultimoMensaje.contenido,
                                style: ultimoMensaje.fechaLeido == "" &&
                                        ultimoMensaje.usuarioReceptor ==
                                            widget.usuarioAutenticado
                                                .id // Verificar si el último mensaje fue leido
                                    ? const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)
                                    : const TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            // Imagen del contacto
                            leading: Stack(
                              children: [
                                // Condicional para mostrar la imagen del contacto
                                if (contacto.foto != '')
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(contacto.foto),
                                    radius: 30,
                                  )
                                // Si no hay imagen, mostrar un avatar de usuario
                                else
                                  CircleAvatar(
                                    backgroundColor: primaryColor,
                                    radius: 20,
                                    child: Text(
                                      contacto.nombres[0].toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                // Verificar si el contacto se encuentra en línea
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: contacto.enLinea
                                          ? primaryColor
                                          : Colors.grey,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 1.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Hora del último mensaje
                            trailing: Text(
                              formatHora(ultimoMensaje.fechaEnviado!),
                              style: ultimoMensaje.fechaLeido == "" &&
                                      ultimoMensaje.usuarioReceptor ==
                                          widget.usuarioAutenticado.id
                                  ? const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)
                                  : const TextStyle(
                                      color: Colors.grey, fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                      const Divider(color: Colors.grey, indent: 85),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
