// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:flutter/material.dart';
import 'package:horarios_cba/Chat/WidgetsChat/my_message_card.dart';
import 'package:horarios_cba/Chat/WidgetsChat/sender_message_card.dart';
import 'package:horarios_cba/Models/mensajeModel.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/source.dart';

import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:image/image.dart' as im;

// Pantalla de chat movil
class MobileChatScreen extends StatefulWidget {
  final UsuarioModel usuario; // Información del usuario del chat
  final UsuarioModel
      usuarioAutenticado; // Información del usuario que inició sesión
  // Constructor requiriendo los parámetros
  const MobileChatScreen(
      {super.key, required this.usuario, required this.usuarioAutenticado});

  @override
  State<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends State<MobileChatScreen> {
  FocusNode focusNode = FocusNode();
  WebSocketChannel?
      channel; // Canal WebSocket para la comunicación en tiempo real
  List<MensajeModel> listMsg = []; // Lista de mensajes en el chat
  final TextEditingController _msgController =
      TextEditingController(); // Controlador para el campo de entrada de mensajes

  final ScrollController _scrollController =
      ScrollController(); // Controlador para el desplazamiento
  bool _isChannelClosed = false; // Indica si el canal ha sido cerrado
  bool _isInitialScroll = true; // Indica si se ha iniciado el desplazamiento
  bool show = false; // Indica si se muestra la barra de emojis

  /// Cadena que almacena el nombre del archivo seleccionado.
  String selectFile = '';

  /// Byte array que almacena la imagen seleccionada.
  Uint8List? selectedImagenInBytes;

  @override
  void initState() {
    super.initState();
    // Iniciar el canal WebSocket
    connectSocket();
    // Cargar la conversación
    loadConversation();
    // Marcar la conversación como leida
    markAsRead();
    // Actualizar las conversaciones periodicamente
    actualizarconversacionesPeriodicamente();
    // Desplaza la lista hasta el final después de que se construya el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(isInitial: true);
    });
    // Escucha el nodo de enfoque
    focusNode.addListener(() {
      // Si el nodo de enfoque tiene el foco
      if (focusNode.hasFocus) {
        // Cierra la barra de emojis
        setState(() {
          show = false;
        });
      }
    });
  }

  // Actualiza la conversación periodicamente en un intervalo de tiempo
  void actualizarconversacionesPeriodicamente() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        loadConversation();
      }
    }
  }

  // Función para desplazar la lista de la conversación hasta el final
  void _scrollToBottom({bool isInitial = false}) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        if (isInitial) {
          setState(() {
            _isInitialScroll = false;
          });
        }
      }
    });
  }

  // Función para conectar el canal WebSocket
  void connectSocket() {
    // Crear el canal WebSocket con los usuarios que tendran la conversación
    int usuarioEmisor = widget.usuarioAutenticado.id;
    int usuarioReceptor = widget.usuario.id;

    channel = WebSocketChannel.connect(
      Uri.parse('$socketUrl/ws/chat/$usuarioEmisor/$usuarioReceptor/'),
    );

    // Escucha los eventos del canal WebSocket
    channel!.stream.listen((data) {
      final jsonData = jsonDecode(data);
      final action = jsonData['action'];

      switch (action) {
        // Cada vez que se recibe un nuevo mensaje
        case 'chat_message':
          final mensaje = MensajeModel.fromJson(jsonData['message']);
          // Solo agrega el mensaje si el emisor no es el usuario autenticado
          if (mensaje.usuarioEmisor != widget.usuarioAutenticado.id) {
            setState(() {
              // Agregar el nuevo mensaje
              listMsg.add(mensaje);
              // Marcar la conversación como leida
              markAsRead();
              // Desplazar la lista
              _scrollToBottom();
            });
          }

          break;

        // Cada vez que recibe la conversación previa
        case 'load_conversation':
          List<dynamic> mensajes = jsonData['messages'];
          setState(() {
            // Llenar la lista de mensajes
            listMsg =
                mensajes.map((msg) => MensajeModel.fromJson(msg)).toList();
            // Si no se ha hecho el desplazamiento inicial de la lista
            if (_isInitialScroll) {
              _scrollToBottom(
                  isInitial:
                      true); // Solo inicializa el scroll si es la primera carga
            }
          });

          break;

        // Cada vez que se borra una conversación
        case 'conversation_deleted':
          setState(() {
            // Limpia la lista de mensajes
            listMsg.clear();
          });
          break;

        // Cada vez que se marcan los mensajes como leidos
        case 'messages_marked_as_read':
          setState(() {
            // Traer los ids de los mensajes marcados como leidos
            for (var id in jsonData['ids']) {
              // asignar la fecha de lectura a cada mensaje
              var msg = listMsg.firstWhere((msg) => msg.id == id);
              msg.fechaLeido = jsonData['fechaLeido'];
            }
          });
          break;
      }
      // Si se ha cerrado el canal
    }, onDone: () {
      try {
        // Cerrar el canal WebSocket
        if (mounted) {
          setState(() {
            _isChannelClosed = true;
          });
        }
        // Si hay errores de WebSocket
      } catch (e) {
        return;
      }
    });
  }

  // Función para cargar la conversación previa
  void loadConversation() {
    // Si se ha cerrado el canal
    if (_isChannelClosed) return;

    // Crear el mensaje para cargar la conversación
    final loadMessage = {
      'action': 'load_conversation',
      'usuarioEmisor': widget.usuarioAutenticado.id,
      'usuarioReceptor': widget.usuario.id,
      'usuarioActual': widget.usuarioAutenticado.id,
    };

    // Enviar el mensaje al WebSocket
    channel!.sink.add(jsonEncode(loadMessage));
  }

  // Función para enviar un nuevo mensaje
  void sendMessage(bool isImage) {
    // Crear una nueva instancia Mensaje Model con nuevo mensaje
    MensajeModel mensaje = MensajeModel(
      id: 0,
      usuarioEmisor: widget.usuarioAutenticado.id,
      usuarioReceptor: widget.usuario.id,
      fechaEnviado: DateTime.now().toString(),
      fechaLeido: '',
      imagen: isImage,
      contenido: _msgController.text,
      tipo: 'text',
      eliminarEmisor: false,
      eliminarReceptor: false,
    );

    // Anexar el nuevo mensaje
    listMsg.add(mensaje);
    setState(() {
      listMsg;
    });

    // Enviar el nuevo mensaje al Websocket
    if (!_isChannelClosed) {
      channel!.sink.add(jsonEncode({
        'action': 'send_message',
        'usuarioEmisor': mensaje.usuarioEmisor,
        'usuarioReceptor': mensaje.usuarioReceptor,
        'contenido': mensaje.contenido,
        'tipo': mensaje.tipo,
        'imagen': mensaje.imagen,
      }));
    }
  }

  // Función para borrar la conversación
  void deleteConversation() {
    if (_isChannelClosed) return;

    // Enviar la petición al Websocket para borrar la conversación entre el usuario emisor y el usuario receptor en el chat del usuario actual
    final deleteMessage = {
      'action': 'delete_conversation',
      'usuarioEmisor': widget.usuarioAutenticado.id,
      'usuarioReceptor': widget.usuario.id,
      'usuarioActual': widget.usuarioAutenticado.id,
    };

    channel!.sink.add(jsonEncode(deleteMessage));

    // Limpiar la lista de mensajes localmente
    setState(() {
      listMsg.clear();
    });
  }

  // Función para marcar todos los mensajes como leidos
  void markAsRead() {
    // Si se ha cerrado el canal
    if (_isChannelClosed) return;

    // Enviar la petición al Websocket para marcar como leidos los mensajes sin leer entre el usuario emisor y el usuario receptor
    final markAsReadMessage = {
      'action': 'mark_as_read',
      'usuarioEmisor': widget.usuario.id,
      'usuarioReceptor': widget.usuarioAutenticado.id,
    };

    channel!.sink.add(jsonEncode(markAsReadMessage));
  }

  // Función para seleccionar un archivo
  void _selectFile(BuildContext context, bool imagenFrom) async {
    // Abrir el selector de archivos o la galería del dispositivo
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (fileResult != null) {
      setState(() {
        // Obtener el nombre del archivo y los bytes de la imagen seleccionada
        selectFile = fileResult.files.first.name;
        selectedImagenInBytes = fileResult.files.first.bytes;
      });
    }

    try {
      // Cargar la imagen desde los bytes
      final image = im.decodeImage(selectedImagenInBytes!);

      // Verificar los casos y modificar la imagen según sea necesario
      im.Image resizedImage;
      if (image!.width > 800 && image.height > 600) {
        // Caso 1: La imagen es mayor en ambos anchos y altos
        resizedImage = im.copyResize(image, width: 800, height: 600);
      } else if (image.width > 800 && image.height <= 600) {
        // Caso 2: El ancho es mayor a 800 y el alto es menor a 600
        resizedImage = im.copyResize(image, width: 800);
      } else if (image.width <= 800 && image.height > 600) {
        // Caso 3: El ancho es menor que 800 y el alto es mayor a 600
        resizedImage = im.copyResize(image, height: 600);
      } else {
        // Caso por defecto
        resizedImage = image;
      }

      // Rotar la imagen (por ejemplo, 90 grados)
      im.Image rotatedImage = im.copyRotate(resizedImage,
          angle:
              UniversalPlatform.isIOS || UniversalPlatform.isAndroid ? 90 : 0);

      // Convertir la imagen rotada a bytes
      final rotatedImageBytes = Uint8List.fromList(im.encodeJpg(rotatedImage));

      // Comprimir la imagen redimensionada
      final compressedImage = await compressor.compress(
        ImageFileConfiguration(
          input: ImageFile(
            rawBytes: rotatedImageBytes,
            filePath: selectFile,
          ),
          config: const Configuration(
            outputType: ImageOutputType.webpThenJpg,
            useJpgPngNativeCompressor: false,
            quality: 50,
          ),
        ),
      );

      // Actualizar la imagen seleccionada con la imagen comprimida
      setState(() {
        selectedImagenInBytes = compressedImage.rawBytes;
      });

      // Si ya esta la imagen seleccionada se abre el visualizador para poderla enviar
      if (selectFile.isNotEmpty) {
        if (mounted) {
          visualizarImagen(context, selectedImagenInBytes!, selectFile);
        }
        // Si no hay imagen seleccionada se muestra un mensaje de error
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No se seleccionó ninguna imagen.'),
        ));
      }
      // Si hay un error en el proceso de selección de imagen, se muestra un mensaje de error
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No se seleccionó ninguna imagen.'),
      ));
    }
  }

  // Método para subir la imagen a Firebase Storage y obtener la URL
  Future<void> uploadFileAndSend(BuildContext context,
      Uint8List selectedImagenInBytes, String selectFile) async {
    // Obtener la URL de descarga de la imagen
    String imageUrl = '';
    try {
      // Declarar la variable para la tarea de subida a Firebase Storage
      firabase_storage.UploadTask uploadTask;

      // Crear una referencia en Firebase Storage para almacenar la imagen
      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('chat')
          .child('/$selectFile');

      // Definir los metadatos de la imagen, en este caso especificando el tipo de contenido
      final metadata =
          firabase_storage.SettableMetadata(contentType: 'image/webp');

      // Subir la imagen a Firebase Storage
      uploadTask = ref.putData(selectedImagenInBytes, metadata);

      // Esperar a que la subida se complete
      await uploadTask.whenComplete(() => null);
      // Obtener la URL de descarga de la imagen subida
      imageUrl = await ref.getDownloadURL();
      // Actualizar el controlador de texto con la URL de la imagen y enviar el mensaje
      setState(() {
        // Limpiar el controlador de texto
        _msgController.text = imageUrl;
        // Enviar el mensaje y notificar si el mensaje es una imagen
        sendMessage(true);
        // Limpiar el controlador de texto
        _msgController.clear();
        // Desplazar el scroll para que se vea el nuevo mensaje
        _scrollToBottom();
      });
    } catch (e) {
      // Manejar errores durante la subida mostrando un SnackBar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('A ocurrido un error al subir la imagen.'),
      ));
    }
  }

  @override
  void dispose() {
    // Liberar los recursos utilizados por el scroll controller
    _scrollController.dispose();
    // Cerrar el canal WebSocket si está abierto
    if (channel != null && !_isChannelClosed) {
      channel!.sink.close(1000); // Código 1000 indica una cierre normal
    }
    // Liberar los recursos utilizados por el controlador de mensajes
    _msgController.dispose();
    // Liberar los recursos utilizados por el nodo de enfoque
    focusNode.dispose();
    // Llamar al método dispose() de la clase padre para asegurar una correcta liberación de recursos
    super.dispose();
  }

  // Interfaz de usuario del chat
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Encabezado de la interfaz de usuario
        appBar: AppBar(
          // Botón de retroceso
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
          title: Row(
            children: [
              // Imagen del usuario
              Stack(
                children: [
                  // Si no hay una imagen de perfil, se muestra una imagen de usuario por defecto
                  if (widget.usuario.foto != "")
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.usuario.foto,
                      ),
                      radius: 20,
                    )
                  else
                    CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 20,
                      child: Text(
                        widget.usuario.nombres[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  // Widget que indica la disponibilidad del usuario si esta en linea o no
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: widget.usuario.enLinea == false
                            ? Colors.grey
                            : primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              // Nombre del usuario
              Flexible(
                child: Text(
                  '${widget.usuario.nombres} ${widget.usuario.apellidos}',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 14,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            // Botón para borrar la conversación
            IconButton(
              onPressed: () {
                borrarConversacion(context);
              },
              icon: const Icon(Icons.delete, color: Colors.grey),
            ),
          ],
        ),
        body: Stack(
          children: [
            // Imagen de fondo
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/img/fondoChat.webp",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Capa verde semitransparente
            Container(
              color: primaryColor.withOpacity(
                  0.5), // Ajusta el nivel de opacidad según sea necesario
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              children: [
                // Lista de mensajes
                Expanded(
                  child: listMsg.isEmpty
                      ? Container()
                      : ListView.builder(
                          controller:
                              _scrollController, // Controlador de desplazamiento
                          itemCount: listMsg.length,
                          itemBuilder: (context, index) {
                            final msg = listMsg[index];
                            // Verificar si el usuario emisor es el mismo que el usuario autenticado
                            // para mostrar el mensaje en el lado correspondiente
                            if (msg.usuarioEmisor ==
                                widget.usuarioAutenticado.id) {
                              return MyMessageCard(
                                message: msg.contenido,
                                date: msg.fechaEnviado.toString(),
                                dateMark: msg.fechaLeido.toString(),
                                imagen: msg.imagen,
                              );
                            } else {
                              return SenderMessageCard(
                                message: msg.contenido,
                                date: msg.fechaEnviado.toString(),
                                imagen: msg.imagen,
                              );
                            }
                          },
                        ),
                ),
                // Panel de escritura
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                    color: background1,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 15,
                            ),
                            // Input de escritura
                            child: TextField(
                              minLines: 1,
                              maxLines: null,
                              controller: _msgController, // Controlador de texto
                              focusNode: focusNode, // Controlador de foco
                              decoration: InputDecoration(
                                prefixIcon: show
                                    ? IconButton(
                                        onPressed: () {
                                          // Si el panel de emojis está abierto, solo lo cerramos
                                          setState(() {
                                            show = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_alt_outlined,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          // Si el panel de emojis está cerrado, cerramos el teclado y luego abrimos el panel
                                          setState(() {
                                            show = true;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.emoji_emotions_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                // Botón para adjuntar archivos
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _selectFile(context, true);
                                  },
                                  icon: const Icon(
                                    Icons.attach_file,
                                    color: Colors.grey,
                                  ),
                                ),
                                filled: true,
                                fillColor: background1,
                                hintText: 'Escribir un mensaje',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        // Botón para enviar el mensaje
                        IconButton(
                          onPressed: () {
                            // Verificar que el mensaje no este vacío
                            if (_msgController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'No se puede enviar un mensaje vacio.')),
                              );
                            } else {
                              // Enviar el mensaje y notificar si el mensaje es una imagen
                              sendMessage(false);
                              // Limpiar el campo de escritura
                              _msgController.clear();
                              // Desplazar el scroll para que se vea el nuevo mensaje
                              _scrollToBottom();
                            }
                          }, // Enviar mensaje al presionar el botón
                          icon: const Icon(
                            Icons.send,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Panel de emojis
                show
                    ? Container(
                        height: 265,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                          color: background1,
                        ),
                        child: emojiSelect(),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar el selector de emojis
  Widget emojiSelect() {
    return EmojiPicker(
      // Acción a realizar cuando se selecciona un emoji
      onEmojiSelected: (Category? category, Emoji emoji) {
        // Añadir el emoji seleccionado al texto del controlador de mensajes
        _msgController.text += emoji.emoji;
      },
      // config: const Config(
      //   columns: 7,
      //   indicatorColor: primaryColor,
      //   iconColorSelected: primaryColor,
      //   backspaceColor: primaryColor,
      // ),
    );
  }

  // Modal para mostrar la imagen que se va a enviar
  void visualizarImagen(BuildContext context, Uint8List imagen, String path) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          // Título del diálogo
          title: const Center(
              child: Text("Envio de imagen", textAlign: TextAlign.center)),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Contenedor con la imagen previsualizada que se va a enviar
              Flexible(
                child: Container(
                  width: 400, // Ajusta el tamaño según sea necesario
                  height: 400, // Ajusta el tamaño según sea necesario
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // Imagen previsualizada
                  child: Image.memory(
                    imagen,
                    fit: BoxFit.fill, // Ajusta la imagen al contenedor
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            OverflowBar(
              overflowAlignment: OverflowBarAlignment.center,
              alignment: MainAxisAlignment.center,
              children: [
                // Botón para cancelar la operación.
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Cancelar", () {
                    Navigator.pop(context);
                  }),
                ),
                // Botón para enviar la imagen.
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Enviar", () {
                    // Mostrar un SnackBar para indicar que la imagen se está cargando
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Cargando Imagen...'),
                    ));
                    // Cerrar el modal
                    Navigator.pop(context);
                    // Enviar la imagen
                    uploadFileAndSend(context, imagen, path);
                  }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Modal para confirmar la eliminación de una conversación
  void borrarConversacion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Título del diálogo
          title: const Center(
              child: Text(
            "¿Quiere eliminar esta conversación?",
            textAlign: TextAlign.center,
          )),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Mensaje informativo para el usuario
              const Text(
                "Al realizar esta operación no se podra recuperar la conversación.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              // Contenedor circular con la imagen del logo de la aplicación
              ClipOval(
                child: Container(
                  width: 100, // Ajusta el tamaño según sea necesario
                  height: 100, // Ajusta el tamaño según sea necesario
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                  // Muestra la imagen del logo en el contenedor.
                  child: Image.asset(
                    "assets/img/logo.png",
                    fit: BoxFit.cover, // Ajusta la imagen al contenedor
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            OverflowBar(
              overflowAlignment: OverflowBarAlignment.center,
              alignment: MainAxisAlignment.center,
              children: [
                // Botón para cancelar la operación.
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Cancelar", () {
                    Navigator.pop(context);
                  }),
                ),
                // Botón para eliminar la conversación.
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Eliminar", () {
                    Navigator.pop(context);
                    deleteConversation();
                  }),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
