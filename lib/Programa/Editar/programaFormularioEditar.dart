// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names, file_names
import 'package:flutter/material.dart';
import 'package:horarios_cba/Programa/Editar/programaPantallasEditar.dart';
import 'package:horarios_cba/constantsDesign.dart';

class ProgramaFormularioEditar extends StatefulWidget {
  const ProgramaFormularioEditar({super.key});

  @override
  State<ProgramaFormularioEditar> createState() =>
      _ProgramaFormularioEditarState();
}

class _ProgramaFormularioEditarState extends State<ProgramaFormularioEditar> {
  PageController? controller;
  int currentIndex = 0;

  List<PantallasPrograma> listaPantallas = <PantallasPrograma>[];

  TextEditingController nombreController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();
  TextEditingController duracionLectivaController = TextEditingController();
  TextEditingController duracionProductivaController = TextEditingController();
  TextEditingController duracionTotalController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController certificacionController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  String textoBoton = 'Guardar';

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
    _pantallasPrograma();
  }

  GlobalKey<FormState> llave1 = GlobalKey<FormState>();

  GlobalKey<FormState> llave2 = GlobalKey<FormState>();

  GlobalKey<FormState> llave3 = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, responsive) {
        if (responsive.maxWidth >= 970) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/img/fondoFormularioPrograma.webp'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      // Capa verde semitransparente
                      Container(
                        color: primaryColor.withOpacity(
                            0.5), // Ajusta el nivel de opacidad según sea necesario
                        width: double.infinity,
                        height: double.infinity,
                      ),
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
                              color: background1,
                            ),
                            child: Center(
                              child: Transform.translate(
                                offset: const Offset(
                                    -2, 0), // adjust the offset as needed
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: primaryColor,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: Center(
                            child: Container(
                              width: responsive.maxWidth * 0.9,
                              decoration: BoxDecoration(
                                color: const Color(0x2ADAD7D7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: PageView.builder(
                                  controller: controller,
                                  itemCount: listaPantallas.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  onPageChanged: (int index) {
                                    if (index >= currentIndex) {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    } else {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    }
                                  },
                                  itemBuilder: (context, index) {
                                    currentIndex = index;
                                    return Column(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Center(
                                            child: SingleChildScrollView(
                                                child: Column(
                                              children: [
                                                listaPantallas[index].pantalla,
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            )),
                                          ),
                                        ),
                                        Expanded(
                                            flex: -1,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Row(
                                                        children: List.generate(
                                                            listaPantallas.length,
                                                            (index) => buildDot(
                                                                index, context)),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        // Verificar si no está en la primera pantalla para mostrar el botón de retroceder
                                                        if (currentIndex > 0)
                                                          // Botón de Retroceder
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Retrocede a la pantalla anterior
                                                              if (currentIndex >
                                                                  0) {
                                                                controller!
                                                                    .previousPage(
                                                                  duration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              500),
                                                                  curve: Curves
                                                                      .easeInOut,
                                                                );
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 90,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        8.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: const Center(
                                                                child: Text(
                                                                  "Retroceder",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        const SizedBox(
                                                            width:
                                                                10), // Espaciado entre los botones
                                                        if (currentIndex ==
                                                            listaPantallas
                                                                    .length -
                                                                1)
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Si estamos en la última página
                                                              if (llave3
                                                                  .currentState!
                                                                  .validate()) {
                                                                // Cambiar el texto del botón a "Cargando" si todo está validado
                                                                setState(() {
                                                                  textoBoton =
                                                                      "Cargando";
                                                                });
            
                                                                // Aquí puedes agregar lógica adicional para enviar el formulario o realizar otra acción
                                                              } else {
                                                                modalCamposRequeridos();
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 90,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        8.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: const Center(
                                                                child: Text(
                                                                  // Cambia el texto dependiendo de si estamos en la última página o no
                                                                  "Guardar",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        else if (currentIndex ==
                                                            0)
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (llave1
                                                                      .currentState!
                                                                      .validate() &&
                                                                  fechaInicioController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                controller!
                                                                    .nextPage(
                                                                  duration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              500),
                                                                  curve: Curves
                                                                      .easeInOut,
                                                                );
                                                              } else {
                                                                modalCamposRequeridos();
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 90,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        8.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: const Center(
                                                                child: Text(
                                                                  "Continuar",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        else if (currentIndex ==
                                                            1)
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (llave2
                                                                      .currentState!
                                                                      .validate() &&
                                                                  tipoController
                                                                      .text
                                                                      .isNotEmpty &&
                                                                  certificacionController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                controller!
                                                                    .nextPage(
                                                                  duration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              500),
                                                                  curve: Curves
                                                                      .easeInOut,
                                                                );
                                                              } else {
                                                                modalCamposRequeridos();
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 90,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        8.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: const Center(
                                                                child: Text(
                                                                  "Continuar",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                )))
                                      ],
                                    );
                                  }),
                            ),
                          )),
                    ],
                  )),
            ),
          );
        } else {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/img/fondoFormularioPrograma.webp'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      // Capa verde semitransparente
                      Container(
                        color: primaryColor.withOpacity(
                            0.5), // Ajusta el nivel de opacidad según sea necesario
                        width: double.infinity,
                        height: double.infinity,
                      ),
            
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Center(
                            child: Container(
                              width: 500,
                              decoration: BoxDecoration(
                                color: const Color(0x2ADAD7D7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: PageView.builder(
                                  controller: controller,
                                  itemCount: listaPantallas.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  onPageChanged: (int index) {
                                    if (index >= currentIndex) {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    } else {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    }
                                  },
                                  itemBuilder: (context, index) {
                                    currentIndex = index;
                                    return Column(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Center(
                                            child: SingleChildScrollView(
                                                child: Column(
                                              children: [
                                                listaPantallas[index].pantalla,
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            )),
                                          ),
                                        ),
                                        Expanded(
                                            flex: -1,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Row(
                                                        children: List.generate(
                                                            listaPantallas.length,
                                                            (index) => buildDot(
                                                                index, context)),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        // Verificar si no está en la primera pantalla para mostrar el botón de retroceder
                                                        if (currentIndex > 0)
                                                          // Botón de Retroceder
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Retrocede a la pantalla anterior
                                                              if (currentIndex >
                                                                  0) {
                                                                controller!
                                                                    .previousPage(
                                                                  duration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              500),
                                                                  curve: Curves
                                                                      .easeInOut,
                                                                );
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 90,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        8.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: const Center(
                                                                child: Text(
                                                                  "Retroceder",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        const SizedBox(
                                                            width:
                                                                10), // Espaciado entre los botones
                                                        if (currentIndex ==
                                                            listaPantallas
                                                                    .length -
                                                                1)
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Si estamos en la última página
                                                              if (llave3
                                                                  .currentState!
                                                                  .validate()) {
                                                                // Cambiar el texto del botón a "Cargando" si todo está validado
                                                                setState(() {
                                                                  textoBoton =
                                                                      "Cargando";
                                                                });
            
                                                                // Aquí puedes agregar lógica adicional para enviar el formulario o realizar otra acción
                                                              } else {
                                                                modalCamposRequeridos();
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 90,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        8.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: const Center(
                                                                child: Text(
                                                                  // Cambia el texto dependiendo de si estamos en la última página o no
                                                                  "Guardar",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        else if (currentIndex ==
                                                            0)
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (llave1
                                                                      .currentState!
                                                                      .validate() &&
                                                                  fechaInicioController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                controller!
                                                                    .nextPage(
                                                                  duration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              500),
                                                                  curve: Curves
                                                                      .easeInOut,
                                                                );
                                                              } else {
                                                                modalCamposRequeridos();
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 90,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        8.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: const Center(
                                                                child: Text(
                                                                  "Continuar",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        else if (currentIndex ==
                                                            1)
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (llave2
                                                                      .currentState!
                                                                      .validate() &&
                                                                  tipoController
                                                                      .text
                                                                      .isNotEmpty &&
                                                                  certificacionController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                controller!
                                                                    .nextPage(
                                                                  duration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              500),
                                                                  curve: Curves
                                                                      .easeInOut,
                                                                );
                                                              } else {
                                                                modalCamposRequeridos();
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 90,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        8.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: const Center(
                                                                child: Text(
                                                                  "Continuar",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                ))),
                                      ],
                                    );
                                  }),
                            ),
                          )),
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
                              color: background1,
                            ),
                            child: Center(
                              child: Transform.translate(
                                offset: const Offset(
                                    -2, 0), // adjust the offset as needed
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: primaryColor,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        }
      },
    );
  }

// Método para definir las pantallas del sitio
  void _pantallasPrograma() {
    var lista = <PantallasPrograma>[
      // Primera pantalla con formulario
      PantallasPrograma(
          pantalla: Form(
        key: llave1,
        child: PantallaUnoPrograma(
            nombreController: nombreController,
            codigoController: codigoController,
            versionController: versionController,
            fechaInicioController: fechaInicioController,
            fechaFinController: fechaFinController),
      )),
      // Segunda pantalla con formulario
      PantallasPrograma(
          pantalla: Form(
        key: llave2,
        child: PantallaDosPrograma(
          duracionLectivaController: duracionLectivaController,
          duracionProductivaController: duracionProductivaController,
          duracionTotalController: duracionTotalController,
          tipoController: tipoController,
          certificacionController: certificacionController,
        ),
      )),
      // Tercera pantalla con formulario
      PantallasPrograma(
          pantalla: Form(
        key: llave3,
        child: PantallaTresPrograma(
            areaController: areaController,
            descripcionController: descripcionController),
      )),
    ];

    // Actualizar el estado con la lista de pantallas
    setState(() {
      listaPantallas = lista;
    });
  }

  // Método para construir los indicadores de página (puntos)
  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: currentIndex == index ? 24 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentIndex == index ? Colors.white : Colors.white),
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

// Clase para representar cada pantalla
class PantallasPrograma {
  Widget pantalla;

  PantallasPrograma({required this.pantalla});
}
