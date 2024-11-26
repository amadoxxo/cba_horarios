// ignore_for_file: file_names, must_be_immutable, no_logic_in_create_state, use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:horarios_cba/Usuario/desplegablesUsuario.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PantallaUnoUsuario extends StatefulWidget {
  TextEditingController nombresController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController tipoDocumentoController = TextEditingController();
  TextEditingController numeroDocumentoController = TextEditingController();
  TextEditingController correoElectronicoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController celularController = TextEditingController();

  PantallaUnoUsuario({
    super.key,
    required this.nombresController,
    required this.apellidosController,
    required this.tipoDocumentoController,
    required this.numeroDocumentoController,
    required this.correoElectronicoController,
    required this.telefonoController,
    required this.celularController,
  });

  @override
  State<PantallaUnoUsuario> createState() => _PantallaUnoUsuarioState(
        nombresController: nombresController,
        apellidosController: apellidosController,
        tipoDocumentoController: tipoDocumentoController,
        numeroDocumentoController: numeroDocumentoController,
        correoElectronicoController: correoElectronicoController,
        telefonoController: telefonoController,
        celularController: celularController,
      );
}

class _PantallaUnoUsuarioState extends State<PantallaUnoUsuario> {
  TextEditingController nombresController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController tipoDocumentoController = TextEditingController();
  TextEditingController numeroDocumentoController = TextEditingController();
  TextEditingController correoElectronicoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController celularController = TextEditingController();

  _PantallaUnoUsuarioState({
    required this.nombresController,
    required this.apellidosController,
    required this.tipoDocumentoController,
    required this.numeroDocumentoController,
    required this.correoElectronicoController,
    required this.telefonoController,
    required this.celularController,
  });

  // Máscara para el número de teléfono.
  var inputtelefonoCelular = MaskTextInputFormatter(
      mask: "### ### ####", filter: {"#": RegExp(r'[0-9]')});

  var inputtelefonoFijo =
      MaskTextInputFormatter(mask: "### ####", filter: {"#": RegExp(r'[0-9]')});

  var inputDocumento = MaskTextInputFormatter(
      mask: "############", filter: {"#": RegExp(r'[0-9]')});

  String? seleccionarTipoDocumento;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, responsive) {
      if (responsive.maxWidth <= 500) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              // Titulo
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                child: Text(
                  "Editar Usuario",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              // Campo de texto para los nombres
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
                        nombresController.value =
                            nombresController.value.copyWith(text: val);
                      },
                      controller: nombresController,
                      keyboardType: TextInputType.number,
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
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: "Nombres Completos"),
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
              // Campo de texto para los apellidos
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
                        apellidosController.value =
                            apellidosController.value.copyWith(text: val);
                      },
                      controller: apellidosController,
                      keyboardType: TextInputType.number,
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
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: "Apellidos Completos"),
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
              // Campo de texto para la identificación
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Identificación",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // DropdownButton para el tipo de documento
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Tooltip(
                    message: "Se requiere este campo.",
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          // Configuración del DropdownButton
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Seleccione tipo de documento',
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
                          items: optionsTipoDocumento
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
                          value: seleccionarTipoDocumento,
                          onChanged: (String? value) {
                            // Actualización del valor seleccionado
                            setState(() {
                              seleccionarTipoDocumento = value;
                              tipoDocumentoController.text =
                                  seleccionarTipoDocumento!;
                            });
                            // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                            if (seleccionarTipoDocumento == null ||
                                seleccionarTipoDocumento!.isEmpty) {
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
                              thumbVisibility:
                                  WidgetStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                          ),
                        ),
                      ),
                    ),
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
                            numeroDocumentoController.value =
                                numeroDocumentoController.value
                                    .copyWith(text: val);
                          },
                          inputFormatters: [inputDocumento],
                          controller: numeroDocumentoController,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
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
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText:
                                  "N° Documento (NIT sin guion y dígito de verificación)"),
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
              const SizedBox(height: 20),
              // Campo de texto para el correo
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
                        correoElectronicoController.value =
                            correoElectronicoController.value
                                .copyWith(text: val);
                      },
                      controller: correoElectronicoController,
                      keyboardType: TextInputType.number,
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
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: "Correo Electrónico"),
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
              // Información de contacto
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Información de contácto",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Campo de texto para el telefono y telefono celular
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
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
                            telefonoController.value =
                                telefonoController.value.copyWith(text: val);
                          },
                          controller: telefonoController,
                          inputFormatters: [inputtelefonoFijo],
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
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
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "Teléfono Fijo (600-1234567)"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Flexible(
                    child: Tooltip(
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
                              celularController.value =
                                  celularController.value.copyWith(text: val);
                            },
                            controller: celularController,
                            inputFormatters: [inputtelefonoCelular],
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            style: const TextStyle(color: Colors.black),
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
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText: "Teléfono Celular (+57)"),
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
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titulo
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                child: Text(
                  "Editar Usuario",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              // Campo de nombres
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
                        nombresController.value =
                            nombresController.value.copyWith(text: val);
                      },
                      controller: nombresController,
                      keyboardType: TextInputType.number,
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
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Nombres Completos",
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
              // Campo de apellidos
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
                        apellidosController.value =
                            apellidosController.value.copyWith(text: val);
                      },
                      controller: apellidosController,
                      keyboardType: TextInputType.number,
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
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: "Apellidos Completos"),
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
              // Campos de identificación
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Identificación",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Tooltip(
                      message: "Se requiere este campo.",
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            // Configuración del DropdownButton
                            isExpanded: true,
                            hint: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Seleccione tipo de documento',
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
                            items: optionsTipoDocumento
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
                            value: seleccionarTipoDocumento,
                            onChanged: (String? value) {
                              // Actualización del valor seleccionado
                              setState(() {
                                seleccionarTipoDocumento = value;
                                tipoDocumentoController.text =
                                    seleccionarTipoDocumento!;
                              });
                              // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                              if (seleccionarTipoDocumento == null ||
                                  seleccionarTipoDocumento!.isEmpty) {
                                return;
                              }
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                                thumbVisibility:
                                    WidgetStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Tooltip(
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
                              numeroDocumentoController.value =
                                  numeroDocumentoController.value
                                      .copyWith(text: val);
                            },
                            inputFormatters: [inputDocumento],
                            controller: numeroDocumentoController,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            style: const TextStyle(color: Colors.black),
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
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText:
                                    "N° Documento (NIT sin guion y dígito de verificación)"),
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
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Campo de correo electronico
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
                        correoElectronicoController.value =
                            correoElectronicoController.value
                                .copyWith(text: val);
                      },
                      controller: correoElectronicoController,
                      keyboardType: TextInputType.number,
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
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: "Correo Electrónico"),
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
              // Información de contacto
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Información de contácto",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Campos de teléfono y celular
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
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
                            telefonoController.value =
                                telefonoController.value.copyWith(text: val);
                          },
                          controller: telefonoController,
                          inputFormatters: [inputtelefonoFijo],
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
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
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "Teléfono Fijo (600-1234567)"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Flexible(
                    child: Tooltip(
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
                              celularController.value =
                                  celularController.value.copyWith(text: val);
                            },
                            controller: celularController,
                            inputFormatters: [inputtelefonoCelular],
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            style: const TextStyle(color: Colors.black),
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
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText: "Teléfono Celular (+57)"),
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
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      }
    });
  }
}

