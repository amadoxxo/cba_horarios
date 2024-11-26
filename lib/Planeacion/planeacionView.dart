// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:horarios_cba/constantsDesign.dart';

class PlaneacionView extends StatefulWidget {
  const PlaneacionView({super.key});

  @override
  State<PlaneacionView> createState() => _PlaneacionViewState();
}

class _PlaneacionViewState extends State<PlaneacionView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Fondo con imagen
          Image.asset(
            "assets/img/planeacionesFondo.webp",
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
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 10, left: 10, bottom: 100),
                child: Container(
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
                        "Planeaciones",
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
                                "Número: 002.",
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
                                "Competencia: ",
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
                                "Aplicación de conocimientos de las ciencias naturales de acuerdo con situaciones del contexto productivo y social. ",
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
                                "Número resultado de aprendizaje: RAP 4.",
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
                                "Descripción del resultado de aprendizaje:  ",
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
                                "Identificar los principios y leyes de la física en la solución de problemas de acuerdo al contexto productivo.",
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
                                "Trabajo Directo: 2500 Horas.",
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
                                "Trabajo Autónomo: 2500 Horas.",
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
                                "Duración Total: 2500 Horas.",
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
                                "Horas Recomendadas: 8 Horas.",
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
                                "Días Recomendados: 5 Días.",
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
                                "Créditos: 1 Créditos.",
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
                                "Programa: Entrenamiento deportivo.",
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
                                "Tipo de programa: Técnico.",
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
                                "Área: Educación Física.",
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
                                "Coordinador: Mario Jeremias Poveda Suarez.",
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
                                "Temática:",
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
                                "Métodos de entrenamiento ",
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
                                "Producto:",
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
                                "Diferentes formas de organizar el entrenamiento, como el entrenamiento por intervalos, el entrenamiento de fuerza y el entrenamiento de resistencia.",
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
                      )),
                      const SizedBox(
                        height: defaultPadding,
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
