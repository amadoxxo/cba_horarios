// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:horarios_cba/Auth/source/randomCode.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/provider.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../Home/homePage.dart';
import '../../Models/usuarioModel.dart';
import '../../source.dart';
import '../source/verification.dart';
// import 'package:smtp/smtp.dart';

/// Esta clase representa la pantalla de verificación del correo electrónico para el registro de usuarios.
///
/// Esta clase extiende [StatefulWidget] y proporciona un estado asociado
/// [_VerificationScreenRegisterState].
///
/// Los siguientes atributos deben ser proporcionados:
/// - [usuarioNombres]: El nombre del usuario.
/// - [usuarioApellidos]: El apellido del usuario.
/// - [usuarioTelefono]: El número de teléfono del usuario.
/// - [usuarioTdocumento]: El tipo de documento del usuario.
/// - [usuarionoDocumento]: El número de documento del usuario.
/// - [usuarioemail]: El correo electrónico del usuario.
/// - [code]: El código de verificación enviado al correo electrónico del usuario.
class VerificationScreenRegister extends StatefulWidget {
  /// El nombre del usuario.
  final FlutterSecureStorage usuarioNombres;

  /// El apellido del usuario.
  final FlutterSecureStorage usuarioApellidos;

  /// El número de teléfono del usuario.
  final FlutterSecureStorage usuarioTelefono;

  /// El tipo de documento del usuario.
  final FlutterSecureStorage usuarioTdocumento;

  /// El número de documento del usuario.
  final FlutterSecureStorage usuarioNoDocumento;

  /// El correo electrónico del usuario.
  final FlutterSecureStorage usuarioEmail;

  /// El código de verificación enviado al correo electrónico del usuario.
  final FlutterSecureStorage code;

  /// Construye un objeto [VerificationScreenRegister].
  ///
  /// Los siguientes parámetros deben ser proporcionados:
  /// - [usuarioNombres]: El nombre del usuario.
  /// - [usuarioApellidos]: El apellido del usuario.
  /// - [usuarioTelefono]: El número de teléfono del usuario.
  /// - [usuarioTdocumento]: El tipo de documento del usuario.
  /// - [usuarionoDocumento]: El número de documento del usuario.
  /// - [usuarioemail]: El correo electrónico del usuario.
  /// - [code]: El código de verificación enviado al correo electrónico del usuario.
  const VerificationScreenRegister({
    super.key,
    required this.usuarioNombres,
    required this.code,
    required this.usuarioApellidos,
    required this.usuarioTelefono,
    required this.usuarioTdocumento,
    required this.usuarioNoDocumento,
    required this.usuarioEmail,
  });

  @override
  State<VerificationScreenRegister> createState() =>
      _VerificationScreenRegisterState();
}

