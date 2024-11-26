import 'package:flutter/material.dart';
import 'package:horarios_cba/Chat/screens/buscador_screen_chat.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';


// Encabezado en la parte superior izquierda del inicio del chat en la web
class WebProfileBar extends StatelessWidget {
  final UsuarioModel usuarioAutenticado;
  const WebProfileBar({super.key, required this.usuarioAutenticado});

  // Contenedor de la barra de encabezado
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey,
          ),
        ),
        color: background1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                // Botón para ir a la pantalla de inicio
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                  child: Image.asset('assets/img/logo.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    'CBA Mosquera',
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width > 600 ? 18 : 14,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow
                          .ellipsis, // Evita desbordamiento de texto
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Botón para ir a la pantalla de busqueda de contactos
          Row(children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BuscadorScreenChat(
                              usuarioAutenticado: usuarioAutenticado,
                            )));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
