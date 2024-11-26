// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:horarios_cba/constantsDesign.dart';

class CompetenciaView extends StatefulWidget {
  const CompetenciaView({super.key});

  @override
  State<CompetenciaView> createState() => _CompetenciaViewState();
}

class _CompetenciaViewState extends State<CompetenciaView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Fondo con imagen
          Image.asset(
            "assets/img/competenciaFondo.webp",
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
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          "Competencia",
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
                        Text(
                          "Norma: 00415.",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          "Código: 0003.",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          "Nombre: Salud y seguridad en el trabajo.",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          "Duración: 5000 Horas.",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          "Programa: Análisis y desarrollo de software.",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          "Área : Tecnológia.",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
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
