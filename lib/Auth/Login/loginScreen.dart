// ignore_for_file: file_names, prefer_final_fields, use_build_context_synchronously, no_logic_in_create_state, avoid_unnecessary_containers, must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:horarios_cba/Auth/source/randomCode.dart';
import 'package:horarios_cba/Auth/Login/metodoVerificacion.dart';
import 'package:horarios_cba/Home/homePage.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/provider.dart';

import 'package:local_auth/local_auth.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import '../Registro/registerScreen.dart';
import '../source/verification.dart';

/// Esta clase representa un widget de estado que muestra la pantalla de inicio de sesión.
///
/// Esta clase extiende [StatefulWidget] y tiene un único método obligatorio:
/// [createState] que crea un estado [_LoginState] para manejar los datos de la pantalla.
///
/// El constructor de esta clase recibe un [TabController] como parámetro,
/// que se utiliza para controlar las pestañas de inicio de sesión y registro.
class Login extends StatefulWidget {
  /// Controlador de las pestañas de inicio de sesión y registro.
  late TabController tabController;

  /// Constructor para la creación de la pantalla de inicio de sesión.
  ///
  /// El parámetro [tabController] es obligatorio y se utiliza para controlar las pestañas.
  Login({
    super.key,
    required this.tabController,
  });

  @override

  /// Crea un estado [_LoginState] para manejar los datos de la pantalla de inicio de sesión.
  ///
  /// El estado recibe el [tabController] pasado al constructor como parámetro.
  State<Login> createState() => _LoginState(tabController: tabController);
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  /// Controlador de las pestañas de inicio de sesión y registro.
  late TabController tabController;

  /// Constructor para inicializar el estado.
  ///
  /// El parámetro [tabController] es obligatorio y se utiliza para controlar las pestañas.
  _LoginState({required this.tabController});

  /// Controlador para el campo de número de documento.
  final TextEditingController _documentoController = TextEditingController();

  /// Variable para encriptar el código de verificación.
  final codigoStorage = const FlutterSecureStorage();

  /// Servicio para la autenticación local.
  final LocalAuthentication auth = LocalAuthentication();

  /// Servicio para el envío de correos electrónicos de verificación.
  final VerificationService emailService = VerificationService();

  /// Formateador para el campo de número de documento.
  var inputDocumento = MaskTextInputFormatter(
      mask: "############", filter: {"#": RegExp(r'[0-9]')});

