// ignore_for_file: no_logic_in_create_state, avoid_print, no_leading_underscores_for_local_identifiers, file_names, must_be_immutable
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:horarios_cba/Planeacion/desplegablesPlaneacion.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PantallaUnoPlaneacion extends StatefulWidget {
  TextEditingController resultadoController = TextEditingController();
  TextEditingController trabajoDirectoController = TextEditingController();
  TextEditingController trabajoAutonomoController = TextEditingController();
  TextEditingController duracionTotalController = TextEditingController();

  PantallaUnoPlaneacion(
      {super.key,
      required this.resultadoController,
      required this.trabajoDirectoController,
      required this.trabajoAutonomoController,
      required this.duracionTotalController});

  @override
  State<PantallaUnoPlaneacion> createState() => _PantallaUnoPlaneacionState(
      resultadoController: resultadoController,
      trabajoDirectoController: trabajoDirectoController,
      trabajoAutonomoController: trabajoAutonomoController,
      duracionTotalController: duracionTotalController);
}

class _PantallaUnoPlaneacionState extends State<PantallaUnoPlaneacion> {
  TextEditingController resultadoController = TextEditingController();
  TextEditingController trabajoDirectoController = TextEditingController();
  TextEditingController trabajoAutonomoController = TextEditingController();
  TextEditingController duracionTotalController = TextEditingController();

  _PantallaUnoPlaneacionState(
      {required this.resultadoController,
      required this.trabajoDirectoController,
      required this.trabajoAutonomoController,
      required this.duracionTotalController});

  String? _programaSeleccionado;

  String? _competenciaSeleccionada;

  String? _resultadoSeleccionado;

  // Mascara para los campos numéricos
  var formatoNumero =
      MaskTextInputFormatter(mask: '#####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();

    // Añadir listeners para actualizar la duración total
    trabajoDirectoController.addListener(actualizarDuracionTotal);
    trabajoAutonomoController.addListener(actualizarDuracionTotal);
  }

  void actualizarDuracionTotal() {
    final trabajoDirecto = int.tryParse(trabajoDirectoController.text) ?? 0;
    final trabajoAutonomo = int.tryParse(trabajoAutonomoController.text) ?? 0;

    final duracionTotal = trabajoDirecto + trabajoAutonomo;

    // Actualizar el controlador de duración total
    duracionTotalController.text = duracionTotal.toString();
  }

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
                "Editar Planeación",
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
                    items: programasPlaneacion
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione Competencia",
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
                    items: competenciasPlaneacion
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
                    // Valor seleccionado actualmente en el menú desplegable
                    value: _competenciaSeleccionada,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        _competenciaSeleccionada = value;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (_competenciaSeleccionada == null ||
                          _competenciaSeleccionada!.isEmpty) {
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
                            "Seleccione resultado de aprendizaje",
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
                    items: numerosResultadoPlaneacion
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
                    value: _resultadoSeleccionado,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        _resultadoSeleccionado = value;
                        resultadoController.text = _resultadoSeleccionado!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (_resultadoSeleccionado == null ||
                          _resultadoSeleccionado!.isEmpty) {
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Trabajo Directo (horas)",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Tooltip(
                        message: "Se requiere este campo.",
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 2.0, right: 2.0),
                            child: TextFormField(
                              onChanged: (val) {
                                trabajoDirectoController.value =
                                    trabajoDirectoController.value
                                        .copyWith(text: val);
                              },
                              inputFormatters: [formatoNumero],
                              controller: trabajoDirectoController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
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
                    ],
                  ),
                  const SizedBox(width: 5),
                  Column(
                    children: [
                      const Text(
                        "Trabajo Autónomo (horas)",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          child: TextFormField(
                            onChanged: (val) {
                              trabajoAutonomoController.value =
                                  trabajoAutonomoController.value
                                      .copyWith(text: val);
                            },
                            inputFormatters: [formatoNumero],
                            controller: trabajoAutonomoController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
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
                        duracionTotalController.value =
                            duracionTotalController.value.copyWith(text: val);
                      },
                      enabled: false,
                      controller: duracionTotalController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
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
                        hintText: "Duración Total (horas)",
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
                "Editar Planeación",
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
                    items: programasPlaneacion
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione Competencia",
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
                    items: competenciasPlaneacion
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
                    // Valor seleccionado actualmente en el menú desplegable
                    value: _competenciaSeleccionada,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        _competenciaSeleccionada = value;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (_competenciaSeleccionada == null ||
                          _competenciaSeleccionada!.isEmpty) {
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
                            "Seleccione resultado de aprendizaje",
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
                    items: numerosResultadoPlaneacion
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
                    value: _resultadoSeleccionado,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        _resultadoSeleccionado = value;
                        resultadoController.text = _resultadoSeleccionado!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (_resultadoSeleccionado == null ||
                          _resultadoSeleccionado!.isEmpty) {
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
                        trabajoDirectoController.value =
                            trabajoDirectoController.value.copyWith(text: val);
                      },
                      inputFormatters: [formatoNumero],
                      controller: trabajoDirectoController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
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
                        hintText: "Trabajo Directo (horas)",
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
              const SizedBox(height: 15),
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
                      trabajoAutonomoController.value =
                          trabajoAutonomoController.value.copyWith(text: val);
                    },
                    inputFormatters: [formatoNumero],
                    controller: trabajoAutonomoController,
                    style: const TextStyle(color: Colors.black),
                    obscureText: false,
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
                      hintText: "Trabajo Autónomo (horas)",
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
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
                        duracionTotalController.value =
                            duracionTotalController.value.copyWith(text: val);
                      },
                      enabled: false,
                      controller: duracionTotalController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
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
                        hintText: "Duración total (horas)",
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
              const SizedBox(height: 20),
            ],
          ),
        );
      }
    });
  }
}

