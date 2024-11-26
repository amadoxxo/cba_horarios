// ignore_for_file: no_logic_in_create_state, avoid_print, no_leading_underscores_for_local_identifiers, file_names, must_be_immutable
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:horarios_cba/Programa/desplegablesPrograma.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PantallaUnoPrograma extends StatefulWidget {
  TextEditingController nombreController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();

  PantallaUnoPrograma(
      {super.key,
      required this.nombreController,
      required this.codigoController,
      required this.versionController,
      required this.fechaInicioController,
      required this.fechaFinController});

  @override
  State<PantallaUnoPrograma> createState() => _PantallaUnoProgramaState(
      nombreController: nombreController,
      codigoController: codigoController,
      versionController: versionController,
      fechaInicioController: fechaInicioController,
      fechaFinController: fechaFinController);
}

class _PantallaUnoProgramaState extends State<PantallaUnoPrograma> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();

  _PantallaUnoProgramaState(
      {required this.nombreController,
      required this.codigoController,
      required this.versionController,
      required this.fechaInicioController,
      required this.fechaFinController});

  // Mascara para los campos numéricos
  var formatoNumero =
      MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Editar Programa",
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
                        nombreController.value =
                            nombreController.value.copyWith(text: val);
                      },
                      controller: nombreController,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.name,
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
                        hintText: "Nombre del programa",
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
                        codigoController.value =
                            codigoController.value.copyWith(text: val);
                      },
                      controller: codigoController,
                      obscureText: false,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.name,
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
                        hintText: "Código del programa",
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
                "Versión del programa",
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
                        versionController.value =
                            versionController.value.copyWith(text: val);
                      },
                      inputFormatters: [formatoNumero],
                      controller: versionController,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      obscureText: false,
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
                      // Validación del campo
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Se requiere este campo";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
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
                      Container(
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
                "Editar Programa",
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
                        nombreController.value =
                            nombreController.value.copyWith(text: val);
                      },
                      controller: nombreController,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.black),
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
                        hintText: "Nombre del programa",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      // Validar el campo
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Se requiere este campo";
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
                        codigoController.value =
                            codigoController.value.copyWith(text: val);
                      },
                      controller: codigoController,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.black),
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
                        hintText: "Código del programa",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      // Validar el campo
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Se requiere este campo";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Versión del programa",
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
                        versionController.value =
                            versionController.value.copyWith(text: val);
                      },
                      inputFormatters: [formatoNumero],
                      controller: versionController,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      obscureText: false,
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
                      // Validar el campo
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
                    Container(
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
              const SizedBox(height: 20),
            ],
          ),
        );
      }
    });
  }
}

class PantallaDosPrograma extends StatefulWidget {
  TextEditingController duracionLectivaController = TextEditingController();
  TextEditingController duracionProductivaController = TextEditingController();
  TextEditingController duracionTotalController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController certificacionController = TextEditingController();

  PantallaDosPrograma({
    super.key,
    required this.duracionLectivaController,
    required this.duracionProductivaController,
    required this.duracionTotalController,
    required this.tipoController,
    required this.certificacionController,
  });

  @override
  State<PantallaDosPrograma> createState() => _PantallaDosProgramaState(
        duracionLectivaController: duracionLectivaController,
        duracionProductivaController: duracionProductivaController,
        duracionTotalController: duracionTotalController,
        tipoController: tipoController,
        certificacionController: certificacionController,
      );
}

class _PantallaDosProgramaState extends State<PantallaDosPrograma> {
  TextEditingController duracionLectivaController = TextEditingController();
  TextEditingController duracionProductivaController = TextEditingController();
  TextEditingController duracionTotalController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController certificacionController = TextEditingController();

  _PantallaDosProgramaState({
    required this.duracionLectivaController,
    required this.duracionProductivaController,
    required this.duracionTotalController,
    required this.tipoController,
    required this.certificacionController,
  });

  // Mascara para los campos numéricos
  var formatoNumero =
      MaskTextInputFormatter(mask: '#####', filter: {"#": RegExp(r'[0-9]')});

  String? tipoProgramaSeleccionado;

