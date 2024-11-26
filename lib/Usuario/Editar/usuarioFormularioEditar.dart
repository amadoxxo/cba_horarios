// ignore_for_file: file_names, avoid_print, use_build_context_synchronously, non_constant_identifier_names
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:horarios_cba/Usuario/Editar/usuarioPantallasEditar.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:image/image.dart' as im;
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:universal_platform/universal_platform.dart';

class UsuarioFormularioEditar extends StatefulWidget {
  const UsuarioFormularioEditar({
    super.key,
  });

  @override
  State<UsuarioFormularioEditar> createState() =>
      _UsuarioFormularioEditarState();
}

class _UsuarioFormularioEditarState extends State<UsuarioFormularioEditar> {
  PageController? controller;
  int currentIndex = 0;

  List<PantallasUsuario> listaPantallas = <PantallasUsuario>[];

  GlobalKey<FormState> llave1 = GlobalKey<FormState>();

  TextEditingController nombresController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController tipoDocumentoController = TextEditingController();
  TextEditingController numeroDocumentoController = TextEditingController();
  TextEditingController correoElectronicoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController rolController = TextEditingController();
  TextEditingController cargoController = TextEditingController();
  TextEditingController especialidadController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  TextEditingController voceroController = TextEditingController();
  TextEditingController titulacionController = TextEditingController();
  TextEditingController tipoInstructorController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
    _pantallasUsuario();
  }

  /// Cadena que almacena el nombre del archivo seleccionado.
  String selectFile = '';

  /// Byte array que almacena la imagen seleccionada.
  Uint8List? selectedImagenInBytes;

  // Función para seleccionar un archivo
  void _selectFile(BuildContext context, bool imagenFrom) async {
    // Abrir el selector de archivos o la galería del dispositivo
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (fileResult != null) {
      setState(() {
        // Obtener el nombre del archivo y los bytes de la imagen seleccionada
        selectFile = fileResult.files.first.name;
        selectedImagenInBytes = fileResult.files.first.bytes;
      });
    }

    try {
      // Cargar la imagen desde los bytes
      final image = im.decodeImage(selectedImagenInBytes!);

      // Verificar los casos y modificar la imagen según sea necesario
      im.Image resizedImage;
      if (image!.width > 400 && image.height > 400) {
        // Caso 1: La imagen es mayor en ambos anchos y altos
        resizedImage = im.copyResize(image, width: 400, height: 400);
      } else if (image.width > 400 && image.height <= 400) {
        // Caso 2: El ancho es mayor a 400 y el alto es menor a 400
        resizedImage = im.copyResize(image, width: 400);
      } else if (image.width <= 400 && image.height > 400) {
        // Caso 3: El ancho es menor que 400 y el alto es mayor a 400
        resizedImage = im.copyResize(image, height: 400);
      } else {
        // Caso por defecto
        resizedImage = image;
      }

      // Rotar la imagen (por ejemplo, 90 grados)
      im.Image rotatedImage = im.copyRotate(resizedImage,
          angle:
              UniversalPlatform.isIOS || UniversalPlatform.isAndroid ? 90 : 0);

      // Convertir la imagen rotada a bytes
      final rotatedImageBytes = Uint8List.fromList(im.encodeJpg(rotatedImage));

      // Comprimir la imagen redimensionada
      final compressedImage = await compressor.compress(
        ImageFileConfiguration(
          input: ImageFile(
            rawBytes: rotatedImageBytes,
            filePath: selectFile,
          ),
          config: const Configuration(
            outputType: ImageOutputType.webpThenJpg,
            useJpgPngNativeCompressor: false,
            quality: 50,
          ),
        ),
      );

      // Actualizar la imagen seleccionada con la imagen comprimida
      setState(() {
        selectedImagenInBytes = compressedImage.rawBytes;
      });

      // Si ya esta la imagen seleccionada se abre el visualizador para poderla enviar
      if (selectFile.isNotEmpty) {
        if (mounted) {
          setState(() {
            selectedImagenInBytes = selectedImagenInBytes;
            selectFile = selectFile;
          });
        }
        // Si no hay imagen seleccionada se muestra un mensaje de error
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No se seleccionó ninguna imagen.'),
        ));
      }
      // Si hay un error en el proceso de selección de imagen, se muestra un mensaje de error
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No se seleccionó ninguna imagen.'),
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    nombresController.dispose();
    apellidosController.dispose();
    tipoDocumentoController.dispose();
    numeroDocumentoController.dispose();
    correoElectronicoController.dispose();
    telefonoController.dispose();
    celularController.dispose();
    rolController.dispose();
    cargoController.dispose();
    especialidadController.dispose();
    fotoController.dispose();
    voceroController.dispose();
    titulacionController.dispose();
    tipoInstructorController.dispose();
    areaController.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // Botón para regresar a la pantalla anterior
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            ),
          ),
          actions: [
            // Botón para guardar los cambios
            if (currentIndex == listaPantallas.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 110,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Guardar",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 17,
                            fontFamily: 'Calibri-Bold'),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, responsive) {
            // Valida si el ancho de la pantalla es menor a 970
            if (responsive.maxWidth <= 970) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            primaryColor.withOpacity(0.7), BlendMode.darken),
                        image: const AssetImage(
                            'assets/img/fondoFormularioUsuario.webp'),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
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
      
                          return Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  listaPantallas[index].pantalla,
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                        flex: -1,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: List.generate(listaPantallas.length,
                                        (index) => buildDot(index, context)),
                                  ),
                                ),
                                if (currentIndex < listaPantallas.length - 1)
                                  GestureDetector(
                                    onTap: () {
                                      if (llave1.currentState!.validate() &&
                                          tipoDocumentoController
                                              .text.isNotEmpty) {
                                        controller!.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      } else {
                                        modalCamposRequeridos();
                                      }
                                    },
                                    child: Container(
                                      width: 90,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 8.0,
                                            spreadRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Continuar",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  GestureDetector(
                                    onTap: () {
                                      controller!.previousPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Container(
                                      width: 90,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 8.0,
                                            spreadRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Retroceder",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ))),
                    Expanded(
                        flex: -1,
                        child: Column(
                          children: [
                            // Imagen de perfil
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "Imagen Usuario",
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri-Bold',
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(
                                          0.5), // Color y opacidad de la sombra
                                      offset: const Offset(2,
                                          2), // Desplazamiento de la sombra (horizontal, vertical)
                                      blurRadius:
                                          3, // Radio de desenfoque de la sombra
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Center(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: selectFile.isEmpty
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.5),
                                          backgroundImage: const AssetImage(
                                            "assets/img/logo.png",
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                              MemoryImage(selectedImagenInBytes!),
                                        )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // Botón de editar imagen
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: primaryColor,
                                        offset: Offset(
                                          2.0,
                                          2.0,
                                        ),
                                        blurRadius: 3.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: primaryColor,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.edit,
                                        size: 25, color: primaryColor),
                                    onPressed: () {
                                      // Acción al presionar el botón de editar
                                      _selectFile(context, true);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: defaultPadding,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: primaryColor,
                                        offset: Offset(
                                          2.0,
                                          2.0,
                                        ),
                                        blurRadius: 3.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: primaryColor,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete,
                                        size: 25, color: primaryColor),
                                    onPressed: () {
                                      setState(() {
                                        selectFile = '';
                                        selectedImagenInBytes = null;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ))
                  ],
                ),
              );
              // Vista por defecto
            } else {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            primaryColor.withOpacity(0.7), BlendMode.darken),
                        image: const AssetImage(
                            'assets/img/fondoFormularioUsuario.webp'),
                        fit: BoxFit.cover)),
                child: Row(
                  children: [
                    // Columna izquierda
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 6,
                              child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: controller,
                                itemCount: listaPantallas.length,
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
      
                                  return Center(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          listaPantallas[index].pantalla,
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )),
                          Expanded(
                              flex: -1,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Row(
                                          children: List.generate(
                                              listaPantallas.length,
                                              (index) =>
                                                  buildDot(index, context)),
                                        ),
                                      ),
                                      if (currentIndex <
                                          listaPantallas.length - 1)
                                        GestureDetector(
                                          onTap: () {
                                            if (llave1.currentState!.validate() &&
                                                tipoDocumentoController
                                                    .text.isNotEmpty) {
                                              controller!.nextPage(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.easeInOut,
                                              );
                                            } else {
                                              modalCamposRequeridos();
                                            }
                                          },
                                          child: Container(
                                            width: 90,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.white,
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 8.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Continuar",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      else
                                        GestureDetector(
                                          onTap: () {
                                            controller!.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                          child: Container(
                                            width: 90,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.white,
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 8.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Retroceder",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    // Separador
                    Container(
                      width: 2,
                      height: MediaQuery.of(context).size.height - 150,
                      color: Colors.white,
                    ),
                    // Columna derecha
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              // Imagen de perfil
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Imagen Usuario",
                                  style: TextStyle(
                                    fontSize:
                                        24, // Incremento de tamaño de fuente
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Calibri-Bold',
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.5),
                                        offset: const Offset(3, 3),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Imagen
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: selectFile.isEmpty
                                      ? CircleAvatar(
                                          radius: 200,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.5),
                                          backgroundImage: const AssetImage(
                                            "assets/img/logo.png",
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 200,
                                          backgroundImage:
                                              MemoryImage(selectedImagenInBytes!),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // Botón de editar
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        60, // Ajusta el ancho del contenedor del botón
                                    height:
                                        60, // Ajusta la altura del contenedor del botón
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: primaryColor,
                                          offset: Offset(3.0, 3.0),
                                          blurRadius: 4.0,
                                          spreadRadius: 1.5,
                                        ),
                                        BoxShadow(
                                          color: primaryColor,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit,
                                          size: 35,
                                          color:
                                              primaryColor), // Incremento de tamaño del icono
                                      onPressed: () {
                                        // Llamado a la función
                                        _selectFile(context, true);
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width:
                                        20, // Ajusta el espacio entre los botones
                                  ),
                                  Container(
                                    width:
                                        60, // Ajusta el ancho del contenedor del botón
                                    height:
                                        60, // Ajusta la altura del contenedor del botón
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: primaryColor,
                                          offset: Offset(3.0, 3.0),
                                          blurRadius: 4.0,
                                          spreadRadius: 1.5,
                                        ),
                                        BoxShadow(
                                          color: primaryColor,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          size: 35,
                                          color:
                                              primaryColor), // Incremento de tamaño del icono
                                      onPressed: () {
                                        setState(() {
                                          selectFile = "";
                                          selectedImagenInBytes = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // Método para definir las pantallas del sitio
  void _pantallasUsuario() {
    var lista = <PantallasUsuario>[
      PantallasUsuario(
          pantalla: Form(
              key: llave1,
              child: PantallaUnoUsuario(
                nombresController: nombresController,
                apellidosController: apellidosController,
                tipoDocumentoController: tipoDocumentoController,
                numeroDocumentoController: numeroDocumentoController,
                correoElectronicoController: correoElectronicoController,
                telefonoController: telefonoController,
                celularController: celularController,
              ))),
      PantallasUsuario(
          pantalla: Form(
              child: PantallaDosUsuario(
        rolController: rolController,
        cargoController: cargoController,
        especialidadController: especialidadController,
        voceroController: voceroController,
        titulacionController: titulacionController,
        tipoInstructorController: tipoInstructorController,
        areaController: areaController,
      ))),
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
class PantallasUsuario {
  Widget pantalla;

  PantallasUsuario({required this.pantalla});
}
