// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:horarios_cba/constantsDesign.dart';

class ProgramaView extends StatefulWidget {
  const ProgramaView({super.key});

  @override
  State<ProgramaView> createState() => _ProgramaViewState();
}

class _ProgramaViewState extends State<ProgramaView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Fondo con imagen
          Image.asset(
            "assets/img/programaFondo.webp",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Capa verde semitransparente
          Container(
            color: primaryColor.withOpacity(
                0.5), // Ajusta el nivel de opacidad según sea necesario
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
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
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(),
                    Container(),
                  ],
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 800,
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          "Programa",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 600,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "Nombre: Análisis y desarrollo de software.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Código: 0003.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Versión: 1.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Fecha Inicio: 22/01/2024.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Fecha Fin: 22/021/2025.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Duración Lectiva: 1000 Horas.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Duración Productiva: 1000 Horas.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Duración Total: 5000 Horas.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Tipo: Técnico.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Certificación: tecnológo.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Descripción:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Mejorar el conocimientos en creacion de bases de datos ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Área: Tecnología.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "Coordinador: Juan Jose Roa Villa.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