  String? tipoCertificacionSeleccionada;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, responsive) {
      if (responsive.maxWidth >= 970) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Text(
                "Editar Programa",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Duración etapa lectiva (horas)",
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
                                duracionLectivaController.value =
                                    duracionLectivaController.value
                                        .copyWith(text: val);
                              },
                              inputFormatters: [formatoNumero],
                              controller: duracionLectivaController,
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
                        "Duración etapa productiva (horas)",
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
                              duracionProductivaController.value =
                                  duracionProductivaController.value
                                      .copyWith(text: val);
                            },
                            inputFormatters: [formatoNumero],
                            controller: duracionProductivaController,
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
                      inputFormatters: [formatoNumero],
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
              const SizedBox(height: 15),
              Tooltip(
                message: "Se requiere este campo.",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione tipo de programa",
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
                    items: tiposPrograma
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
                    value: tipoProgramaSeleccionado,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        tipoProgramaSeleccionado = value;
                        tipoController.text = tipoProgramaSeleccionado!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (tipoProgramaSeleccionado == null ||
                          tipoProgramaSeleccionado!.isEmpty) {
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
                            "Seleccione tipo de certificación",
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
                    items: tipoCertificacionesPrograma
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
                    value: tipoCertificacionSeleccionada,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        tipoCertificacionSeleccionada = value;
                        certificacionController.text =
                            tipoCertificacionSeleccionada!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (tipoCertificacionSeleccionada == null ||
                          tipoCertificacionSeleccionada!.isEmpty) {
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
                "Editar Programa",
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
                        duracionLectivaController.value =
                            duracionLectivaController.value.copyWith(text: val);
                      },
                      inputFormatters: [formatoNumero],
                      controller: duracionLectivaController,
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
                        hintText: "Duración etapa lectiva (horas)",
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
                      duracionProductivaController.value =
                          duracionProductivaController.value
                              .copyWith(text: val);
                    },
                    inputFormatters: [formatoNumero],
                    controller: duracionProductivaController,
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
                      hintText: "Duración etapa productiva (horas)",
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
                      inputFormatters: [formatoNumero],
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
              const SizedBox(height: 15),
              Tooltip(
                message: "Se requiere este campo.",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Seleccione tipo de programa",
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
                    items: tiposPrograma
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
                    value: tipoProgramaSeleccionado,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        tipoProgramaSeleccionado = value;
                        tipoController.text = tipoProgramaSeleccionado!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (tipoProgramaSeleccionado == null ||
                          tipoProgramaSeleccionado!.isEmpty) {
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
                            "Seleccione tipo de certificación",
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
                    items: tipoCertificacionesPrograma
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
                    value: tipoCertificacionSeleccionada,
                    // Manejar el cambio de selección
                    onChanged: (String? value) {
                      // Actualizar el estado con la nueva selección
                      setState(() {
                        tipoCertificacionSeleccionada = value;
                        certificacionController.text =
                            tipoCertificacionSeleccionada!;
                      });

                      // Realizar acciones adicionales según sea necesario cuando se selecciona un elemento
                      if (tipoCertificacionSeleccionada == null ||
                          tipoCertificacionSeleccionada!.isEmpty) {
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
              const SizedBox(height: 20),
            ],
          ),
        );
      }
    });
  }
}

class PantallaTresPrograma extends StatefulWidget {
  TextEditingController areaController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  PantallaTresPrograma(
      {super.key,
      required this.areaController,
      required this.descripcionController});

  @override
  State<PantallaTresPrograma> createState() => _PantallaTresProgramaState(
      areaController: areaController,
      descripcionController: descripcionController);
}

class _PantallaTresProgramaState extends State<PantallaTresPrograma> {
  TextEditingController areaController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  _PantallaTresProgramaState(
      {required this.areaController, required this.descripcionController});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, responsive) {
      if (responsive.maxWidth >= 970) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Text(
                "Editar Programa",
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
                        areaController.value =
                            areaController.value.copyWith(text: val);
                      },
                      controller: areaController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                      keyboardType: TextInputType.name,
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
                        hintText: "Área",
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
                      hintText: "Describa el programa",
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
        // Vista por defecto
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Text(
                "Editar Programa",
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
                        areaController.value =
                            areaController.value.copyWith(text: val);
                      },
                      controller: areaController,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                      keyboardType: TextInputType.name,
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
                        hintText: "Área",
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
                      hintText: "Describa el programa",
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
