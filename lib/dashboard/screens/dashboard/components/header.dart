// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:horarios_cba/dashboard/controllers/menu_app_controller.dart';
import 'package:horarios_cba/Home/chatBoton.dart';
import 'package:horarios_cba/Usuario/Editar/usuarioFormularioEditar.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/provider.dart';
import 'package:horarios_cba/responsive.dart';

import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "CBA Mosquera",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Calibri-Bold',
                  fontWeight: FontWeight.bold,
                ),
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Row(
          children: [
            const ChatBoton(),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              child: Container(
                color: primaryColor, // Color de fondo del botón.
                child: IconButton(
                  // Botón de chat.
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const UsuarioFormularioEditar()));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const ProfileCardDashboard()
          ],
        ),
      ],
    );
  }
}

class ProfileCardDashboard extends StatelessWidget {
  const ProfileCardDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Uso de Consumer para acceder al estado de la aplicación.
    return Consumer<AppState>(
      builder: (context, appState, _) {
        // Obtengo el usuario autenticado.
        final usuarioAutenticado = appState.usuarioAutenticado;
        return Container(
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
        );
      },
    );
  }
}