class _VerificationScreenRegisterState
    extends State<VerificationScreenRegister> {
  /// Los controles de texto de los campos de entrada.
  ///
  /// Cada elemento de la lista es un [TextEditingController] que se utiliza para
  /// validar el valor ingresado en el campo de entrada correspondiente.
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  /// Las nodos de enfoque de los campos de entrada.
  ///
  /// Cada elemento de la lista es un [FocusNode] que se utiliza para
  /// controlar el enfoque de los campos de entrada correspondientes.
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  /// La clase de servicio para la verificación de correos electrónicos.
  final emailService = VerificationService();

  /// Indica si se está realizando una carga de información.
  bool isLoading = false;

  /// El código de verificación actual.
  late String _currentCode;

  /// El temporizador que se utiliza para enviar nuevos códigos de verificación.
  late Timer _timer;

  /// El número de veces que se ha enviado un código de verificación.
  late int numeroEnvios = 0;

  // Controladores donde se guardaran los datos desencriptados del usuario

  final TextEditingController _nombresController = TextEditingController();

  final TextEditingController _apellidosController = TextEditingController();

  final TextEditingController _telefonoController = TextEditingController();

  final TextEditingController _tipoDocumentoController =
      TextEditingController();

  final TextEditingController _noDocumentoController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  @override

  /// Inicializa el estado de la pantalla de verificación del código.
  ///
  /// Establece el código de verificación actual y establece un temporizador que envía
  /// nuevos códigos de verificación cada 300 segundos. Si se han enviado 3 códigos,
  /// se cancela el temporizador y se muestra un diálogo de alerta.
  void initState() {
    super.initState();

    // Establecer las variables encriptadas del usuario
    loadVariables();

    // Establecer un temporizador para enviar nuevos códigos de verificación
    _timer = Timer.periodic(
      const Duration(seconds: 300),
      (timer) {
        setState(() {
          // Generar un nuevo código de verificación
          _currentCode = generateRandomCode();

          // Incrementar el número de envios
          numeroEnvios++;

          // Si se han enviado 3 códigos, cancelar el temporizador y mostrar un diálogo
          if (numeroEnvios == 3) {
            _timer.cancel();
            showAlertAndNavigate(context);
          } else {
            // Enviar un nuevo código de verificación por correo electrónico
            emailService.djangoSendEmail(
                _emailController.text, _currentCode, context);

            // Actualizar la interfaz de usuario con el nuevo código de verificación
            nuevoCodigo(context);
          }
        });
      },
    );
  }

  /// Carga los datos desencriptados y actualiza el estado de la aplicación.
  void loadVariables() async {
    // Desencripta y recupera el código almacenado
    String? codigo = await decifrarCodigo();

    // Desencripta y recupera los nombres almacenados
    String? nombres = await decifrarNombres();

    // Desencripta y recupera los apellidos almacenados
    String? apellidos = await decifrarApellidos();

    // Desencripta y recupera el número de teléfono almacenado
    String? telefono = await decifrarTelefono();

    // Desencripta y recupera el tipo de documento almacenado
    String? tipoDocumento = await decifrarTipoDocumento();

    // Desencripta y recupera el número de documento almacenado
    String? noDocumento = await decifrarNumeroDocumento();

    // Desencripta y recupera el correo electrónico almacenado
    String? email = await decifrarCorreo();

    // Elimina los datos almacenados en FlutterSecureStorage
    await widget.code.delete(key: "codigoRegistro");
    await widget.usuarioNombres.delete(key: "nombres");
    await widget.usuarioApellidos.delete(key: "apellidos");
    await widget.usuarioTelefono.delete(key: "telefono");
    await widget.usuarioTdocumento.delete(key: "tipoDocumento");
    await widget.usuarioNoDocumento.delete(key: "numeroDocumento");
    await widget.usuarioEmail.delete(key: "correo");

    // Actualiza el estado de la aplicación con los valores desencriptados
    setState(() {
      _currentCode = codigo;
      _nombresController.text = nombres;
      _apellidosController.text = apellidos;
      _telefonoController.text = telefono;
      _tipoDocumentoController.text = tipoDocumento;
      _noDocumentoController.text = noDocumento;
      _emailController.text = email;
    });
  }

  /// Función asíncrona para desencriptar y recuperar el código almacenado.
  Future<String> decifrarCodigo() async {
    // Recupera el código almacenado en FlutterSecureStorage
    String? codigo = await widget.code.read(key: 'codigoRegistro');
    return codigo ??
        ''; // Retorna una cadena vacía si no se encuentra el código
  }

  /// Función asíncrona para desencriptar y recuperar los nombres almacenados.
  Future<String> decifrarNombres() async {
    // Recupera los nombres almacenados en FlutterSecureStorage
    String? nombres = await widget.usuarioNombres.read(key: 'nombres');
    return nombres ??
        ''; // Retorna una cadena vacía si no se encuentran los nombres
  }

  /// Función asíncrona para desencriptar y recuperar los apellidos almacenados.
  Future<String> decifrarApellidos() async {
    // Recupera los apellidos almacenados en FlutterSecureStorage
    String? apellidos = await widget.usuarioApellidos.read(key: 'apellidos');
    return apellidos ??
        ''; // Retorna una cadena vacía si no se encuentran los apellidos
  }

  /// Función asíncrona para desencriptar y recuperar el teléfono almacenado.
  Future<String> decifrarTelefono() async {
    // Recupera el número de teléfono almacenado en FlutterSecureStorage
    String? telefono = await widget.usuarioTelefono.read(key: 'telefono');
    return telefono ??
        ''; // Retorna una cadena vacía si no se encuentra el teléfono
  }

  /// Función asíncrona para desencriptar y recuperar el tipo de documento almacenado.
  Future<String> decifrarTipoDocumento() async {
    // Recupera el tipo de documento almacenado en FlutterSecureStorage
    String? tipoDocumento =
        await widget.usuarioTdocumento.read(key: 'tipoDocumento');
    return tipoDocumento ??
        ''; // Retorna una cadena vacía si no se encuentra el tipo de documento
  }

  /// Función asíncrona para desencriptar y recuperar el número de documento almacenado.
  Future<String> decifrarNumeroDocumento() async {
    // Recupera el número de documento almacenado en FlutterSecureStorage
    String? numeroDocumento =
        await widget.usuarioNoDocumento.read(key: 'numeroDocumento');
    return numeroDocumento ??
        ''; // Retorna una cadena vacía si no se encuentra el número de documento
  }

  /// Función asíncrona para desencriptar y recuperar el correo electrónico almacenado.
  Future<String> decifrarCorreo() async {
    // Recupera el correo electrónico almacenado en FlutterSecureStorage
    String? correo = await widget.usuarioEmail.read(key: 'correo');
    return correo ??
        ''; // Retorna una cadena vacía si no se encuentra el correo electrónico
  }

  /// Libera los recursos utilizados por el temporizador y los controles de texto.
  ///
  /// Se llama automáticamente cuando se elimina el widget.
  /// Se debe llamar a [dispose] para liberar los recursos utilizados por el temporizador y los controles de texto.
  /// Finalmente, se llama al método [dispose] del padre para liberar recursos adicionales.
  @override
  void dispose() {
    // Cancela el temporizador si está activo
    _timer.cancel();

    // Llama al método [clearControllers] para liberar los controles de texto
    clearControllers();

    // Llama al método [dispose] del widget base
    super.dispose();
  }

  /// Función asincrónica para confirmar el código de verificación ingresado por el usuario.
  ///
  /// Verifica si el código ingresado coincide con el código de verificación enviado por correo electrónico.
  /// Si los códigos coinciden, envía una solicitud POST a la API para registrar al usuario y muestra la página de inicio.
  /// Si los códigos no coinciden, muestra un diálogo indicando un error de verificación.
  ///
  /// No recibe ningún parámetro.
  /// Devuelve una [Future] que se completa cuando la función finaliza.
  Future<void> confirmCode() async {
    // Obtener el código de verificación ingresado por el usuario
    String code = getVerificationCode();

    // URL de la API para registrar al usuario
    String url = "$sourceApi/api/usuarios/";

    // Verificar si el código ingresado coincide con el código de verificación enviado por correo electrónico
    if (code == _currentCode) {
      // Si los códigos coinciden, envía una solicitud POST a la API para registrar al usuario
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'nombres': _nombresController.text.trim(),
        'apellidos': _apellidosController.text.trim(),
        'tipoDocumento': _tipoDocumentoController.text.trim(),
        'numeroDocumento': _noDocumentoController.text.trim(),
        'correoElectronico': _emailController.text.trim(),
        'telefonoCelular': _telefonoController.text.trimRight(),
        'rol': '',
      });
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      // Verificar si la respuesta fue exitosa
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'El usuario fue registrado exitosamente',
          ),
        ));
        // Obtener la lista de usuarios
        List<UsuarioModel> usuarios = await getUsuarios();
        // Buscar al usuario con el número de documento proporcionado
        final usuarioEncontrado = usuarios
            .where((usuario) =>
                usuario.numeroDocumento == _noDocumentoController.text)
            .firstOrNull;
        if (usuarioEncontrado != null) {
          setState(() {
            // Setear el usuario autenticado en el estado global
            Provider.of<AppState>(context, listen: false)
                .setUsuarioAutenticado(usuarioEncontrado);
            _timer.cancel();
          });
        }

        // Navegar a la página de inicio
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        // Mostrar un diálogo indicando un error de verificación
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error al registrar el usuario: ${response.statusCode}.',
          ),
        ));
      }
      // Comprobar si los datos ya están en la base de datos
    } else {
      // Mostrar un diálogo indicando un error de verificación
      verificacionError(context);
    }
  }

  /// Llama al método [clear] de cada controlador en la lista `_controllers`
  /// para limpiar los campos de texto.
  void clearControllers() {
    // Recorrer la lista de controles de texto y llamar al método [clear]
    // para limpiar cada uno de ellos.
    for (var controller in _controllers) {
      controller.clear();
    }
  }

  /// Obtiene el código de verificación concatenando el texto de cada controlador de texto en la lista [_controllers].
  ///
  /// Devuelve la cadena resultante.
  String getVerificationCode() {
    // Recorrer la lista de controladores de texto y obtener el texto de cada uno,
    // luego concatenarlos en una sola cadena.
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, responsive) {
        // Verificar si la pantalla es del tamaño móvil.
        if (responsive.maxWidth <= 970) {
          // Retornar el Scaffold para pantallas móviles.
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: [
                  Container(
                    // Configuración del fondo de pantalla.
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/img/login.webp'), // Ruta de la imagen de fondo
                        fit: BoxFit.fill, // Ajuste de la imagen al contenedor
                      ),
                    ),
                    width:
                        MediaQuery.of(context).size.width, // Ancho de la pantalla
                    height:
                        MediaQuery.of(context).size.height, // Alto de la pantalla
                    child: Container(
                      // Contenedor principal
                      margin: const EdgeInsets.only(
                          left: 23, right: 23, top: 100, bottom: 50),
                      decoration: BoxDecoration(
                        // Decoración del contenedor
                        color: const Color.fromARGB(
                            122, 0, 0, 0), // Color de fondo con opacidad
                        borderRadius:
                            BorderRadius.circular(15), // Bordes redondeados
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 2),
                                  child: Text(
                                    'Verificación',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Calibri-Bold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Text.rich(
                                    // Texto de verificación con correo electrónico
                                    TextSpan(
                                      text:
                                          'Se envío un correo de verificación a ',
                                      children: [
                                        WidgetSpan(
                                          child: SizedBox(
                                            width:
                                                150, // Ancho máximo del texto del correo
                                            child: Text(
                                              _emailController
                                                  .text, // Correo electrónico dinámico
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const TextSpan(
                                          text:
                                              ', este código tiene una validez de 5 minutos. Transcurrido este tiempo, se enviará un nuevo código.',
                                        ),
                                      ],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: List.generate(
                                          6,
                                          (index) {
                                            return Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.all(2),
                                                child: TextFormField(
                                                  controller: _controllers[index],
                                                  focusNode: _focusNodes[index],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 10),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors.grey),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    hintText: '*',
                                                    hintStyle: const TextStyle(
                                                      fontSize: 35,
                                                    ),
                                                    counterStyle: const TextStyle(
                                                      color: Colors
                                                          .white, // Cambia este color al que prefieras
                                                    ),
                                                  ),
                                                  maxLength: 1,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      // Avanzar al siguiente campo cuando se ingresa un valor
                                                      _focusNodes[index]
                                                          .unfocus();
                                                      if (index < 5) {
                                                        _focusNodes[index + 1]
                                                            .requestFocus();
                                                      }
                                                    } else if (value.isEmpty &&
                                                        index > 0) {
                                                      // Retroceder al campo anterior cuando se borra un valor
                                                      _focusNodes[index]
                                                          .unfocus();
                                                      _focusNodes[index - 1]
                                                          .requestFocus();
                                                    }
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: InkWell(
                                    onTap: () {
                                      // Función de verificación
                                      confirmCode();
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Verificar',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: background1,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 24,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Retornar el Scaffold para pantallas más grandes
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    // Configuración del fondo de pantalla.
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/img/login.webp'), // Ruta de la imagen de fondo
                        fit: BoxFit.fill, // Ajuste de la imagen al contenedor
                      ),
                    ),
                    width:
                        MediaQuery.of(context).size.width, // Ancho de la pantalla
                    height:
                        MediaQuery.of(context).size.height, // Alto de la pantalla
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 23.0, vertical: 30.0),
                      child: Row(
                        children: [
                          // Columna izquierda, información principal
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'CBA Mosquera', // Título principal
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 100,
                                      fontFamily: 'Calibri-Bold',
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: const Offset(2, 2),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 40),
                                    child: Text(
                                      'El camino hacia el éxito empieza aquí.', // Subtítulo
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontFamily: 'Calibri',
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.5),
                                            offset: const Offset(2, 2),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                          // Columna derecha con el formulario de verificación
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                // Decoración del contenedor
                                color: const Color.fromARGB(
                                    122, 0, 0, 0), // Color de fondo con opacidad
                                borderRadius: BorderRadius.circular(
                                    15), // Bordes redondeados
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            'Verificación',
                                            style: TextStyle(
                                              fontSize: 35,
                                              fontFamily: 'Calibri-Bold',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(25),
                                          child: Text.rich(
                                            // Texto de verificación con correo electrónico
                                            TextSpan(
                                              text:
                                                  'Se envío un correo de verificación a ',
                                              children: [
                                                WidgetSpan(
                                                  child: SizedBox(
                                                    width:
                                                        150, // Ancho máximo del texto del correo
                                                    child: Text(
                                                      _emailController
                                                          .text, // Correo electrónico dinámico
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text:
                                                      ', este código tiene una validez de 5 minutos. Transcurrido este tiempo, se enviará un nuevo código.',
                                                ),
                                              ],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12, right: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: List.generate(
                                                  6,
                                                  (index) {
                                                    return Expanded(
                                                      child: Container(
                                                        margin:
                                                            const EdgeInsets.all(
                                                                2),
                                                        child: TextFormField(
                                                          controller:
                                                              _controllers[index],
                                                          focusNode:
                                                              _focusNodes[index],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                            fontSize: 35,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 10),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            hintText: '*',
                                                            hintStyle:
                                                                const TextStyle(
                                                              fontSize: 35,
                                                            ),
                                                            counterStyle:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .white, // Cambia este color al que prefieras
                                                            ),
                                                          ),
                                                          maxLength: 1,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly,
                                                          ],
                                                          onChanged: (value) {
                                                            if (value.length ==
                                                                1) {
                                                              // Avanzar al siguiente campo cuando se ingresa un valor
                                                              _focusNodes[index]
                                                                  .unfocus();
                                                              if (index < 5) {
                                                                _focusNodes[
                                                                        index + 1]
                                                                    .requestFocus();
                                                              }
                                                            } else if (value
                                                                    .isEmpty &&
                                                                index > 0) {
                                                              // Retroceder al campo anterior cuando se borra un valor
                                                              _focusNodes[index]
                                                                  .unfocus();
                                                              _focusNodes[
                                                                      index - 1]
                                                                  .requestFocus();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: InkWell(
                                            onTap: () {
                                              // Función de verificación
                                              confirmCode();
                                            },
                                            child: Container(
                                              width: 150,
                                              height: 50,
                                              padding: const EdgeInsets.all(15.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Verificar',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: background1,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 24,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  /// Método que muestra un diálogo con un mensaje de error cuando el código de verificación no coincide.
  ///
  /// Este método muestra un diálogo con el título "Error de verificación" y el mensaje "¡El código no coincide!"
  /// en el centro. También muestra una imagen del logo de la aplicación, recortada en forma circular.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void verificacionError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            "Error de verificación",
            textAlign: TextAlign.center,
          )),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "¡El código no coincide!",
                textAlign: TextAlign.center,
              ),
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
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Cancelar", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Intentar de nuevo", () {
                    Navigator.pop(context);
                    setState(() {
                      clearControllers();
                    });
                  }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

// metodo que indica que pasaron 5 min y se enviara un nuevo codigo
  /// Muestra un diálogo indicando que se ha agotado el tiempo para la verificación
  /// y se enviará un nuevo código.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void nuevoCodigo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            "Tiempo Agotado",
            textAlign: TextAlign.center,
          )),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Texto informativo para el usuario
              const Text(
                "¡Se enviará un código nuevo!",
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
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Aceptar", () {
                    // Al aceptar, se reinician los controles del formulario
                    Navigator.pop(context);
                    setState(() {
                      clearControllers();
                    });
                  }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// Muestra un diálogo indicando que se han enviado 3 correos y que se
  /// redirigirá a la página de inicio después de 5 segundos.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void showAlertAndNavigate(BuildContext context) {
    // Muestra un diálogo con el contenido personalizado.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Título del diálogo
          title: const Center(
              child: Text(
            "Correos Enviados",
            textAlign: TextAlign.center,
          )),
          alignment: Alignment.center,
          // Contenido del diálogo
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Texto informativo para el usuario
              const Text(
                "¡Se han enviado 3 correos! Redirigiendo...",
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

    // Cierra el diálogo después de 5 segundos y redirige a la página de inicio
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pop(context); // Cierra el diálogo
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }
}