class PantallaDosUsuario extends StatefulWidget {
  TextEditingController rolController = TextEditingController();
  TextEditingController cargoController = TextEditingController();
  TextEditingController especialidadController = TextEditingController();
  TextEditingController voceroController = TextEditingController();
  TextEditingController titulacionController = TextEditingController();
  TextEditingController tipoInstructorController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  PantallaDosUsuario(
      {super.key,
      required this.rolController,
      required this.cargoController,
      required this.especialidadController,
      required this.voceroController,
      required this.titulacionController,
      required this.tipoInstructorController,
      required this.areaController});

  @override
  State<PantallaDosUsuario> createState() => _PantallaDosUsuarioState(
      rolController: rolController,
      cargoController: cargoController,
      especialidadController: especialidadController,
      voceroController: voceroController,
      titulacionController: titulacionController,
      tipoInstructorController: tipoInstructorController,
      areaController: areaController);
}

class _PantallaDosUsuarioState extends State<PantallaDosUsuario> {
  TextEditingController rolController = TextEditingController();
  TextEditingController cargoController = TextEditingController();
  TextEditingController especialidadController = TextEditingController();
  TextEditingController voceroController = TextEditingController();
  TextEditingController titulacionController = TextEditingController();
  TextEditingController tipoInstructorController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  _PantallaDosUsuarioState(
      {required this.rolController,
      required this.cargoController,
      required this.especialidadController,
      required this.voceroController,
      required this.titulacionController,
      required this.tipoInstructorController,
      required this.areaController});

  bool checkVocero = false;

  String? seleccionarRol;

  String? seleccionarTipoInstructor;

