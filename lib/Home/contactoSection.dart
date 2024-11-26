// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/responsive.dart';
import 'package:latlong2/latlong.dart';

// Clase ContactoSection, que representa la sección de contacto.
class Contactosection extends StatefulWidget {
  const Contactosection({super.key});

  @override
  State<Contactosection> createState() => _ContactosectionState();
}

class _ContactosectionState extends State<Contactosection> {
  @override
  Widget build(BuildContext context) {
    // Verifica si la pantalla es escritorio o tableta.
    return Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Columna izquierda con información
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 400,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              child: Container(
                                width: 400,
                                height: 350,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                // Mapa para la ver la ubicación del CBA
                                child: FlutterMap(
                                    options: MapOptions(
                                      center: LatLng(4.695917551754739,
                                          -74.21559381912766),
                                      zoom: 16,
                                      pinchZoomThreshold: 0.0,
                                      interactiveFlags: InteractiveFlag.drag,
                                      maxZoom: 16,
                                      minZoom: 16,
                                    ),
                                    children: [
                                      openStreetMapTileLayer,
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            point: LatLng(4.695917551754739,
                                                -74.21559381912766), // Latitud y longitud del CBA
                                            width: 30,
                                            height: 30,
                                            builder: (ctx) => Container(
                                              padding: const EdgeInsets.all(3),
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: primaryColor,
                                              ),
                                              // Coloca aquí tu imagen de logo
                                              child: Image.asset(
                                                  'assets/img/logo.png'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Columna derecha con información
                  Expanded(
                    child: SizedBox(
                      height: 400,
                      // Información de la sección de contacto
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Contáctos",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                          const SizedBox(height: 10),
                          Text(
                            "Servicio Nacional de Aprendizaje SENA - Centro de Biotecnologia Agropecuaria - Regional Cundinamarca.\n- Dirección: Km 7 Via Bogota-Mosquera Cundinamarca - Telefono: (1) 5462323 Ext. 17967\n- Conmutador Nacional (57 1) 5461500\n- Atención telefónica: lunes a viernes 7:30 a.m. a 4:30 P.M",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        // Pantalla en caso de que el dispositivo sea móvil.
        : Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Columna con la información de contacto
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Contáctos",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                      const SizedBox(height: 10),
                      Text(
                        "Servicio Nacional de Aprendizaje SENA - Centro de Biotecnologia Agropecuaria - Regional Cundinamarca.\n- Dirección: Km 7 Via Bogota-Mosquera Cundinamarca - Telefono: (1) 5462323 Ext. 17967\n- Conmutador Nacional (57 1) 5461500\n- Atención telefónica: lunes a viernes 7:30 a.m. a 4:30 P.M",
                        style: TextStyle(
                          fontSize: 20,
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
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  // Mapa para la ver la ubicación del CBA
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Container(
                              width: 400,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: FlutterMap(
                                  options: MapOptions(
                                    center: LatLng(4.695917551754739,
                                        -74.21559381912766), // Latitud y longitud del CBA
                                    zoom: 16,
                                    pinchZoomThreshold: 0.0,
                                    interactiveFlags: InteractiveFlag.drag,
                                    maxZoom: 16,
                                    minZoom: 16,
                                  ),
                                  children: [
                                    openStreetMapTileLayer,
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          point: LatLng(4.695917551754739,
                                              -74.21559381912766),
                                          width: 30,
                                          height: 30,
                                          builder: (ctx) => Container(
                                            padding: const EdgeInsets.all(3),
                                            width: 50,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: primaryColor,
                                            ),
                                            // Coloca aquí tu imagen de logo
                                            child: Image.asset(
                                                'assets/img/logo.png'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}

/// Devuelve un [TileLayer] para el mapa de OpenStreetMap.
///
/// El tileLayer devuelto se puede usar en un widget de Flutter Map para mostrar
/// los tiles del mapa de OpenStreetMap.
TileLayer get openStreetMapTileLayer => TileLayer(
      // La URL de los tiles del mapa de OpenStreetMap.
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      // El nombre del paquete de usuario para el agente de usuario HTTP.
      userAgentPackageName: "dev.fleaflet.flutter_map.example",
    );