  /// Función asincrónica para realizar el inicio de sesión.
  ///
  /// Busca al usuario en la base de datos con el número de documento proporcionado,
  /// verifica su estado y realiza la autenticación local o envía un correo electrónico de verificación.
  ///
  /// Si el usuario es encontrado, se verifica si está activo. Si es así, se realiza la autenticación local
  /// en dispositivos móviles que tengan biometría. Si no es así, se envía un correo electrónico de verificación.
  /// Si el usuario no está activo, se muestra un diálogo indicando que el usuario está inactivo.
  /// Si el usuario no es encontrado, se muestra un diálogo indicando un error de autenticación.
  Future login() async {
    // Obtener la lista de usuarios
    List<UsuarioModel> usuarios = await getUsuarios();

    // Generar un código aleatorio
    final code = generateRandomCode();

    // Buscar al usuario con el número de documento proporcionado
    final usuarioEncontrado = usuarios
        .where((usuario) =>
            usuario.numeroDocumento == _documentoController.text.trim())
        .firstOrNull;

    if (usuarioEncontrado != null) {
      if (usuarioEncontrado.estado) {
        // Verificar si el dispositivo móvil tiene biometría
        if (!UniversalPlatform.isWeb &&
            (UniversalPlatform.isAndroid || UniversalPlatform.isIOS)) {
          bool isAvailable;
          bool isDeviceSupported;

          isAvailable = await auth.canCheckBiometrics;
          isDeviceSupported = await auth.isDeviceSupported();

          // Si es posible la biometria se realiza mediante la dependencia flutter auth
          if (isAvailable && isDeviceSupported) {
            bool result = await auth.authenticate(
                options: const AuthenticationOptions(biometricOnly: false),
                localizedReason: 'Toque el sensor de huellas digitales');
            if (result) {
              setState(() {
                Provider.of<AppState>(context, listen: false)
                    .setUsuarioAutenticado(usuarioEncontrado);
              });
              // emailService.djangoLoginNow(usuarioEncontrado.correoElectronico);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('No se pudo autenticar la huella.'),
              ));
            }
          } else {
            // // Guarda el código en almacenamiento local y de paso lo encripta.
            await codigoStorage.write(key: "codigo", value: code);

            // Si el dispositivo movil no tiene biometria.
            emailService.djangoSendEmail(
                usuarioEncontrado.correoElectronico, code, context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerificationScreen(
                  usuario: usuarioEncontrado,
                  code: codigoStorage,
                ),
              ),
            );
          }
        } else {
          // // Guarda el código en almacenamiento local y de paso lo encripta.
          await codigoStorage.write(key: "codigo", value: code);

          // Si no es android o ios, se hace el envio por el correo,
          emailService.djangoSendEmail(
              usuarioEncontrado.correoElectronico, code, context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                usuario: usuarioEncontrado,
                code: codigoStorage,
              ),
            ),
          );
        }
      } else {
        // usuario inactivo.
        mostrarUserInactivo(context);
      }
    } else {
      // Error de autenticación, registrarse
      mostrarDialogoError(context);
    }
  }

  @override

  /// Libera los recursos utilizados por el widget.
  ///
  /// Se llama automáticamente cuando el widget es eliminado.
  /// Se debe llamar a [dispose] para liberar los recursos utilizados por
  /// el controlador de documento. Finalmente, se llama al método [dispose]
  /// del padre para liberar recursos adicionales.
  @override
  void dispose() {
    // Liberar recursos del controlador de documento
    _documentoController.dispose();

    // Llamar al método [dispose] del widget base
    super.dispose();
  }

  @override

  /// Construye la interfaz de usuario basada en la anchura de la pantalla.
  ///
  /// Verifica la anchura máxima de la pantalla y devuelve el diseño adecuado.
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, responsive) {
        // Verificar la anchura máxima de la pantalla para realizar ajustes responsivos
        // Si la anchura es menor o igual a 970, se utiliza el diseño para pantallas móviles
        // De lo contrario, se utiliza el diseño para pantallas de escritorio
        return responsive.maxWidth <= 970
            ? isMobile(context) // Diseño para pantallas móviles
            : isDesktop(context); // Diseño para pantallas de escritorio
      },
    );
  }

  /// Función que devuelve un widget Padding para ajustar márgenes y rellenos en la interfaz según si el dispositivo es móvil.
  ///
  /// [context] Contexto del widget donde se utiliza esta función.
  /// Devuelve un widget Padding configurado con márgenes y rellenos específicos.
  Padding isMobile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, top: 100, bottom: 50),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(122, 0, 0, 0),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            TabBar(
                              dividerColor: Colors.transparent,
                              controller: tabController,
                              isScrollable: true,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.white,
                              indicatorColor: Colors.white,
                              labelStyle: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              tabs: const [
                                Tab(text: 'Iniciar Sesión'),
                                Tab(
                                  text: 'Registrarse',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 5,
              child: TabBarView(
                controller: tabController,
                children: [
                  // Vista para iniciar sesión
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text(
                                  'Iniciar Sesion',
                                  style: TextStyle(
                                      fontSize: 33,
                                      fontFamily: 'Calibri-Bold',
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 25, right: 30),
                                child: Text(
                                  'Bienvenido de nuevo, tu aprendizaje continúa aquí',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white
                                      //fontFamily: 'DelaGothicOne'
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0, right: 2.0),
                                child: TextField(
                                  inputFormatters: [inputDocumento],
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(color: Colors.black),
                                  controller: _documentoController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText:
                                        'N° Documento (NIT sin guion y dígito de verificación)',
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  // Función de login
                                  login();
                                },
                                child: Container(
                                  width: 200,
                                  height: 50,
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Iniciar Sesión',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40)
                        ],
                      ),
                    ),
                  ),
                  // Vista para el registro
                  const Register()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Función que devuelve un widget Padding diseñado para la interfaz de escritorio, ajustando márgenes y rellenos.
  ///
  /// [context] Contexto del widget donde se utiliza esta función.
  /// Devuelve un widget Padding con márgenes y rellenos específicos para la interfaz de escritorio.
  Padding isDesktop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 30.0),
      child: Row(
        children: [
          // Columna izquierda con información
          Expanded(
            flex: 4,
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CBA Mosquera',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                      fontFamily: 'Calibri-Bold',
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(
                              0.5), // Color y opacidad de la sombra
                          offset: const Offset(2,
                              2), // Desplazamiento de la sombra (horizontal, vertical)
                          blurRadius: 3, // Radio de desenfoque de la sombra
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Text(
                      'El camino hacia el éxito empieza aquí.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontFamily: 'Calibri',
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(
                                0.5), // Color y opacidad de la sombra
                            offset: const Offset(2,
                                2), // Desplazamiento de la sombra (horizontal, vertical)
                            blurRadius: 3, // Radio de desenfoque de la sombra
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 40),
          // Columna derecha con pestañas de inicio de sesión y registro
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(122, 0, 0, 0),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Barra de pestañas
                  PreferredSize(
                      preferredSize: const Size.fromHeight(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                TabBar(
                                  dividerColor: Colors.transparent,
                                  controller: tabController,
                                  isScrollable: true,
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.white,
                                  indicatorColor: Colors.white,
                                  labelStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  tabs: const [
                                    Tab(text: 'Iniciar Sesión'),
                                    Tab(
                                      text: 'Registrarse',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 6,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        // Vista para iniciar sesión
                        Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Text(
                                        'Iniciar Sesión',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontFamily: 'Calibri-Bold',
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 25,
                                        right: 30,
                                        bottom: 25,
                                      ),
                                      child: Text(
                                        'Bienvenido de nuevo, tu aprendizaje continúa aquí',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white
                                            //fontFamily: 'DelaGothicOne'
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 2.0),
                                      child: TextField(
                                        inputFormatters: [inputDocumento],
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _documentoController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          hintText:
                                              'N° Documento (NIT sin guion y dígito de verificación)',
                                          fillColor: Colors.grey[200],
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: InkWell(
                                      onTap: () {
                                        login();
                                        // Función de login
                                      },
                                      child: Container(
                                        width: 180,
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Iniciar Sesión',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const SizedBox(height: 20)
                              ],
                            ),
                          ),
                        ),
                        // Vista para el registro
                        const Register()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Muestra un diálogo de error de autenticación cuando el número de documento no existe.
  ///
  /// Este método muestra un diálogo con un mensaje informativo y un botón para aceptar el mensaje.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void mostrarDialogoError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            "¡Credenciales Incorrectas!",
            textAlign: TextAlign.center,
          )), // Título del diálogo
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "La información del usuario es incorrecta. Por favor, intente de nuevo.",
                textAlign: TextAlign.center,
              ), // Mensaje informativo para el usuario
              const SizedBox(
                height: 10,
              ),
              ClipOval(
                // Contenedor con la imagen del logo, recortado en forma circular
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
                    Navigator.pop(
                        context); // Cierra el diálogo cuando se presiona el botón "Aceptar"
                  }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// Muestra un diálogo de error de autenticación cuando el usuario está inactivo.
  ///
  /// Este método muestra un diálogo con un mensaje informativo y un botón para aceptar el mensaje.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void mostrarUserInactivo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            "¡Usuario Inactivo!",
            textAlign: TextAlign.center,
          )), // Título del diálogo
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "El usuario está inactivo. Por favor, solicite la activación enviando un correo electrónico a: proyectohorarioscba@gmail.com.",
                textAlign: TextAlign.center,
              ), // Mensaje informativo para el usuario
              const SizedBox(
                height: 10,
              ),
              ClipOval(
                // Contenedor con la imagen del logo, recortado en forma circular
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
                    Navigator.pop(
                        context); // Cierra el diálogo cuando se presiona el botón "Aceptar"
                  }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
