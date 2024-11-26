// ignore_for_file: no_logic_in_create_state, avoid_print, no_leading_underscores_for_local_identifiers, file_names, must_be_immutable
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:horarios_cba/Ficha/desplegablesFicha.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PantallaUnoFicha extends StatefulWidget {
  TextEditingController programaController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController tipoOfertaController = TextEditingController();
  TextEditingController modalidadController = TextEditingController();

  PantallaUnoFicha({
    super.key,
    required this.programaController,
    required this.codigoController,
    required this.descripcionController,
    required this.modalidadController,
    required this.tipoOfertaController,
  });

  @override
  State<PantallaUnoFicha> createState() => _PantallaUnoFichaState(
        programaController: programaController,
        codigoController: codigoController,
        descripcionController: descripcionController,
        modalidadController: modalidadController,
        tipoOfertaController: tipoOfertaController,
      );
}

class _PantallaUnoFichaState extends State<PantallaUnoFicha> {
  TextEditingController programaController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController tipoOfertaController = TextEditingController();
  TextEditingController modalidadController = TextEditingController();

  _PantallaUnoFichaState({
    required this.programaController,
    required this.codigoController,
    required this.descripcionController,
    required this.modalidadController,
    required this.tipoOfertaController,
  });

  // Mascara para los campos numéricos
  var formatoNumero =
      MaskTextInputFormatter(mask: '#######', filter: {"#": RegExp(r'[0-9]')});

  String? _programaSeleccionado;

  String? tipoOfertaSeleccionada;

