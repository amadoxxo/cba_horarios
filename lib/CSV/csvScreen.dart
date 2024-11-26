// ignore_for_file: use_build_context_synchronously, file_names, prefer_final_fields

import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:horarios_cba/dashboard/controllers/menu_app_controller.dart';
import 'package:horarios_cba/dashboard/screens/main/main_screen_administrador.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/responsive.dart';
import 'package:horarios_cba/source.dart';

import 'package:provider/provider.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

/// Widget que representa la pantalla de carga de usuarios desde un archivo CSV.
class UploadUsersCSV extends StatefulWidget {
  final UsuarioModel usuarioAutenticado;
  const UploadUsersCSV({super.key, required this.usuarioAutenticado});

  @override
  State<UploadUsersCSV> createState() => _UploadUsersCSVState();
}

class _UploadUsersCSVState extends State<UploadUsersCSV> {
  // Lista para almacenar los usuarios con datos completos
  List<UsuarioModel> _usuariosCompletos = [];
  // Lista para almacenar los usuarios con datos incompletos
  List<UsuarioModel> _usuariosIncompletos = [];
  // Lista para almacenar los usuarios registrados en el servidor
  List<UsuarioModel> _usuariosRegistrados = [];
  // Lista para almacenar los usuarios con registro fallido en el servidor
  List<UsuarioModel> _usuariosFallidos = [];

