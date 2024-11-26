// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names, unnecessary_null_comparison
import 'package:horarios_cba/dashboard/controllers/menu_app_controller.dart';
// import 'package:horarios_cba/dashboard/screens/main/main_screen_administrador.dart';
import 'package:horarios_cba/dashboard/screens/main/main_screen_aprendiz.dart';
// import 'package:horarios_cba/dashboard/screens/main/main_screen_coordinador.dart';
// import 'package:horarios_cba/dashboard/screens/main/main_screen_instructor.dart';
import 'package:horarios_cba/Home/homePage.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/provider.dart';
import 'package:horarios_cba/responsive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../Auth/authScreen.dart';

/// Widget que representa una tarjeta de perfil de usuario.
///
/// Esta clase extiende [StatefulWidget] y se encarga de mostrar la foto
/// del usuario, nombre y apellido, y permite acceder a la pantalla principal del
/// usuario.
class ProfileCard extends StatefulWidget {
  /// Constructor por defecto.
  ///
  /// No requiere parámetros.
  const ProfileCard({super.key});

  /// Crea el estado para este widget.
  ///
  /// El estado se encarga de manejar los datos de la pantalla.
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    // Uso de Consumer para acceder al estado de la aplicación.
    return Consumer<AppState>(
      builder: (context, appState, _) {
        // Obtengo el usuario autenticado.
        final usuarioAutenticado = appState.usuarioAutenticado;

        return InkWell(
          onTap: () {
            if (usuarioAutenticado != null) {
              // Navegar a la pantalla principal del usuario autenticado.
              // Si el usuario no tiene rol, llamar a la función logoutRol para cerrar la sesión.
              if (usuarioAutenticado.rol == "" ||
                  usuarioAutenticado.rol == null) {
                logoutRol(context);
              } else {
                /*
                // Navegar al dashboard si el usuario tiene un rol
                // Si el usuario es un aprendiz, navega al panel del aprendiz
                if (usuarioAutenticado.rol == "Aprendiz") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) => MenuAppController()),
                        ],
                        child: MainScreenAprendiz(
                          usuarioAutenticado: usuarioAutenticado,
                        ),
                      ),
                    ),
                  );
                  // Si el usuario es un instructor, navega al panel del instructor
                } else if (usuarioAutenticado.rol == "Instructor") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) => MenuAppController()),
                        ],
                        child: MainScreenInstructor(
                          usuarioAutenticado: usuarioAutenticado,
                        ),
                      ),
                    ),
                  );
                  // Si el usuario es un coordinador, navega al panel del coordinador
                } else if (usuarioAutenticado.rol == "Coordinador") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) => MenuAppController()),
                        ],
                        child: MainScreenCoordinador(
                          usuarioAutenticado: usuarioAutenticado,
                        ),
                      ),
                    ),
                  );
                  // Si el usuario es un administrador, navega al panel del administrador
                } else if (usuarioAutenticado.rol == "Administrador") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) => MenuAppController()),
                        ],
                        child: MainScreenAdministrador(
                          usuarioAutenticado: usuarioAutenticado,
                        ),
                      ),
                    ),
                  );
                }
                */

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (context) => MenuAppController()),
                      ],
                      child: MainScreenAprendiz(
                        usuarioAutenticado: usuarioAutenticado,
                      ),
                    ),
                  ),
                );
              }
            } else {
              // Navegar a la pantalla de inicio de sesión si no hay usuario autenticado.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          },
          child: Container(
            // Contenedor que envuelve la tarjeta de perfil.
            margin: const EdgeInsets.only(left: defaultPadding),
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFF2F0F2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                if (usuarioAutenticado != null)
                  // Mostrar la imagen del usuario si está autenticado.
                  // Si el usuario no tiene una imagen, mostrar una imagen de perfil por defecto.
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: usuarioAutenticado.foto != ""
                            ? Image.network(
                                usuarioAutenticado.foto,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              )
                            : CircleAvatar(
                                backgroundColor: primaryColor,
                                radius: 20,
                                child: Text(
                                  usuarioAutenticado.nombres[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                      // Mostrar el nombre del usuario si está autenticado.
                      if (!Responsive.isMobile(context))
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          child: Text(
                            usuarioAutenticado.nombres,
                            style: const TextStyle(color: primaryColor),
                          ),
                        ),
                    ],
                  )
                else
                  // Mostrar opción de iniciar sesión si no está autenticado.
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 38,
                          height: 38,
                          color: primaryColor,
                          child: const Icon(
                            Icons.login,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Muestra un diálogo para confirmar si el usuario desea cerrar sesión.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void logoutRol(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Título del diálogo
          title: const Center(
              child: Text(
            "¿No tiene un rol en el aplicativo?",
            textAlign: TextAlign.center,
          )),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Mensaje informativo para el usuario
              const Text(
                "En este momento, su usuario aún no posee un rol asignado en el aplicativo. Será notificado por correo electrónico una vez se le haya otorgado uno.",
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
                // Botón para salir de la sesión.
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Cerrar Sesión", () {
                    Navigator.pop(context);
                    Provider.of<AppState>(context, listen: false).logout();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
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
