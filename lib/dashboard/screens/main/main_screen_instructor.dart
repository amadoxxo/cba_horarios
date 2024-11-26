import 'package:flutter/material.dart';
import 'package:horarios_cba/Chatbot/chatBot.dart';
import 'package:horarios_cba/dashboard/controllers/menu_app_controller.dart';
import 'package:horarios_cba/dashboard/screens/dashboard/dashboard_screen_instructor.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/responsive.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreenInstructor extends StatelessWidget {
  final UsuarioModel usuarioAutenticado;
  const MainScreenInstructor({super.key, required this.usuarioAutenticado});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: context.read<MenuAppController>().scaffoldKey,
        drawer: SideMenu(
          usuarioAutenticado: usuarioAutenticado,
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(
                    usuarioAutenticado: usuarioAutenticado,
                  ),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: DashboardScreenInstructor(
                  usuarioAutenticado: usuarioAutenticado,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatBot()),
            );
          },
          child: const Icon(Icons.support_agent),
        ),
      ),
    );
  }
}
