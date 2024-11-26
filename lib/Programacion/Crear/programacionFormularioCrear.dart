// ignore_for_file:avoid_print, use_build_context_synchronously, prefer_final_fields, avoid_unnecessary_containers, file_names
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:horarios_cba/Programacion/desplegablesProgramacion.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProgramacionFormularioCrear extends StatefulWidget {
  const ProgramacionFormularioCrear({super.key});

  @override
  State<ProgramacionFormularioCrear> createState() =>
      _ProgramacionFormularioCrearState();
}

class _ProgramacionFormularioCrearState
    extends State<ProgramacionFormularioCrear> {
  //Validacion de formularios
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _planeacionController = TextEditingController();
  TextEditingController _fichaController = TextEditingController();
  TextEditingController _trimestreController = TextEditingController();
  TextEditingController _instructorController = TextEditingController();
  TextEditingController _diasAsignadosController = TextEditingController();

  String? _programaSeleccionado;

  String? _planeacionSeleccionada;

  String? _fichaSeleccionada;

  String? _trimestreSeleccionado;

  String? _instructorSeleccionado;

  // Mascara para los campos numéricos decimales
  var formatoNumeroDecimal = MaskTextInputFormatter(
    mask: '#.##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  // Liberar recursos al cerrar la pantalla
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, responsive) {
            // Verifica si el ancho de la pantalla es menor o igual 970
            if (responsive.maxWidth <= 970) {
              return Column(
                children: [
                  Expanded(
                      child: Container(
                    child: Stack(children: [
                      Positioned(
                        left: 10,
                        top: 10,
                        child: // Botón de retroceso
                            GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: Center(
                              child: Transform.translate(
                                offset: const Offset(
                                    -2, 0), // adjust the offset as needed
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: background1,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )),
                  Expanded(
                    flex: 8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 50),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5))),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Agregar Programación",
                                          style: TextStyle(
                                              fontFamily: 'Calibri-Bold',
                                              fontSize: 40,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 30),
                                        Form(
                                            key: formKey,
                                            child: Column(
                                              children: [
                                                Tooltip(
                                                  message:
                                                      "Se requiere este campo.",
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButton2<String>(
                                                        isExpanded: true,
                                                        hint: const Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "Seleccione Programa",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        items:
                                                            programasProgramacion
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value: item
                                                                          .valor
                                                                          .toString(),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                4.0), // Espaciado opcional
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Expanded(
                                                                              child:
                                                                                  Text(
                                                                                item.titulo,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child:
                                                                                  Text(
                                                                                item.tipo,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: const TextStyle(
                                                                                  fontSize: 11,
                                                                                  color: Colors.black54,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                        // Valor seleccionado actualmente en el menú desplegable
                                                        value:
                                                            _programaSeleccionado,
                                                        // Manejar el cambio de selección
                                                        onChanged:
                                                            (String? value) {
                                                          // Actualizar el estado con la nueva selección
                                                          setState(() {
                                                            _programaSeleccionado =
                                                                value;
                                                          });
      
                                                          // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                          if (_programaSeleccionado ==
                                                                  null ||
                                                              _programaSeleccionado!
                                                                  .isEmpty) {
                                                            return;
                                                          }
                                                        },
                                                        buttonStyleData:
                                                            ButtonStyleData(
                                                          height: 50,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 14,
                                                                  right: 14),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(14),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black26,
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        iconStyleData:
                                                            const IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                          ),
                                                          iconSize: 14,
                                                          iconEnabledColor:
                                                              Colors.black,
                                                          iconDisabledColor:
                                                              Colors.grey,
                                                        ),
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                          maxHeight: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(14),
                                                            color: Colors.white,
                                                          ),
                                                          scrollbarTheme:
                                                              ScrollbarThemeData(
                                                            radius: const Radius
                                                                .circular(40),
                                                            thickness:
                                                                WidgetStateProperty
                                                                    .all<double>(
                                                                        6),
                                                            thumbVisibility:
                                                                WidgetStateProperty
                                                                    .all<bool>(
                                                                        true),
                                                          ),
                                                        ),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(
                                                          height: 60,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      25.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Tooltip(
                                                  message:
                                                      "Se requiere este campo.",
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButton2<String>(
                                                        isExpanded: true,
                                                        hint: const Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "Seleccione Planeación",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        items:
                                                            planeacionesProgramacion
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value: item
                                                                          .valor
                                                                          .toString(),
                                                                      child: Text(
                                                                        item.titulo,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: Colors
                                                                              .black,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                        // Valor seleccionado actualmente en el menú desplegable
                                                        value:
                                                            _planeacionSeleccionada,
                                                        // Manejar el cambio de selección
                                                        onChanged:
                                                            (String? value) {
                                                          // Actualizar el estado con la nueva selección
                                                          setState(() {
                                                            _planeacionSeleccionada =
                                                                value;
                                                            _planeacionController
                                                                    .text =
                                                                _planeacionSeleccionada!;
                                                          });
      
                                                          // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                          if (_planeacionSeleccionada ==
                                                                  null ||
                                                              _planeacionSeleccionada!
                                                                  .isEmpty) {
                                                            return;
                                                          }
                                                        },
                                                        buttonStyleData:
                                                            ButtonStyleData(
                                                          height: 50,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 14,
                                                                  right: 14),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(14),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black26,
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        iconStyleData:
                                                            const IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                          ),
                                                          iconSize: 14,
                                                          iconEnabledColor:
                                                              Colors.black,
                                                          iconDisabledColor:
                                                              Colors.grey,
                                                        ),
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                          maxHeight: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(14),
                                                            color: Colors.white,
                                                          ),
                                                          scrollbarTheme:
                                                              ScrollbarThemeData(
                                                            radius: const Radius
                                                                .circular(40),
                                                            thickness:
                                                                WidgetStateProperty
                                                                    .all<double>(
                                                                        6),
                                                            thumbVisibility:
                                                                WidgetStateProperty
                                                                    .all<bool>(
                                                                        true),
                                                          ),
                                                        ),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(
                                                          height: 40,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      25.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Tooltip(
                                                  message:
                                                      "Se requiere este campo.",
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButton2<String>(
                                                        isExpanded: true,
                                                        hint: const Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "Seleccione Ficha",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        items: fichasProgramacion
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item
                                                                      .valor
                                                                      .toString(),
                                                                  child: Text(
                                                                    item.titulo,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ))
                                                            .toList(),
                                                        // Valor seleccionado actualmente en el menú desplegable
                                                        value: _fichaSeleccionada,
                                                        // Manejar el cambio de selección
                                                        onChanged:
                                                            (String? value) {
                                                          // Actualizar el estado con la nueva selección
                                                          setState(() {
                                                            _fichaSeleccionada =
                                                                value;
                                                            _fichaController
                                                                    .text =
                                                                _fichaSeleccionada!;
                                                          });
      
                                                          // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                          if (_fichaSeleccionada ==
                                                                  null ||
                                                              _fichaSeleccionada!
                                                                  .isEmpty) {
                                                            return;
                                                          }
                                                        },
                                                        buttonStyleData:
                                                            ButtonStyleData(
                                                          height: 50,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 14,
                                                                  right: 14),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(14),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black26,
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        iconStyleData:
                                                            const IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                          ),
                                                          iconSize: 14,
                                                          iconEnabledColor:
                                                              Colors.black,
                                                          iconDisabledColor:
                                                              Colors.grey,
                                                        ),
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                          maxHeight: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(14),
                                                            color: Colors.white,
                                                          ),
                                                          scrollbarTheme:
                                                              ScrollbarThemeData(
                                                            radius: const Radius
                                                                .circular(40),
                                                            thickness:
                                                                WidgetStateProperty
                                                                    .all<double>(
                                                                        6),
                                                            thumbVisibility:
                                                                WidgetStateProperty
                                                                    .all<bool>(
                                                                        true),
                                                          ),
                                                        ),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(
                                                          height: 40,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      25.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Tooltip(
                                                  message:
                                                      "Se requiere este campo.",
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButton2<String>(
                                                        isExpanded: true,
                                                        hint: const Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "Seleccione Trimestre",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        items:
                                                            trimestresProgramacion
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value: item
                                                                          .valor
                                                                          .toString(),
                                                                      child: Text(
                                                                        item.titulo,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: Colors
                                                                              .black,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                        // Valor seleccionado actualmente en el menú desplegable
                                                        value:
                                                            _trimestreSeleccionado,
                                                        // Manejar el cambio de selección
                                                        onChanged:
                                                            (String? value) {
                                                          // Actualizar el estado con la nueva selección
                                                          setState(() {
                                                            _trimestreSeleccionado =
                                                                value;
                                                            _trimestreController
                                                                    .text =
                                                                _trimestreSeleccionado!;
                                                          });
      
                                                          // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                          if (_trimestreSeleccionado ==
                                                                  null ||
                                                              _trimestreSeleccionado!
                                                                  .isEmpty) {
                                                            return;
                                                          }
                                                        },
                                                        buttonStyleData:
                                                            ButtonStyleData(
                                                          height: 50,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 14,
                                                                  right: 14),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(14),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black26,
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        iconStyleData:
                                                            const IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                          ),
                                                          iconSize: 14,
                                                          iconEnabledColor:
                                                              Colors.black,
                                                          iconDisabledColor:
                                                              Colors.grey,
                                                        ),
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                          maxHeight: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(14),
                                                            color: Colors.white,
                                                          ),
                                                          scrollbarTheme:
                                                              ScrollbarThemeData(
                                                            radius: const Radius
                                                                .circular(40),
                                                            thickness:
                                                                WidgetStateProperty
                                                                    .all<double>(
                                                                        6),
                                                            thumbVisibility:
                                                                WidgetStateProperty
                                                                    .all<bool>(
                                                                        true),
                                                          ),
                                                        ),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(
                                                          height: 40,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      25.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Tooltip(
                                                  message:
                                                      "Se requiere este campo.",
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButton2<String>(
                                                        isExpanded: true,
                                                        hint: const Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "Seleccione Instructor",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        items:
                                                            instructoresProgramacion
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value: item
                                                                          .valor
                                                                          .toString(),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                4.0), // Espaciado opcional
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Expanded(
                                                                              child:
                                                                                  Text(
                                                                                item.titulo,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child:
                                                                                  Text(
                                                                                item.subtitulo,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: const TextStyle(
                                                                                  fontSize: 11,
                                                                                  color: Colors.black54,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                        // Valor seleccionado actualmente en el menú desplegable
                                                        value:
                                                            _instructorSeleccionado,
                                                        // Manejar el cambio de selección
                                                        onChanged:
                                                            (String? value) {
                                                          // Actualizar el estado con la nueva selección
                                                          setState(() {
                                                            _instructorSeleccionado =
                                                                value;
                                                            _instructorController
                                                                    .text =
                                                                _instructorSeleccionado!;
                                                          });
      
                                                          // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                          if (_instructorSeleccionado ==
                                                                  null ||
                                                              _instructorSeleccionado!
                                                                  .isEmpty) {
                                                            return;
                                                          }
                                                        },
                                                        buttonStyleData:
                                                            ButtonStyleData(
                                                          height: 50,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 14,
                                                                  right: 14),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(14),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black26,
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        iconStyleData:
                                                            const IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                          ),
                                                          iconSize: 14,
                                                          iconEnabledColor:
                                                              Colors.black,
                                                          iconDisabledColor:
                                                              Colors.grey,
                                                        ),
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                          maxHeight: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(14),
                                                            color: Colors.white,
                                                          ),
                                                          scrollbarTheme:
                                                              ScrollbarThemeData(
                                                            radius: const Radius
                                                                .circular(40),
                                                            thickness:
                                                                WidgetStateProperty
                                                                    .all<double>(
                                                                        6),
                                                            thumbVisibility:
                                                                WidgetStateProperty
                                                                    .all<bool>(
                                                                        true),
                                                          ),
                                                        ),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(
                                                          height: 60,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      25.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Tooltip(
                                                  message:
                                                      "Se requiere este campo.",
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Colors.white),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 2.0,
                                                                right: 2.0),
                                                        child: TextFormField(
                                                          inputFormatters: [
                                                            formatoNumeroDecimal
                                                          ],
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          controller:
                                                              _diasAsignadosController,
                                                          obscureText: false,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            labelStyle:
                                                                const TextStyle(
                                                                    fontSize: 13),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .white),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .white),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            hintText:
                                                                "Días Asignados",
                                                            fillColor:
                                                                Colors.grey[200],
                                                            filled: true,
                                                          ),
                                                          // Validación del campo
                                                          validator:
                                                              (String? value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return "Se requiere este campo.";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Center(
                                                  child: Image.asset(
                                                    "assets/img/logo.png",
                                                    width: 100,
                                                    height: 100,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // Vista por defecto
              return Column(
                children: [
                  Expanded(
                      child: Container(
                    child: Stack(children: [
                      Positioned(
                        left: 10,
                        top: 10,
                        child: // Botón de retroceso
                            GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: Center(
                              child: Transform.translate(
                                offset: const Offset(
                                    -2, 0), // adjust the offset as needed
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: background1,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )),
                  Expanded(
                    flex: 8,
                    child: Center(
                      child: Container(
                        width: 950,
                        height: 550,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5))),
                        child: Row(
                          children: [
                            // Vista previa de la imagen seleccionada
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/img/fondoFormularioProgramacion.webp'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Agregar Programación",
                                        style: TextStyle(
                                            fontFamily: 'Calibri-Bold',
                                            fontSize: 40,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 30),
                                      Form(
                                        key: formKey,
                                        child: Column(
                                          children: [
                                            Tooltip(
                                              message: "Se requiere este campo.",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2<String>(
                                                    isExpanded: true,
                                                    hint: const Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Seleccione Programa",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    items: programasProgramacion
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item.valor
                                                                  .toString(),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        4.0), // Espaciado opcional
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        item.titulo,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: Colors
                                                                              .black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                        item.tipo,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color: Colors
                                                                              .black54,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ))
                                                        .toList(),
                                                    // Valor seleccionado actualmente en el menú desplegable
                                                    value: _programaSeleccionado,
                                                    // Manejar el cambio de selección
                                                    onChanged: (String? value) {
                                                      // Actualizar el estado con la nueva selección
                                                      setState(() {
                                                        _programaSeleccionado =
                                                            value;
                                                      });
      
                                                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                      if (_programaSeleccionado ==
                                                              null ||
                                                          _programaSeleccionado!
                                                              .isEmpty) {
                                                        return;
                                                      }
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 50,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                14),
                                                        border: Border.all(
                                                          color: Colors.black26,
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_forward_ios_outlined,
                                                      ),
                                                      iconSize: 14,
                                                      iconEnabledColor:
                                                          Colors.black,
                                                      iconDisabledColor:
                                                          Colors.grey,
                                                    ),
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      maxHeight: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                14),
                                                        color: Colors.white,
                                                      ),
                                                      scrollbarTheme:
                                                          ScrollbarThemeData(
                                                        radius:
                                                            const Radius.circular(
                                                                40),
                                                        thickness:
                                                            WidgetStateProperty
                                                                .all<double>(6),
                                                        thumbVisibility:
                                                            WidgetStateProperty
                                                                .all<bool>(true),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      height: 60,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Tooltip(
                                              message: "Se requiere este campo.",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2<String>(
                                                    isExpanded: true,
                                                    hint: const Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Seleccione Planeación",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    items:
                                                        planeacionesProgramacion
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item
                                                                      .valor
                                                                      .toString(),
                                                                  child: Text(
                                                                    item.titulo,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ))
                                                            .toList(),
                                                    // Valor seleccionado actualmente en el menú desplegable
                                                    value:
                                                        _planeacionSeleccionada,
                                                    // Manejar el cambio de selección
                                                    onChanged: (String? value) {
                                                      // Actualizar el estado con la nueva selección
                                                      setState(() {
                                                        _planeacionSeleccionada =
                                                            value;
                                                        _planeacionController
                                                                .text =
                                                            _planeacionSeleccionada!;
                                                      });
      
                                                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                      if (_planeacionSeleccionada ==
                                                              null ||
                                                          _planeacionSeleccionada!
                                                              .isEmpty) {
                                                        return;
                                                      }
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 50,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                14),
                                                        border: Border.all(
                                                          color: Colors.black26,
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_forward_ios_outlined,
                                                      ),
                                                      iconSize: 14,
                                                      iconEnabledColor:
                                                          Colors.black,
                                                      iconDisabledColor:
                                                          Colors.grey,
                                                    ),
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      maxHeight: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                14),
                                                        color: Colors.white,
                                                      ),
                                                      scrollbarTheme:
                                                          ScrollbarThemeData(
                                                        radius:
                                                            const Radius.circular(
                                                                40),
                                                        thickness:
                                                            WidgetStateProperty
                                                                .all<double>(6),
                                                        thumbVisibility:
                                                            WidgetStateProperty
                                                                .all<bool>(true),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      height: 40,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Tooltip(
                                              message: "Se requiere este campo.",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2<String>(
                                                    isExpanded: true,
                                                    hint: const Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Seleccione Ficha",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    items: fichasProgramacion
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item.valor
                                                                  .toString(),
                                                              child: Text(
                                                                item.titulo,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ))
                                                        .toList(),
                                                    // Valor seleccionado actualmente en el menú desplegable
                                                    value: _fichaSeleccionada,
                                                    // Manejar el cambio de selección
                                                    onChanged: (String? value) {
                                                      // Actualizar el estado con la nueva selección
                                                      setState(() {
                                                        _fichaSeleccionada =
                                                            value;
                                                        _fichaController.text =
                                                            _fichaSeleccionada!;
                                                      });
      
                                                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                      if (_fichaSeleccionada ==
                                                              null ||
                                                          _fichaSeleccionada!
                                                              .isEmpty) {
                                                        return;
                                                      }
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 50,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                14),
                                                        border: Border.all(
                                                          color: Colors.black26,
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_forward_ios_outlined,
                                                      ),
                                                      iconSize: 14,
                                                      iconEnabledColor:
                                                          Colors.black,
                                                      iconDisabledColor:
                                                          Colors.grey,
                                                    ),
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      maxHeight: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                14),
                                                        color: Colors.white,
                                                      ),
                                                      scrollbarTheme:
                                                          ScrollbarThemeData(
                                                        radius:
                                                            const Radius.circular(
                                                                40),
                                                        thickness:
                                                            WidgetStateProperty
                                                                .all<double>(6),
                                                        thumbVisibility:
                                                            WidgetStateProperty
                                                                .all<bool>(true),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      height: 40,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Tooltip(
                                              message: "Se requiere este campo.",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2<String>(
                                                    isExpanded: true,
                                                    hint: const Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Seleccione Trimestre",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    items: trimestresProgramacion
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item.valor
                                                                  .toString(),
                                                              child: Text(
                                                                item.titulo,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ))
                                                        .toList(),
                                                    // Valor seleccionado actualmente en el menú desplegable
                                                    value: _trimestreSeleccionado,
                                                    // Manejar el cambio de selección
                                                    onChanged: (String? value) {
                                                      // Actualizar el estado con la nueva selección
                                                      setState(() {
                                                        _trimestreSeleccionado =
                                                            value;
                                                        _trimestreController
                                                                .text =
                                                            _trimestreSeleccionado!;
                                                      });
      
                                                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                      if (_trimestreSeleccionado ==
                                                              null ||
                                                          _trimestreSeleccionado!
                                                              .isEmpty) {
                                                        return;
                                                      }
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 50,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                14),
                                                        border: Border.all(
                                                          color: Colors.black26,
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_forward_ios_outlined,
                                                      ),
                                                      iconSize: 14,
                                                      iconEnabledColor:
                                                          Colors.black,
                                                      iconDisabledColor:
                                                          Colors.grey,
                                                    ),
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      maxHeight: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                14),
                                                        color: Colors.white,
                                                      ),
                                                      scrollbarTheme:
                                                          ScrollbarThemeData(
                                                        radius:
                                                            const Radius.circular(
                                                                40),
                                                        thickness:
                                                            WidgetStateProperty
                                                                .all<double>(6),
                                                        thumbVisibility:
                                                            WidgetStateProperty
                                                                .all<bool>(true),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      height: 40,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Tooltip(
                                              message: "Se requiere este campo.",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2<String>(
                                                    isExpanded: true,
                                                    hint: const Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Seleccione Instructor",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    items:
                                                        instructoresProgramacion
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item
                                                                      .valor
                                                                      .toString(),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            4.0), // Espaciado opcional
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            item.titulo,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize:
                                                                                  14,
                                                                              fontWeight:
                                                                                  FontWeight.bold,
                                                                              color:
                                                                                  Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            item.subtitulo,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize:
                                                                                  11,
                                                                              color:
                                                                                  Colors.black54,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ))
                                                            .toList(),
                                                    // Valor seleccionado actualmente en el menú desplegable
                                                    value:
                                                        _instructorSeleccionado,
                                                    // Manejar el cambio de selección
                                                    onChanged: (String? value) {
                                                      // Actualizar el estado con la nueva selección
                                                      setState(() {
                                                        _instructorSeleccionado =
                                                            value;
                                                        _instructorController
                                                                .text =
                                                            _instructorSeleccionado!;
                                                      });
      
                                                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                      if (_instructorSeleccionado ==
                                                              null ||
                                                          _instructorSeleccionado!
                                                              .isEmpty) {
                                                        return;
                                                      }
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 50,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                14),
                                                        border: Border.all(
                                                          color: Colors.black26,
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_forward_ios_outlined,
                                                      ),
                                                      iconSize: 14,
                                                      iconEnabledColor:
                                                          Colors.black,
                                                      iconDisabledColor:
                                                          Colors.grey,
                                                    ),
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      maxHeight: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                14),
                                                        color: Colors.white,
                                                      ),
                                                      scrollbarTheme:
                                                          ScrollbarThemeData(
                                                        radius:
                                                            const Radius.circular(
                                                                40),
                                                        thickness:
                                                            WidgetStateProperty
                                                                .all<double>(6),
                                                        thumbVisibility:
                                                            WidgetStateProperty
                                                                .all<bool>(true),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      height: 60,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Tooltip(
                                              message: "Se requiere este campo.",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2.0,
                                                            right: 2.0),
                                                    child: TextFormField(
                                                      inputFormatters: [
                                                        formatoNumeroDecimal
                                                      ],
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                      controller:
                                                          _diasAsignadosController,
                                                      obscureText: false,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                        labelStyle:
                                                            const TextStyle(
                                                                fontSize: 13),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        hintText:
                                                            "Días Asignados",
                                                        fillColor:
                                                            Colors.grey[200],
                                                        filled: true,
                                                      ),
                                                      // Validación del campo
                                                      validator: (String? value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "Se requiere este campo.";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
        // Botón para guardar la categoría
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (formKey.currentState!.validate() &&
                _planeacionController.text.isNotEmpty &&
                _fichaController.text.isNotEmpty &&
                _trimestreController.text.isNotEmpty &&
                _instructorController.text.isNotEmpty) {
            } else {
              modalCamposRequeridos();
            }
          },
          label: const Text(
            "Guardar",
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontFamily: 'Calibri-Bold'),
          ),
          icon: const Icon(
            Icons.save,
            color: Colors.white,
          ),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }

  void modalCamposRequeridos() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Campos Requeridos!', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("Por favor, complete todos los campos requeridos.",
                  style: TextStyle(fontSize: 17), textAlign: TextAlign.center),
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
                // Botón de aceptar
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: buildButton("Aceptar", () {
                    Navigator.pop(context);
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