  // Función para cargar los datos de los usuarios desde un archivo CSV
  Future<void> _loadCSV() async {
    try {
      // Abre un cuadro de diálogo para seleccionar un archivo CSV
      final result = await FilePicker.platform.pickFiles(
        type: FileType
            .custom, // Permite seleccionar archivos de tipo personalizado
        allowedExtensions: [
          'csv'
        ], // Solo se permiten archivos con extensión CSV
      );

      // Verifica si se ha seleccionado un archivo
      if (result != null) {
        final bytes = result
            .files.single.bytes; // Obtiene los bytes del archivo seleccionado
        if (bytes != null) {
          // Convierte los bytes a una cadena UTF-8
          final csvString = utf8.decode(bytes);
          // Convierte la cadena CSV en una lista de listas utilizando un delimitador específico
          List<List<dynamic>> csvTable = const CsvToListConverter()
              .convert(csvString, fieldDelimiter: ';', eol: '\n');

          // Listas para almacenar usuarios completos e incompletos
          List<UsuarioModel> completos = [];
          List<UsuarioModel> incompletos = [];

          // Itera sobre cada fila del CSV, omitiendo la primera fila (encabezados)
          for (var row in csvTable.skip(1)) {
            // Comprueba si la fila tiene menos de 6 columnas o si hay campos vacíos
            if (row.length < 6 ||
                row.any((element) =>
                    element == null || element.toString().trim().isEmpty)) {
              // Si la fila es incompleta, agrega el usuario a la lista de incompletos
              incompletos.add(UsuarioModel.fromCsv(row));
            } else {
              // Si la fila está completa, agrega el usuario a la lista de completos
              completos.add(UsuarioModel.fromCsv(row));
            }
          }

          // Actualiza el estado con las listas de usuarios completos e incompletos
          setState(() {
            _usuariosCompletos = completos;
            _usuariosIncompletos = incompletos;
          });
        } else {
          // Muestra un mensaje de error si no se pueden leer los bytes del archivo
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('No se puede leer el archivo seleccionado.')),
          );
        }
      } else {
        // Muestra un mensaje de advertencia si no se seleccionó ningún archivo
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se seleccionó ningún archivo.')),
        );
      }
    } catch (e) {
      // Captura cualquier error y muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar él archivo CSV: $e')),
      );
    }
  }

  // Encabezado de la tabla de usuarios
  Widget _buildTableHeader() {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 1400,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Responsive.isMobile(context)
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 200,
                      child: Text('Nombres',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 200,
                      child: Text('Apellidos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 200,
                      child: Text('Teléfono Celular',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 200,
                      child: Text('Tipo Documento',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 200,
                      child: Text('No Documento',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 200,
                      child: Text('Correo Electrónico',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                    Container(
                      width: 200,
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text('Nombres',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white))),
                  const Expanded(
                      flex: 2,
                      child: Text('Apellidos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white))),
                  const Expanded(
                      flex: 2,
                      child: Text('Teléfono Celular',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white))),
                  const Expanded(
                      flex: 2,
                      child: Text('Tipo Documento',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white))),
                  const Expanded(
                      flex: 2,
                      child: Text('No Documento',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white))),
                  const Expanded(
                      flex: 2,
                      child: Text('Correo Electrónico',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white))),
                  Expanded(flex: 2, child: Container()),
                ],
              ),
      ),
    );
  }

  // Fila con la información del usuario
  Widget _buildUserRow(UsuarioModel usuario) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Responsive.isMobile(context)
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      usuario.nombres,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      usuario.apellidos,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      usuario.telefonoCelular,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      usuario.tipoDocumento,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      usuario.numeroDocumento,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        usuario.correoElectronico,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  // Botón para eliminar el usuario
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Eliminar usuario
                          deleteUser(usuario);
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(primaryColor)),
                        child: const Text("Eliminar"),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  usuario.nombres,
                  style: const TextStyle(color: Colors.black),
                )),
                Expanded(
                    child: Text(
                  usuario.apellidos,
                  style: const TextStyle(color: Colors.black),
                )),
                Expanded(
                    child: Text(
                  usuario.telefonoCelular,
                  style: const TextStyle(color: Colors.black),
                )),
                Expanded(
                    child: Text(
                  usuario.tipoDocumento,
                  style: const TextStyle(color: Colors.black),
                )),
                Expanded(
                    child: Text(
                  usuario.numeroDocumento,
                  style: const TextStyle(color: Colors.black),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    usuario.correoElectronico,
                    style: const TextStyle(color: Colors.black),
                  ),
                )),
                // Botón para eliminar el usuario
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Eliminar usuario
                        deleteUser(usuario);
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(primaryColor)),
                      child: const Text("Eliminar"),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // Función para eliminar un usuario sea de la lista de completos o incompletos
  deleteUser(UsuarioModel usuario) {
    setState(() {
      _usuariosCompletos.remove(usuario);
      _usuariosIncompletos.remove(usuario);
    });
  }

  // Función para subir los usuarios en masa a la base de datos
  Future addUser(List<UsuarioModel> usuarios) async {
    // Muestra un mensaje de que la operación está en progreso
    modalCargando();

    // Itera sobre la lista de usuarios a agregar
    for (var usuario in usuarios) {
      // Obtiene la lista actual de usuarios registrados
      final users = await getUsuarios();

      // Verifica si el usuario ya está registrado, comprobando el número de documento o el correo electrónico
      final isAdded = users.any((user) =>
          user.numeroDocumento == usuario.numeroDocumento ||
          user.correoElectronico == usuario.correoElectronico);

      // Define la URL para la API donde se agregarán los usuarios
      String url = '$sourceApi/api/usuarios/';
      final headers = {
        'Content-Type': 'application/json'
      }; // Especifica el tipo de contenido

      // Crea el cuerpo de la solicitud en formato JSON
      final body = jsonEncode({
        'nombres': usuario.nombres.trim(),
        'apellidos': usuario.apellidos.trim(),
        'tipoDocumento': usuario.tipoDocumento.trim(),
        'numeroDocumento': usuario.numeroDocumento.trim(),
        'correoElectronico': usuario.correoElectronico.trim(),
        'telefonoCelular': usuario.telefonoCelular.trimRight(),
        'rol': '',
      });

      // Si el usuario no está registrado, intenta agregarlo a la base de datos
      if (!isAdded) {
        final response = await http.post(
          Uri.parse(url), // Realiza una solicitud POST a la URL especificada
          headers: headers,
          body: body,
        );

        // Verifica la respuesta del servidor
        if (response.statusCode == 201) {
          // Si la respuesta es 201 (Creado), agrega el usuario a la lista de registrados
          _usuariosRegistrados.add(usuario);
        } else {
          // Si la respuesta no es 201, agrega el usuario a la lista de fallidos
          _usuariosFallidos.add(usuario);
        }
      } else {
        // Si el usuario ya estaba registrado, también lo agrega a la lista de fallidos
        _usuariosFallidos.add(usuario);
      }
    }

    // Mensaje final después de intentar agregar todos los usuarios
    if (_usuariosRegistrados.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Se han registrado ${_usuariosRegistrados.length} usuarios correctamente.'),
        ),
      );

      if (mounted) {
        Navigator.pop(context);
        // Si el widget está montado, navega a la pantalla principal del administrador
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                    create: (context) => MenuAppController()),
              ],
              child: MainScreenAdministrador(
                usuarioAutenticado: widget.usuarioAutenticado,
              ),
            ),
          ),
        );
      }
    }

    // Si hay usuarios que no se pudieron registrar, muestra un mensaje de error
    if (_usuariosFallidos.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${_usuariosFallidos.length} usuarios no se pudieron registrar, ya sea porque ya están registrados o hubo un error.'),
        ),
      );
    }
  }

  // Función para limpiar la lista de usuarios y liberar recursos de la interfaz
  @override
  void dispose() {
    super.dispose();
    _usuariosCompletos.clear();
    _usuariosIncompletos.clear();
    _usuariosCompletos.clear();
    _usuariosFallidos.clear();
  }

  // Cuerpo de la pantalla
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Fondo con imagen
            Image.asset(
              "assets/img/fondoCSV.webp",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Capa verde semitransparente
            Container(
              color: primaryColor.withOpacity(
                  0.5), // Ajusta el nivel de opacidad según sea necesario
              width: double.infinity,
              height: double.infinity,
            ),
            // Contenido de la pantalla
            Column(
              children: [
                // Encabezado
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botón de retroceso
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: background1,
                          ),
                          child: Center(
                            child: Transform.translate(
                              offset: const Offset(
                                  -2, 0), // adjust the offset as needed
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: primaryColor,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Botón de guardado si hay usuarios con datos completos
                      if (_usuariosCompletos.isNotEmpty)
                        Tooltip(
                          message: 'Cargar Usuarios',
                          child: GestureDetector(
                            onTap: () {
                              modalPost();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: background1,
                              ),
                              child: const Icon(
                                Icons.save,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                // Titulo
                Center(
                  child: Text(
                    'Registro de usuarios',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontFamily: 'Calibri-Bold',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                // Mensaje introductorio si no hay un archivo CSV cargado
                _usuariosCompletos.isEmpty && _usuariosIncompletos.isEmpty
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Por favor, cargue un archivo CSV. Para asegurar que el proceso se realice de la mejor manera posible, le recomendamos seguir las pautas de la introducción.',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                fontFamily: 'Calibri-Bold',
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(
                                        0.5), // Color y opacidad de la sombra
                                    offset: const Offset(2,
                                        2), // Desplazamiento de la sombra (horizontal, vertical)
                                    blurRadius:
                                        3, // Radio de desenfoque de la sombra
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: defaultPadding),
                            // Botón para ver la introducción
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10), // Borde redondeado.
                                color: background1, // Color de fondo.
                                boxShadow: const [
                                  BoxShadow(
                                    color: botonSombra, // Color de la sombra.
                                    blurRadius:
                                        5, // Radio de desfoque de la sombra.
                                    offset: Offset(
                                        0, 3), // Desplazamiento de la sombra.
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors
                                    .transparent, // Color transparente para el Material.
                                child: InkWell(
                                  onTap: () {}, // Función de presionar.
                                  borderRadius: BorderRadius.circular(
                                      10), // Radio del borde redondeado.
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10), // Padding vertical.
                                    child: Center(
                                      child: Text(
                                        "Ver Introducción CSV", // Texto del botón.
                                        style: TextStyle(
                                          color: primaryColor, // Color del texto.
                                          fontSize: 13, // Tamaño de fuente.
                                          fontWeight:
                                              FontWeight.bold, // Peso de fuente.
                                          fontFamily: 'Calibri-Bold', // Fuente.
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    // Tabla de usuarios
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: [
                              // Encabezado de la tabla
                              _buildTableHeader(),
                              // Encabezado de la sección de usuarios completos
                              ListTile(
                                title: Text(
                                  'Usuarios Completos',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                    fontFamily: 'Calibri-Bold',
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(
                                            0.5), // Color y opacidad de la sombra
                                        offset: const Offset(2,
                                            2), // Desplazamiento de la sombra (horizontal, vertical)
                                        blurRadius:
                                            3, // Radio de desenfoque de la sombra
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Itera los usuarios completos para añadirlos a una fila
                              ..._usuariosCompletos.map((usuario) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: _buildUserRow(usuario),
                                  )),
                              const SizedBox(height: defaultPadding),
                              const Divider(
                                color: Colors.white,
                              ),
                              const SizedBox(height: defaultPadding),
                              // Encabezado de la sección de usuarios incompletos
                              ListTile(
                                title: Text(
                                  'Usuarios Incompletos',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                    fontFamily: 'Calibri-Bold',
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(
                                            0.5), // Color y opacidad de la sombra
                                        offset: const Offset(2,
                                            2), // Desplazamiento de la sombra (horizontal, vertical)
                                        blurRadius:
                                            3, // Radio de desenfoque de la sombra
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Itera los usuarios incompletos para añadirlos a una fila
                              ..._usuariosIncompletos.map(
                                (usuario) => Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: _buildUserRow(usuario),
                                ),
                              ),
                              const SizedBox(height: defaultPadding),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
        // Botón para cargar el archivo CSV
        floatingActionButton: FloatingActionButton(
          onPressed: _loadCSV,
          tooltip: 'Cargar CSV',
          child: Icon(_usuariosCompletos.isEmpty || _usuariosIncompletos.isEmpty
              ? Icons.file_upload
              : Icons.replay_rounded),
        ),
      ),
    );
  }

  // Muestra un modal de advertencia en caso de que el archivo CSV contenga datos faltantes
  void modalPost() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Advertencia!', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                  "Tenga en cuenta que los usuarios con algún dato faltante no podrán registrarse.",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 10,
              ),
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
          actions: <Widget>[
            OverflowBar(
              overflowAlignment: OverflowBarAlignment.center,
              alignment: MainAxisAlignment.center,
              children: [
                // Botón de cancelar
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Cancelar", () {
                    Navigator.pop(context);
                  }),
                ),
                // Botón de cargar
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Cargar Usuarios", () {
                    Navigator.pop(context);
                    addUser(_usuariosCompletos);
                  }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Muestra un modal de cargando cuando se esten subiendo los usuarios a la base de datos
  void modalCargando() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Cargando!', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                  'Esperando respuesta del servidor. Esto puede tardar varios minutos. Por favor, no cierre esta ventana.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 10,
              ),
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
        );
      },
    );
  }
}
