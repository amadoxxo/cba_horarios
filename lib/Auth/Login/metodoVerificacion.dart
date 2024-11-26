// ignore_for_file: unused_local_variable, file_names, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:horarios_cba/Auth/source/randomCode.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/provider.dart';
import 'package:provider/provider.dart';
import '../../Home/homePage.dart';
import '../source/verification.dart';
// import 'package:smtp/smtp.dart';

/// Esta clase representa la pantalla de verificación del código de acceso.
///
/// La pantalla se utiliza para verificar el código de acceso enviado por correo electrónico.
/// Recibe un objeto de tipo [UsuarioModel] que contiene los datos del usuario y un código de acceso.
/// La pantalla muestra un campo de texto para ingresar el código de acceso y un botón para confirmar el código.
///
/// Los siguientes atributos deben ser proporcionados:
/// - [usuario]: Un objeto de tipo [UsuarioModel] que contiene los datos del usuario.
/// - [code]: El código de acceso enviado por correo electrónico.
class VerificationScreen extends StatefulWidget {
  final UsuarioModel usuario;
  final FlutterSecureStorage code;

  /// Crea una instancia de [VerificationScreen].
  ///
  /// Recibe los siguientes argumentos obligatorios:
  /// - [key]: La clave de la widget.
  /// - [usuario]: Un objeto de tipo [UsuarioModel] que contiene los datos del usuario.
  /// - [code]: El código de acceso enviado por correo electrónico.
  const VerificationScreen({
    super.key,
    required this.usuario,
    required this.code,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  /// Lista de controladores de texto para los dígitos de verificación.
  ///
  /// Cada controlador de texto se utiliza para controlar el valor de un dígito de verificación.
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  /// Lista de nodos de enfoque para los dígitos de verificación.
  ///
  /// Cada nodo de enfoque se utiliza para controlar el enfoque de un dígito de verificación.
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  /// Servicio de verificación de correo electrónico utilizado para enviar y recibir códigos de verificación.
  final VerificationService emailService = VerificationService();

  /// Indica si se está realizando una operación asincrónica, como enviar un código de verificación.
  bool isLoading = false;

  /// El código de verificación actual.
  late String _currentCode;

  /// El temporizador utilizado para enviar nuevos códigos de verificación.
  late Timer _timer;

  /// El número de envios realizados.
  late int numeroEnvios = 0;

  /// Inicializa el estado de la pantalla de verificación del código.
  ///
  /// Establece el código de verificación actual y establece un temporizador que envía
  /// nuevos códigos de verificación cada 300 segundos. Si se han enviado 3 códigos,
  /// se cancela el temporizador y se muestra un diálogo de alerta.
  @override
  void initState() {
    super.initState();

    // Establecer el código de verificación actual
    loadCode();

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
                widget.usuario.correoElectronico, _currentCode, context);

            // Actualizar la interfaz de usuario con el nuevo código de verificación
            nuevoCodigo(context);
          }
        });
      },
    );
  }

  /// Carga el código desencriptado y actualiza el estado de la aplicación.
  void loadCode() async {
    String? codigo = await decifrarCodigo();

    await widget.code.delete(key: "codigo");

    setState(() {
      _currentCode = codigo;
    });
  }

  /// Función asíncrona para desencriptar y recuperar el código almacenado.
  Future<String> decifrarCodigo() async {
    // Recupera el código almacenado en FlutterSecureStorage
    String? codigo = await widget.code.read(key: 'codigo');
    return codigo ??
        ''; // Retorna una cadena vacía si no se encuentra el código
  }

  /// Método que se llama cuando se elimina el widget.
  ///
  /// Cancela el temporizador y libera los controles de texto.
  @override
  void dispose() {
    // Se llama al método [dispose] del widget base
    super.dispose();

    // Cancela el temporizador si está activo
    _timer.cancel();

    // Llama al método [clearControllers] para liberar los controles de texto
    clearControllers();
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

    if (code == _currentCode) {
      // Cancelamos el temporizador y mostramos la siguiente página
      setState(() {
        _timer.cancel();
        Provider.of<AppState>(context, listen: false)
            .setUsuarioAutenticado(widget.usuario);
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      // Muestra un diálogo indicando un error de verificación
      verificacionError(context);
    }
  }

  /// Llama al método [clear] de cada controlador en la lista [_controllers]
  /// para limpiar los campos de texto.
  void clearControllers() {
    // Recorrer la lista de controles de texto y llamar al método [clear]
    // para limpiar cada uno de ellos.
    for (var controller in _controllers) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, responsive) {
        // verificar si la oantalla es del tamaño movil.
        if (responsive.maxWidth <= 970) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(
                            //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                            'assets/img/login.webp'), fit: BoxFit.cover)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 23, right: 23, top: 100, bottom: 50),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(122, 0, 0, 0),
                          borderRadius: BorderRadius.circular(15)),
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
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Text.rich(
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    TextSpan(
                                      text:
                                          'Se envío un correo de verificación a ',
                                      children: [
                                        WidgetSpan(
                                          child: SizedBox(
                                            width: 150, // ancho máximo del texto
                                            child: Text(
                                              widget.usuario.correoElectronico,
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
                                                      color: Colors.black),
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
                                                      // Si se ingresa un valor, pasar al siguiente campo
                                                      _focusNodes[index]
                                                          .unfocus();
                                                      if (index < 5) {
                                                        _focusNodes[index + 1]
                                                            .requestFocus();
                                                      }
                                                    } else if (value.isEmpty &&
                                                        index > 0) {
                                                      // Si se borra un valor, regresar al campo anterior
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
                                      // Función de Verificación
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
          // Vista web
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(
                            //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                            'assets/img/login.webp'), fit: BoxFit.cover)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 23.0, vertical: 30.0),
                      child: Row(
                        children: [
                          // Columna izquierda, información
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
                                          blurRadius:
                                              3, // Radio de desenfoque de la sombra
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
                                            blurRadius:
                                                3, // Radio de desenfoque de la sombra
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
                          // Columna derecha con formulario.
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(122, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(15)),
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
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(25),
                                          child: Text.rich(
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                            TextSpan(
                                              text:
                                                  'Se envío un correo de verificación a ',
                                              children: [
                                                WidgetSpan(
                                                  child: SizedBox(
                                                    width:
                                                        150, // ancho máximo del texto
                                                    child: Text(
                                                      widget.usuario
                                                          .correoElectronico,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text:
                                                      ', Este código tiene una validez de 5 minutos. Transcurrido este tiempo, se enviará un nuevo código.',
                                                ),
                                              ],
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
                                                              color:
                                                                  Colors.black),
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
                                                              // Si se ingresa un valor, pasar al siguiente campo
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
                                                              // Si se borra un valor, regresar al campo anterior
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
                                              // Función de Verificación
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

  /// Obtiene el código de verificación concatenando el texto de cada controlador de texto en la lista [_controllers].
  ///
  /// Devuelve la cadena resultante.
  ///
  /// Esta función recorre cada controlador en la lista [_controllers] y obtiene el texto de cada uno.
  /// Luego, concatena todos los textos en una sola cadena.
  String getVerificationCode() {
    // Recorrer la lista de controladores de texto y obtener el texto de cada uno,
    // luego concatenarlos en una sola cadena.
    return _controllers.map((controller) => controller.text).join();
  }

  /// Muestra un diálogo con un mensaje de error cuando el código de verificación no coincide.
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
          // Título del diálogo
          title: const Center(
              child: Text(
            "Error de verificación",
            textAlign: TextAlign.center,
          )),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Texto de descripción
              const Text("¡El código no coincide!"),
              const SizedBox(
                height: 10,
              ),
              // Muestra una imagen circular del logo de la aplicación
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
                "¡Te enviaremos un código nuevo!",
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
    // Muestra un diálogo con el título "Emails Enviados" y el contenido personalizado.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            "Correos Enviados",
            textAlign: TextAlign.center,
          )), // Título del diálogo
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                  "¡Se han enviado 3 correos! Redirigiendo..."), // Texto informativo para el usuario
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

    // Cierra el diálogo después de 5 segundos y redirige a la página de inicio
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pop(context); // Cerrar el diálogo
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }
}