class PantallaDosPlaneacion extends StatefulWidget {
  TextEditingController horasRecomendadasController = TextEditingController();
  TextEditingController diasRecomendadosController = TextEditingController();
  TextEditingController creditosController = TextEditingController();
  TextEditingController tematicaController = TextEditingController();

  PantallaDosPlaneacion({
    super.key,
    required this.horasRecomendadasController,
    required this.diasRecomendadosController,
    required this.creditosController,
    required this.tematicaController,
  });

  @override
  State<PantallaDosPlaneacion> createState() => _PantallaDosPlaneacionState(
      horasRecomendadasController: horasRecomendadasController,
      diasRecomendadosController: diasRecomendadosController,
      creditosController: creditosController,
      tematicaController: tematicaController);
}

class _PantallaDosPlaneacionState extends State<PantallaDosPlaneacion> {
  TextEditingController horasRecomendadasController = TextEditingController();
  TextEditingController diasRecomendadosController = TextEditingController();
  TextEditingController creditosController = TextEditingController();
  TextEditingController tematicaController = TextEditingController();

  _PantallaDosPlaneacionState({
    required this.horasRecomendadasController,
    required this.diasRecomendadosController,
    required this.creditosController,
    required this.tematicaController,
  });

  // Mascara para los campos numéricos
  var formatoNumero =
      MaskTextInputFormatter(mask: '#####', filter: {"#": RegExp(r'[0-9]')});

  // Mascara para los campos numéricos decimales
  var formatoNumeroDecimal = MaskTextInputFormatter(
    mask: '#.##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, responsive) {
      if (responsive.maxWidth >= 970) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Text(
                "Editar Planeación",
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
                        horasRecomendadasController.value =
                            horasRecomendadasController.value
                                .copyWith(text: val);
                      },
                      inputFormatters: [formatoNumero],
                      controller: horasRecomendadasController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
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
                        hintText: "Horas recomendadas por semana",
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
              const SizedBox(height: 15),
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
                        diasRecomendadosController.value =
                            diasRecomendadosController.value
                                .copyWith(text: val);
                      },
                      inputFormatters: [formatoNumeroDecimal],
                      controller: diasRecomendadosController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                        hintText: "Días recomendados por semana",
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
              const SizedBox(height: 15),
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
                        creditosController.value =
                            creditosController.value.copyWith(text: val);
                      },
                      inputFormatters: [formatoNumeroDecimal],
                      controller: creditosController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                        hintText: "Créditos",
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
              const SizedBox(height: 15),
              const Text(
                "Temática",
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
                        tematicaController.value =
                            tematicaController.value.copyWith(text: val);
                      },
                      controller: tematicaController,
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
                        hintText: "Describa la temática de la planeación",
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
                "Editar Planeación",
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
                        horasRecomendadasController.value =
                            horasRecomendadasController.value
                                .copyWith(text: val);
                      },
                      inputFormatters: [formatoNumero],
                      controller: horasRecomendadasController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
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
                        hintText: "Horas recomendadas por semana",
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
              const SizedBox(height: 15),
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
                        diasRecomendadosController.value =
                            diasRecomendadosController.value
                                .copyWith(text: val);
                      },
                      inputFormatters: [formatoNumeroDecimal],
                      controller: diasRecomendadosController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                        hintText: "Días recomendados por semana",
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
              const SizedBox(height: 15),
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
                        creditosController.value =
                            creditosController.value.copyWith(text: val);
                      },
                      inputFormatters: [formatoNumeroDecimal],
                      controller: creditosController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                        hintText: "Créditos",
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
              const SizedBox(height: 15),
              const Text(
                "Temática",
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
                        tematicaController.value =
                            tematicaController.value.copyWith(text: val);
                      },
                      controller: tematicaController,
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
                        hintText: "Describa la temática de la planeación",
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

class PantallaTresPlaneacion extends StatefulWidget {
  TextEditingController productoController = TextEditingController();

  PantallaTresPlaneacion({super.key, required this.productoController});

  @override
  State<PantallaTresPlaneacion> createState() =>
      _PantallaTresPlaneacionState(productoController: productoController);
}

class _PantallaTresPlaneacionState extends State<PantallaTresPlaneacion> {
  TextEditingController productoController = TextEditingController();

  _PantallaTresPlaneacionState({required this.productoController});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, responsive) {
      if (responsive.maxWidth >= 970) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Text(
                "Editar Planeación",
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
              const Text(
                "Entregable",
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
                        productoController.value =
                            productoController.value.copyWith(text: val);
                      },
                      controller: productoController,
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
                        hintText: "Describa el entregable de la planeación",
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
                "Editar Planeación",
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
              const Text(
                "Entregable",
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
                        productoController.value =
                            productoController.value.copyWith(text: val);
                      },
                      controller: productoController,
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
                        hintText: "Describa el entregable de la planeación",
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