  String? seleccionarArea;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, responsive) {
      if (responsive.maxWidth <= 500) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              // Titulo
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                child: Text(
                  "Editar Usuario",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    // Configuración del DropdownButton
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Seleccione tipo de rol',
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
                    items: roles
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
                    value: seleccionarRol,
                    onChanged: (String? value) {
                      // Actualización del valor seleccionado
                      setState(() {
                        seleccionarRol = value;
                        rolController.text = seleccionarRol!;
                      });
                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (seleccionarRol == null || seleccionarRol!.isEmpty) {
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
              const SizedBox(
                height: 20,
              ),
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
                      cargoController.value =
                          cargoController.value.copyWith(text: val);
                    },
                    controller: cargoController,
                    keyboardType: TextInputType.number,
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
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Cargo"),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Información Aprendiz",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿Usted es vocero?",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(
                              0.5), // Color y opacidad de la sombra
                          offset: const Offset(2,
                              2), // Desplazamiento de la sombra (horizontal, vertical)
                          blurRadius: 3, // Radio de desenfoque de la sombra
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Checkbox(
                    side: const BorderSide(color: Colors.white, width: 2.0),
                    value: checkVocero, // Estado actual del checkbox
                    onChanged: (bool? newValue) {
                      // Función que se ejecuta cuando el usuario cambia el estado del checkbox
                      setState(() {
                        // Actualiza el estado del widget
                        checkVocero = newValue ??
                            false; // Cambia el estado del checkbox al nuevo valor
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Información Instructor",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
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
                            especialidadController.value =
                                especialidadController.value
                                    .copyWith(text: val);
                          },
                          controller: especialidadController,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
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
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "Especialidad"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Flexible(
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
                            titulacionController.value =
                                titulacionController.value.copyWith(text: val);
                          },
                          controller: titulacionController,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
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
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "Titulación"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        // Configuración del DropdownButton
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Seleccione tipo de instructor',
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
                        items: tipoInstructores
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
                        value: seleccionarTipoInstructor,
                        onChanged: (String? value) {
                          // Actualización del valor seleccionado
                          setState(() {
                            seleccionarTipoInstructor = value;
                            tipoInstructorController.text =
                                seleccionarTipoInstructor!;
                          });
                          // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                          if (seleccionarTipoInstructor == null ||
                              seleccionarTipoInstructor!.isEmpty) {
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
                            thumbVisibility:
                                WidgetStateProperty.all<bool>(true),
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
                    height: defaultPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        // Configuración del DropdownButton
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Seleccione Área',
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
                        items: areaInstructores
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
                        value: seleccionarArea,
                        onChanged: (String? value) {
                          // Actualización del valor seleccionado
                          setState(() {
                            seleccionarArea = value;
                            areaController.text = seleccionarArea!;
                          });
                          // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                          if (seleccionarArea == null ||
                              seleccionarArea!.isEmpty) {
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
                            thumbVisibility:
                                WidgetStateProperty.all<bool>(true),
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
              const SizedBox(height: 20),
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titulo
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                child: Text(
                  "Editar Usuario",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    // Configuración del DropdownButton
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Seleccione tipo de rol',
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
                    items: roles
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
                    value: seleccionarRol,
                    onChanged: (String? value) {
                      // Actualización del valor seleccionado
                      setState(() {
                        seleccionarRol = value;
                        rolController.text = seleccionarRol!;
                      });
                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (seleccionarRol == null || seleccionarRol!.isEmpty) {
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
              const SizedBox(
                height: 20,
              ),
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
                      cargoController.value =
                          cargoController.value.copyWith(text: val);
                    },
                    controller: cargoController,
                    keyboardType: TextInputType.number,
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
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Cargo"),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Información Aprendiz",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿Usted es vocero?",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(
                              0.5), // Color y opacidad de la sombra
                          offset: const Offset(2,
                              2), // Desplazamiento de la sombra (horizontal, vertical)
                          blurRadius: 3, // Radio de desenfoque de la sombra
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Checkbox(
                    side: const BorderSide(color: Colors.white, width: 2.0),
                    value: checkVocero, // Estado actual del checkbox
                    onChanged: (bool? newValue) {
                      // Función que se ejecuta cuando el usuario cambia el estado del checkbox
                      setState(() {
                        // Actualiza el estado del widget
                        checkVocero = newValue ??
                            false; // Cambia el estado del checkbox al nuevo valor
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Información Instructor",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri-Bold',
                    shadows: [
                      Shadow(
                        color: Colors.black
                            .withOpacity(0.5), // Color y opacidad de la sombra
                        offset: const Offset(2,
                            2), // Desplazamiento de la sombra (horizontal, vertical)
                        blurRadius: 3, // Radio de desenfoque de la sombra
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
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
                            especialidadController.value =
                                especialidadController.value
                                    .copyWith(text: val);
                          },
                          controller: especialidadController,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
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
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "Especialidad"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Flexible(
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
                            titulacionController.value =
                                titulacionController.value.copyWith(text: val);
                          },
                          controller: titulacionController,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
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
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "Titulación"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          // Configuración del DropdownButton
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Seleccione tipo de instructor',
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
                          items: tipoInstructores
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
                          value: seleccionarTipoInstructor,
                          onChanged: (String? value) {
                            // Actualización del valor seleccionado
                            setState(() {
                              seleccionarTipoInstructor = value;
                              tipoInstructorController.text =
                                  seleccionarTipoInstructor!;
                            });
                            // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                            if (seleccionarTipoInstructor == null ||
                                seleccionarTipoInstructor!.isEmpty) {
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
                              thumbVisibility:
                                  WidgetStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          // Configuración del DropdownButton
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Seleccione Área',
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
                          items: areaInstructores
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
                          value: seleccionarArea,
                          onChanged: (String? value) {
                            // Actualización del valor seleccionado
                            setState(() {
                              seleccionarArea = value;
                              areaController.text = seleccionarArea!;
                            });
                            // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                            if (seleccionarArea == null ||
                                seleccionarArea!.isEmpty) {
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
                              thumbVisibility:
                                  WidgetStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }
    });
  }
}
