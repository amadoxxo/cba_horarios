// ignore_for_file: file_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:horarios_cba/constantsDesign.dart';


class CambioEstado extends StatefulWidget {
  const CambioEstado({super.key});

  @override
  State<CambioEstado> createState() => _CambioEstadoState();
}

class _CambioEstadoState extends State<CambioEstado> {
  List<EstadoUsuario> estados = [
    const EstadoUsuario(
      titulo: 'Activo',
      valor: true,
    ),
    const EstadoUsuario(
      titulo: 'Inactivo',
      valor: false,
    ),
  ];

  TextEditingController estadoSeleccionado = TextEditingController(text: false.toString());

  String? estadoValor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Actualización del estado de usuario',
          textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
              "Asigne el estado en la aplicación para el usuario seleccionado.",
              style: TextStyle(fontSize: 17),
              textAlign: TextAlign.center),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                // Configuración del menú desplegable
                isExpanded: true,
                hint: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Estados de usuario',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: estados
                    .map((item) => DropdownMenuItem<String>(
                          value: item.valor.toString(),
                          child: Text(
                            item.titulo,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: estadoSeleccionado.text, // Valor seleccionado actualmente
                onChanged: (String? value) {
                  // Manejador de eventos cuando se selecciona un nuevo valor
                  setState(() {
                    estadoValor = value;
                    estadoSeleccionado.text = estadoValor!;
                  });
                  if (estadoValor == null || estadoValor!.isEmpty) {
                    return;
                  }
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.white,
                  ),
                  elevation: 2,
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  offset: const Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: WidgetStateProperty.all<double>(6),
                    thumbVisibility: WidgetStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                ),
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
              child: buildButton("Cambiar Estado", () {
                Navigator.pop(context);
              }),
            ),
          ],
        ),
      ],
    );
  }
}

class EstadoUsuario {
  final String titulo;
  final bool valor;

  const EstadoUsuario({required this.titulo, required this.valor});
}
