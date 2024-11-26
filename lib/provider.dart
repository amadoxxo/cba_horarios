import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:horarios_cba/Home/homePage.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:provider/provider.dart';

// Llave global del navegador para manejar la navegación entre pantallas
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Instancia de Flutter Secure Storage
const storage = FlutterSecureStorage();

/// La clase `AppState` gestiona el estado global de la aplicación.
/// Mantiene el usuario autenticado y administra el guardado y la recuperación de su estado usando `flutter_secure_storage`.
class AppState extends ChangeNotifier {
  /// Usuario autenticado actualmente (si lo hay).
  UsuarioModel? _usuarioAutenticado;

  /// Temporizador de inactividad.
  Timer? _inactivityTimer;

  /// Constructor que carga el usuario desde `flutter_secure_storage` al iniciar.
  AppState() {
    _loadUsuarioFromSecureStorage();
  }

  /// Getter para obtener el usuario autenticado.
  UsuarioModel? get usuarioAutenticado => _usuarioAutenticado;

  /// Establece el usuario autenticado y guarda su estado en `flutter_secure_storage`.
  /// Si el usuario es nulo, elimina el estado guardado.
  void setUsuarioAutenticado(UsuarioModel? usuario) async {
    _usuarioAutenticado = usuario;
    if (usuario != null) {
      await usuario
          .actualizarEstadoEnLinea(true); // Marca al usuario como en línea
      // Inicia el temporizador de inactividad al autenticar.
      //startInactivityTimer();
      await storage.write(key: 'usuarioId', value: usuario.id.toString());
    } else {
      await storage.delete(key: 'usuarioId');
    }
    notifyListeners();
  }

  /// Inicia o reinicia el temporizador de inactividad.
  void startInactivityTimer() {
    _cancelInactivityTimer();
    _inactivityTimer = Timer(const Duration(minutes: 5), () {
      // Si el usuario no ha iniciado sesión, cierra la sesión
      if (_usuarioAutenticado != null) {
        logout();
        modalDesconectado(navigatorKey.currentState!.context);
      }
    });
  }

  /// Cancela el temporizador de inactividad.
  void _cancelInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
  }

  /// Cierra la sesión y elimina el estado guardado en `flutter_secure_storage`.
  void logout() async {
    if (_usuarioAutenticado != null) {
      await _usuarioAutenticado!.actualizarEstadoEnLinea(
          false); // Marca al usuario como fuera de línea
    }
    _usuarioAutenticado = null; // Limpia el usuario
    await storage.deleteAll(); // Elimina el ID del usuario
    notifyListeners();
  }

  /// Muestra un modal indicando que la sesión ha finalizado por inactividad.
  Future<void> modalDesconectado(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("¡Sesión terminada!", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'La sesión ha terminado debido a inactividad. Por favor, inicie sesión nuevamente.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            // Muestra una imagen circular del logo de la aplicación
            ClipOval(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                child: Image.asset(
                  "assets/img/logo.png",
                  fit: BoxFit.cover,
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
              // Botón para aceptar el mensaje
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: buildButton("Aceptar", () {
                  Navigator.pop(context);
                  navigatorKey.currentState!.pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
    return Future.value();
  }

  /// Carga el usuario autenticado desde `flutter_secure_storage`.
  /// Si se encuentra, lo asigna a `_usuarioAutenticado` y reinicia el temporizador de inactividad.
  void _loadUsuarioFromSecureStorage() async {
    // Obtiene el ID del usuario desde el almacenamiento seguro
    String? usuarioId = await storage.read(key: 'usuarioId');

    // Si se obtiene un ID de usuario válido
    if (usuarioId != null) {
      // Obtiene la lista de usuarios
      final usuarios = await getUsuarios();

      // Recorre la lista de usuarios
      for (var usuario in usuarios) {
        // Compara el ID del usuario con el ID obtenido del almacenamiento seguro y verifica si el usuario está en linea
        if (usuario.id.toString() == usuarioId && usuario.enLinea) {
          // Asigna el usuario autenticado a la variable correspondiente
          _usuarioAutenticado = usuario;
          // Reinicia el temporizador de inactividad
          //startInactivityTimer();
          // Notifica a los oyentes sobre el cambio de estado
          notifyListeners();
          return;
        }
      }
    } else {
      // Si no se encuentra un ID de usuario, asigna null al usuario autenticado
      _usuarioAutenticado = null;
    }
  }
}

/// `AppProvider` configura los proveedores de la aplicación.
/// Incluye el estado global (`AppState`) que puede ser accedido por los widgets.
class AppProvider extends StatelessWidget {
  /// Widget hijo que se renderiza dentro del proveedor.
  final Widget child;

  /// Constructor de `AppProvider`.
  const AppProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Proveedor para el estado global de la aplicación (`AppState`)
        ChangeNotifierProvider(create: (context) => AppState()),
      ],
      child: child,
    );
  }
}
