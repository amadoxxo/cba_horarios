// ignore_for_file:avoid_print, use_build_context_synchronously, prefer_final_fields, avoid_unnecessary_containers, file_names
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:horarios_cba/Aula/desplegablesAula.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AulaFormularioCrear extends StatefulWidget {
  const AulaFormularioCrear({super.key});

  @override
  State<AulaFormularioCrear> createState() => _AulaFormularioCrearState();
}

class _AulaFormularioCrearState extends State<AulaFormularioCrear> {
  //Validacion de formularios
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _capacidadController = TextEditingController();
  TextEditingController _ubicacionController = TextEditingController();
  TextEditingController _estadoController = TextEditingController();

  String? _estadoSeleccionado;

  // Mascara para los campos numéricos
  var formatoNumero =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

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
                                          "Agregar Aula",
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
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          controller:
                                                              _nombreController,
                                                          obscureText: false,
                                                          keyboardType:
                                                              TextInputType.name,
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
                                                                "Nombre del aula",
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
                                                            formatoNumero
                                                          ],
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          controller:
                                                              _capacidadController,
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
                                                            hintText: "Capacidad",
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
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          controller:
                                                              _ubicacionController,
                                                          obscureText: false,
                                                          keyboardType:
                                                              TextInputType.name,
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
                                                            hintText: "Ubicación",
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
                                                                "Seleccione estado del aula",
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
                                                        items: estadosAula
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
                                                            _estadoSeleccionado,
                                                        // Manejar el cambio de selección
                                                        onChanged:
                                                            (String? value) {
                                                          // Actualizar el estado con la nueva selección
                                                          setState(() {
                                                            _estadoSeleccionado =
                                                                value;
                                                            _estadoController
                                                                    .text =
                                                                _estadoSeleccionado!;
                                                          });
      
                                                          // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                          if (_estadoSeleccionado ==
                                                                  null ||
                                                              _estadoSeleccionado!
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
                                        'assets/img/fondoFormularioAula.webp'),
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
                                        "Agregar Aula",
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
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                      controller:
                                                          _nombreController,
                                                      obscureText: false,
                                                      keyboardType:
                                                          TextInputType.name,
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
                                                            "Nombre del aula",
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
                                                        formatoNumero
                                                      ],
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                      controller:
                                                          _capacidadController,
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
                                                        hintText: "Capacidad",
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
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                      controller:
                                                          _ubicacionController,
                                                      obscureText: false,
                                                      keyboardType:
                                                          TextInputType.name,
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
                                                        hintText: "Ubicación",
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
                                                            "Seleccione estado del aula",
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
                                                    items: estadosAula
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
                                                    value: _estadoSeleccionado,
                                                    // Manejar el cambio de selección
                                                    onChanged: (String? value) {
                                                      // Actualizar el estado con la nueva selección
                                                      setState(() {
                                                        _estadoSeleccionado =
                                                            value;
                                                        _estadoController.text =
                                                            _estadoSeleccionado!;
                                                      });
      
                                                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                                                      if (_estadoSeleccionado ==
                                                              null ||
                                                          _estadoSeleccionado!
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
                _estadoController.text.isNotEmpty) {
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
