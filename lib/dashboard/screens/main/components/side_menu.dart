import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:horarios_cba/dashboard/controllers/menu_app_controller.dart';
import 'package:horarios_cba/dashboard/screens/main/main_screen_administrador.dart';
import 'package:horarios_cba/dashboard/screens/main/main_screen_aprendiz.dart';
import 'package:horarios_cba/dashboard/screens/main/main_screen_coordinador.dart';
import 'package:horarios_cba/dashboard/screens/main/main_screen_instructor.dart';
import 'package:horarios_cba/Home/homePage.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/provider.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  final UsuarioModel usuarioAutenticado;
  const SideMenu({
    super.key,
    required this.usuarioAutenticado,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/img/logo.png",
              color: primaryColor,
            ),
          ),
          DrawerListTile(
            title: "Inicio",
            svgSrc: "assets/icons/home.svg",
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          //if (usuarioAutenticado.rol == "Aprendiz")
          DrawerListTile(
            title: "Panel Aprendiz",
            svgSrc: "assets/icons/aprendiz.svg",
            press: () {
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
            },
          ),
          //if (usuarioAutenticado.rol == "Instructor")
          DrawerListTile(
            title: "Panel Instructor",
            svgSrc: "assets/icons/instructor.svg",
            press: () {
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
            },
          ),
          //if (usuarioAutenticado.rol == "Coordinador")
          DrawerListTile(
            title: "Panel Coordinador",
            svgSrc: "assets/icons/coordinador.svg",
            press: () {
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
            },
          ),
          //if (usuarioAutenticado.rol == "Administrador")
          DrawerListTile(
            title: "Panel Administrador",
            svgSrc: "assets/icons/administrador.svg",
            press: () {
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
            },
          ),
          DrawerListTile(
            title: "Cerrar Sesión",
            svgSrc: "assets/icons/logout.svg",
            press: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }
}

/// Muestra un diálogo para confirmar si el usuario desea cerrar sesión.
///
/// [context] es el contexto de la aplicación donde se mostrará el diálogo.
void logout(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // Título del diálogo
        title: const Center(
            child: Text("¿Seguro que quiere cerrar sesión?",
                textAlign: TextAlign.center)),
        alignment: Alignment.center,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
                child: buildButton("Salir", () {
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

/// Un widget que representa un elemento de lista en el menú deslizante.
///
/// Es un [StatelessWidget] que muestra un elemento de lista con un icono y un
/// texto. El widget acepta tres parámetros, [title], [svgSrc] y [press], que
/// son obligatorios.
class DrawerListTile extends StatelessWidget {
  /// Constructor del widget [DrawerListTile].
  ///
  /// Los parámetros [title], [svgSrc] y [press] son obligatorios.
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  /// Título del elemento de lista.
  final String title;

  /// Ruta del icono SVG del elemento de lista.
  final String svgSrc;

  /// Función de presionar el elemento de lista.
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap:
          10.0, // Ajusta el espaciado entre el icono y el título
      leading: SizedBox(
        height: 24, // Ajusta el tamaño del contenedor del icono
        width: 24, // Asegura que el icono sea cuadrado
        child: SvgPicture.asset(
          svgSrc,
          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(color: primaryColor, fontFamily: 'Calibri-Bold'),
      ),
    );
  }
}