  String? tipoModalidadSeleccionada;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, responsive) {
      if (responsive.maxWidth >= 970) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Editar Ficha",
                style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Calibri-Bold',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Tooltip(
                message: "Se requiere este campo.",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione Programa",
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
                    items: programasFicha
                        .map((item) => DropdownMenuItem<String>(
                              value: item.valor.toString(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0), // Espaciado opcional
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
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
                                      child: Text(
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
                    value: _programaSeleccionado,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        _programaSeleccionado = value;
                        programaController.text = _programaSeleccionado!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (_programaSeleccionado == null ||
                          _programaSeleccionado!.isEmpty) {
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
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: WidgetStateProperty.all<double>(6),
                        thumbVisibility: WidgetStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Tooltip(
                message: "Se requiere este campo.",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                    child: TextFormField(
                      onChanged: (val) {
                        codigoController.value =
                            codigoController.value.copyWith(text: val);
                      },
                      inputFormatters: [formatoNumero],
                      controller: codigoController,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Código de la ficha",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      // Validación del campo
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Se requiere este campo.";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Tooltip(
                message: "Se requiere este campo.",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione tipo de oferta",
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
                    items: tipoOfertasFicha
                        .map((item) => DropdownMenuItem<String>(
                              value: item.valor,
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
                    // Valor seleccionado actualmente en el menú desplegable
                    value: tipoOfertaSeleccionada,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        tipoOfertaSeleccionada = value;
                        tipoOfertaController.text = tipoOfertaSeleccionada!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (tipoOfertaSeleccionada == null ||
                          tipoOfertaSeleccionada!.isEmpty) {
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
              const SizedBox(
                height: 15,
              ),
              Tooltip(
                message: "Se requiere este campo.",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione Modalidad",
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
                    items: modalidadesFicha
                        .map((item) => DropdownMenuItem<String>(
                              value: item.valor,
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
                    // Valor seleccionado actualmente en el menú desplegable
                    value: tipoModalidadSeleccionada,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        tipoModalidadSeleccionada = value;
                        modalidadController.text = tipoModalidadSeleccionada!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (tipoModalidadSeleccionada == null ||
                          tipoModalidadSeleccionada!.isEmpty) {
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
              const SizedBox(height: 15),
              const Text(
                "Descripción",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: TextFormField(
                    onChanged: (val) {
                      descripcionController.value =
                          descripcionController.value.copyWith(text: val);
                    },
                    controller: descripcionController,
                    maxLines: 10,
                    obscureText: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Describa la ficha",
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Editar Ficha",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Calibri-Bold',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Tooltip(
                message: "Se requiere este campo.",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione Programa",
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
                    items: programasFicha
                        .map((item) => DropdownMenuItem<String>(
                              value: item.valor.toString(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0), // Espaciado opcional
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
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
                                      child: Text(
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
                    value: _programaSeleccionado,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        _programaSeleccionado = value;
                        programaController.text = _programaSeleccionado!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (_programaSeleccionado == null ||
                          _programaSeleccionado!.isEmpty) {
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
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: WidgetStateProperty.all<double>(6),
                        thumbVisibility: WidgetStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Tooltip(
                message: "Se requiere este campo.",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                    child: TextFormField(
                      onChanged: (val) {
                        codigoController.value =
                            codigoController.value.copyWith(text: val);
                      },
                      inputFormatters: [formatoNumero],
                      controller: codigoController,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Código de la ficha",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      // Validación del campo
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Se requiere este campo.";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Tooltip(
                message: "Se requiere este campo.",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione tipo de oferta",
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
                    items: tipoOfertasFicha
                        .map((item) => DropdownMenuItem<String>(
                              value: item.valor,
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
                    // Valor seleccionado actualmente en el menú desplegable
                    value: tipoOfertaSeleccionada,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        tipoOfertaSeleccionada = value;
                        tipoOfertaController.text = tipoOfertaSeleccionada!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (tipoOfertaSeleccionada == null ||
                          tipoOfertaSeleccionada!.isEmpty) {
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
              const SizedBox(
                height: 15,
              ),
              Tooltip(
                message: "Se requiere este campo.",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione Modalidad",
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
                    items: modalidadesFicha
                        .map((item) => DropdownMenuItem<String>(
                              value: item.valor,
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
                    // Valor seleccionado actualmente en el menú desplegable
                    value: tipoModalidadSeleccionada,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        tipoModalidadSeleccionada = value;
                        modalidadController.text = tipoModalidadSeleccionada!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (tipoModalidadSeleccionada == null ||
                          tipoModalidadSeleccionada!.isEmpty) {
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
              const SizedBox(height: 15),
              const Text(
                "Descripción",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: TextFormField(
                    onChanged: (val) {
                      descripcionController.value =
                          descripcionController.value.copyWith(text: val);
                    },
                    controller: descripcionController,
                    maxLines: 10,
                    obscureText: false,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Describa la ficha",
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }
    });
  }
}

class PantallaDosFicha extends StatefulWidget {
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();
  TextEditingController liderController = TextEditingController();
  TextEditingController lugarController = TextEditingController();

  PantallaDosFicha(
      {super.key,
      required this.fechaInicioController,
      required this.fechaFinController,
      required this.liderController,
      required this.lugarController});

  @override
  State<PantallaDosFicha> createState() => _PantallaDosFichaState(
      fechaInicioController: fechaInicioController,
      fechaFinController: fechaFinController,
      liderController: liderController,
      lugarController: lugarController);
}

class _PantallaDosFichaState extends State<PantallaDosFicha> {
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();
  TextEditingController liderController = TextEditingController();
  TextEditingController lugarController = TextEditingController();

  _PantallaDosFichaState(
      {required this.fechaInicioController,
      required this.fechaFinController,
      required this.liderController,
      required this.lugarController});

  String? _liderSeleccionado;

  Future<void> _selectDateFechaInicio(BuildContext context) async {
    // Se muestra un diálogo para seleccionar la fecha
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        // Se personaliza el estilo del diálogo para que coincida con el estilo del resto del app
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primaryColor,
            colorScheme: const ColorScheme.light(primary: primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    // Si se seleccionó una fecha válida, se almacena en _selectedDateTimeEntrega
    if (pickedDate != null) {
      setState(() {
        // Solo almacenamos la fecha seleccionada con la hora a medianoche
        fechaInicioController.text = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          0, // Hora a medianoche
          0, // Minuto a cero
        ).toString();
      });
    }
  }

  Future<void> _selectDateFechaFin(BuildContext context) async {
    // Se muestra un diálogo para seleccionar la fecha
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        // Se personaliza el estilo del diálogo para que coincida con el estilo del resto del app
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primaryColor,
            colorScheme: const ColorScheme.light(primary: primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    // Si se seleccionó una fecha válida, se almacena en _selectedDateTimeEntrega
    if (pickedDate != null) {
      setState(() {
        // Solo almacenamos la fecha seleccionada con la hora a medianoche
        fechaFinController.text = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          0, // Hora a medianoche
          0, // Minuto a cero
        ).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, responsive) {
      if (responsive.maxWidth >= 970) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Text(
                "Editar Ficha",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Calibri-Bold',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Fecha de inicialización",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Tooltip(
                        message: "Se requiere este campo.",
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // Borde redondeado.
                            color: Colors.white, // Color del fondo.
                          ),
                          child: Material(
                            color: Colors
                                .transparent, // Color transparente para el Material.
                            child: InkWell(
                              onTap: () {
                                _selectDateFechaInicio(context);
                              }, // Función de presionar.
                              borderRadius: BorderRadius.circular(
                                  10), // Radio del borde redondeado.
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10), // Padding vertical.
                                child: Center(
                                  child: Text(
                                    "Seleccionar", // Texto del botón.
                                    style: TextStyle(
                                      color: Colors.black, // Color del texto.
                                      fontSize: 13, // Tamaño de fuente.
                                      fontWeight:
                                          FontWeight.bold, // Peso de fuente.
                                      fontFamily: 'Calibri-Bold', // Fuente.
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "La fecha seleccionada es: ${formatFecha(fechaInicioController.text)}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 50),
                  Column(
                    children: [
                      const Text(
                        "Fecha de finalización",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Tooltip(
                        message: "Se requiere este campo.",
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // Borde redondeado.
                            color: Colors.white, // Color del fondo.
                          ),
                          child: Material(
                            color: Colors
                                .transparent, // Color transparente para el Material.
                            child: InkWell(
                              onTap: () {
                                _selectDateFechaFin(context);
                              }, // Función de presionar.
                              borderRadius: BorderRadius.circular(
                                  10), // Radio del borde redondeado.
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10), // Padding vertical.
                                child: Center(
                                  child: Text(
                                    "Seleccionar", // Texto del botón.
                                    style: TextStyle(
                                      color: Colors.black, // Color del texto.
                                      fontSize: 13, // Tamaño de fuente.
                                      fontWeight:
                                          FontWeight.bold, // Peso de fuente.
                                      fontFamily: 'Calibri-Bold', // Fuente.
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "La fecha seleccionada es: ${formatFecha(fechaFinController.text)}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Tooltip(
                message: "Se requiere este campo.",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione líder de ficha",
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
                    items: lideresFicha
                        .map((item) => DropdownMenuItem<String>(
                              value: item.valor.toString(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0), // Espaciado opcional
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
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
                                      child: Text(
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
                    value: _liderSeleccionado,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        _liderSeleccionado = value;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (_liderSeleccionado == null ||
                          _liderSeleccionado!.isEmpty) {
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
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: WidgetStateProperty.all<double>(6),
                        thumbVisibility: WidgetStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Lugar",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Tooltip(
                message: "Se requiere este campo.",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                    child: TextFormField(
                      onChanged: (val) {
                        lugarController.value =
                            lugarController.value.copyWith(text: val);
                      },
                      controller: lugarController,
                      maxLines: 10,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      keyboardType: TextInputType.text,
                      // Validación del campo
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Se requiere este campo.";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
        // Vista por defecto
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Text(
                "Editar Ficha",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Calibri-Bold',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text(
                      "Fecha de inicialización",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Tooltip(
                      message: "Se requiere este campo.",
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10), // Borde redondeado.
                          color: Colors.white, // Color del fondo.
                        ),
                        child: Material(
                          color: Colors
                              .transparent, // Color transparente para el Material.
                          child: InkWell(
                            onTap: () {
                              _selectDateFechaInicio(context);
                            }, // Función de presionar.
                            borderRadius: BorderRadius.circular(
                                10), // Radio del borde redondeado.
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10), // Padding vertical.
                              child: Center(
                                child: Text(
                                  "Seleccionar", // Texto del botón.
                                  style: TextStyle(
                                    color: Colors.black, // Color del texto.
                                    fontSize: 13, // Tamaño de fuente.
                                    fontWeight:
                                        FontWeight.bold, // Peso de fuente.
                                    fontFamily: 'Calibri-Bold', // Fuente.
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "La fecha seleccionada es: ${formatFecha(fechaInicioController.text)}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text(
                      "Fecha de finalización",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Tooltip(
                      message: "Se requiere este campo.",
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10), // Borde redondeado.
                          color: Colors.white, // Color del fondo.
                        ),
                        child: Material(
                          color: Colors
                              .transparent, // Color transparente para el Material.
                          child: InkWell(
                            onTap: () {
                              _selectDateFechaFin(context);
                            }, // Función de presionar.
                            borderRadius: BorderRadius.circular(
                                10), // Radio del borde redondeado.
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10), // Padding vertical.
                              child: Center(
                                child: Text(
                                  "Seleccionar", // Texto del botón.
                                  style: TextStyle(
                                    color: Colors.black, // Color del texto.
                                    fontSize: 13, // Tamaño de fuente.
                                    fontWeight:
                                        FontWeight.bold, // Peso de fuente.
                                    fontFamily: 'Calibri-Bold', // Fuente.
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "La fecha seleccionada es: ${formatFecha(fechaFinController.text)}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Tooltip(
                message: "Se requiere este campo.",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione líder de ficha",
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
                    items: lideresFicha
                        .map((item) => DropdownMenuItem<String>(
                              value: item.valor.toString(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0), // Espaciado opcional
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
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
                                      child: Text(
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
                    value: _liderSeleccionado,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        _liderSeleccionado = value;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (_liderSeleccionado == null ||
                          _liderSeleccionado!.isEmpty) {
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
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: WidgetStateProperty.all<double>(6),
                        thumbVisibility: WidgetStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Lugar",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Tooltip(
                message: "Se requiere este campo.",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                    child: TextFormField(
                      onChanged: (val) {
                        lugarController.value =
                            lugarController.value.copyWith(text: val);
                      },
                      controller: lugarController,
                      maxLines: 10,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      keyboardType: TextInputType.text,
                      // Validación del campo
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Se requiere este campo.";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }
    });
  }
}
