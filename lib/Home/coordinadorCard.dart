// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:horarios_cba/constantsDesign.dart';

// Clase CoordinadorCard, que representa una tarjeta de coordinador.
class CoordinadorCard extends StatelessWidget {
  const CoordinadorCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Tarjeta de coordinador.
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 300,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              botonClaro,
              botonOscuro,
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CustomPaint(
            size: const Size(400, 300),
            painter: CardCustomPainter(), // Clase CardCustomPainter.
            child: Stack(
              children: [
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Image.asset(
                    'assets/img/logo.png',
                    color: primaryColor.withOpacity(0.5),
                    width: 150,
                  ),
                ),
                // Columna de información
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/img/logo.png',
                        color: primaryColor[700],
                        width: 50,
                      ),
                    ),
                    // Nombre del coordinador
                    Expanded(
                      child: Text(
                        "Brayan Steven Lopez Mancera",
                        style: TextStyle(
                          color: primaryColor[700],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          // Correo del coordinador
                          const Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Text(
                                "slopezmancera@sena.edu.co",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          // Programas del coordinador
                          const Center(
                            child: Text(
                              "Programas",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          // Listado de programas del coordinador
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return const ListTile(
                                    title: Text(
                                  "Análisis y desarrollo de software.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Clase CardCustomPainter, que representa el fondo de la tarjeta de coordinador.
class CardCustomPainter extends CustomPainter {
  // Método para el dibujo de la tarjeta de coordinador.
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.32);
    path.quadraticBezierTo(size.width * 0.24, size.height * 0.45,
        size.width * 0.49, size.height * 0.45);
    path.quadraticBezierTo(
        size.width * 0.73, size.height * 0.45, size.width, size.height * 0.32);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  // Método para la actualización de la tarjeta de coordinador.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
