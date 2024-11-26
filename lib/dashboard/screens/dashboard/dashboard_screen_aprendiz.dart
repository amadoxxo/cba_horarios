// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:horarios_cba/dashboard/listas/desplegableFichas.dart';
import 'package:horarios_cba/dashboard/screens/dashboard/components/aprendiz/calendarioAprendiz.dart';
import 'package:horarios_cba/dashboard/screens/dashboard/components/aprendiz/fichasAprendiz.dart';
import 'package:horarios_cba/dashboard/screens/dashboard/components/aprendiz/horariosAprendiz.dart';
import 'package:horarios_cba/dashboard/screens/dashboard/components/aprendiz/programacionesAprendiz.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'components/header.dart';

class DashboardScreenAprendiz extends StatefulWidget {
  final UsuarioModel usuarioAutenticado;
  const DashboardScreenAprendiz({super.key, required this.usuarioAutenticado});

  @override
  State<DashboardScreenAprendiz> createState() =>
      _DashboardScreenAprendizState();
}

class _DashboardScreenAprendizState extends State<DashboardScreenAprendiz> {
  TextEditingController _textFichaController = TextEditingController();
  List<Desplegablefichas> fichasFiltradas = [];

  @override
  void initState() {
    super.initState();
    // Inicializa la lista filtrada con todas las fichas al principio.
    fichasFiltradas = fichasDesplegables;
  }

  void _filtrarFichas(String query) {
    if (query.isNotEmpty) {
      setState(() {
        fichasFiltradas = fichasDesplegables
            .where((ficha) =>
                ficha.codigo.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        fichasFiltradas = fichasDesplegables;
      });
    }
  }

  // Mascara para los campos numéricos
  var formatoNumero =
      MaskTextInputFormatter(mask: '#######', filter: {"#": RegExp(r'[0-9]')});

  @override
  void dispose() {
    super.dispose();
    _textFichaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 30.0, right: 30.0, top: 16.0, bottom: 16.0),
      child: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 5,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Panel aprendiz",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontFamily: 'Calibri-Bold'),
                            ),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Elija una ficha',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              TextField(
                                                inputFormatters: [
                                                  formatoNumero
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    _textFichaController,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  hintText:
                                                      'Buscar código de ficha...',
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 12.0,
                                                          horizontal: 16.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  _filtrarFichas(value);
                                                },
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 8.0),
                                              // Mostramos la lista filtrada si hay resultados
                                              if (fichasFiltradas.isNotEmpty)
                                                Container(
                                                  height:
                                                      150, // Limitamos el tamaño de la lista desplegable
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        fichasFiltradas.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final ficha =
                                                          fichasFiltradas[
                                                              index];
                                                      return ListTile(
                                                        title: Text(
                                                          ficha.codigo,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          ficha.programa,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            _textFichaController
                                                                    .text =
                                                                ficha.codigo;
                                                            // Oculta el desplegable después de seleccionar
                                                            fichasFiltradas =
                                                                [];
                                                          });
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        const CalendarioAprendiz(),
                        const SizedBox(height: defaultPadding),
                        const Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        const SizedBox(height: defaultPadding),
                        HorariosAprendiz(
                            usuarioAutenticado: widget.usuarioAutenticado),
                        const SizedBox(height: defaultPadding),
                        const Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        const SizedBox(height: defaultPadding),
                        ProgramacionesAprendiz(
                          usuarioAutenticado: widget.usuarioAutenticado,
                        ),
                        const SizedBox(height: defaultPadding),
                        const Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        const SizedBox(height: defaultPadding),
                        FichasAprendiz(
                          usuarioAutenticado: widget.usuarioAutenticado,
                        ),
                        const SizedBox(height: defaultPadding),
                      ])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
