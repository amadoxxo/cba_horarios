// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names, no_leading_underscores_for_local_identifiers
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:horarios_cba/CSV/csvScreen.dart';
import 'package:horarios_cba/dashboard/listas/usuarios.dart';
import 'package:horarios_cba/dashboard/screens/dashboard/components/administrador/DesplegablesUsuarios/cambioEstado.dart';
import 'package:horarios_cba/dashboard/screens/dashboard/components/administrador/DesplegablesUsuarios/cambioRol.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/PDF/AdministradorPDF/pdfUsuariosAdministrador.dart';
import 'package:horarios_cba/PDF/modalsPdf.dart';
import 'package:horarios_cba/Usuario/Editar/usuarioFormularioEditar.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/responsive.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:universal_platform/universal_platform.dart';

class UsuariosAdministrador extends StatefulWidget {
  final UsuarioModel usuarioAutenticado;
  const UsuariosAdministrador({super.key, required this.usuarioAutenticado});

  @override
  State<UsuariosAdministrador> createState() => _UsuariosAdministradorState();
}

class _UsuariosAdministradorState extends State<UsuariosAdministrador> {
  late UsuariosAdministradorDataGridSource _dataGridSource;

  List<Usuarios> usuariosAdministrador = [];

  List<DataGridRow> registros = [];

  // Controlador del scroll.
  final ScrollController _scrollController1 = ScrollController();

  @override
  void initState() {
    super.initState();

    usuariosAdministrador = listaUsuarios;

    _dataGridSource = UsuariosAdministradorDataGridSource(
        usuarios: usuariosAdministrador, context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: Color(0xFFFF2F0F2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titulo de la tabla
          Text(
            "Usuarios",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontFamily: 'Calibri-Bold'),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          // Tabla
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Center(
              child: Scrollbar(
                controller: _scrollController1,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController1,
                  scrollDirection: Axis.horizontal,
                  child: SfDataGrid(
                    verticalScrollPhysics:
                        const AlwaysScrollableScrollPhysics(),
                    frozenRowsCount: 0,
                    showVerticalScrollbar: true,
                    showHorizontalScrollbar: true,
                    defaultColumnWidth: 200,
                    shrinkWrapColumns: true,
                    shrinkWrapRows: true,
                    rowsPerPage: 10,
                    source:
                        _dataGridSource, // Carga los datos de las producciones
                    selectionMode: SelectionMode.multiple,
                    showCheckboxColumn: true,
                    allowSorting: true,
                    allowFiltering: true,
                    // Cambia la firma del callback
                    onSelectionChanged: (List<DataGridRow> addedRows,
                        List<DataGridRow> removedRows) {
                      setState(() {
                        // Añadir filas a la lista de registros seleccionados
                        registros.addAll(addedRows);

                        // Eliminar filas de la lista de registros seleccionados
                        for (var row in removedRows) {
                          registros.remove(row);
                        }
                      });
                    },
                    // Columnas de la tabla
                    columns: <GridColumn>[
                      GridColumn(
                        width: 300,
                        columnName: 'Nombre',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Nombre'),
                        ),
                      ),
                      GridColumn(
                        width: 300,
                        columnName: 'Apellido',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Apellido'),
                        ),
                      ),
                      GridColumn(
                        width: 150,
                        columnName: 'Tipo Documento',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Tipo Documento'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Número Documento',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Número Documento'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Correo Electrónico',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Correo Electrónico'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Teléfono Celular',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Teléfono Celular'),
                        ),
                      ),
                      GridColumn(
                        width: 140,
                        columnName: 'Rol',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Rol'),
                        ),
                      ),
                      GridColumn(
                        width: 145,
                        columnName: 'Estado',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Estado'),
                        ),
                      ),
                      GridColumn(
                        width: 150,
                        columnName: 'Fecha Registro',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Fecha Registro'),
                        ),
                      ),
                      GridColumn(
                        allowSorting: false,
                        allowFiltering: false,
                        columnName: 'Cambiar Rol',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(''),
                        ),
                      ),
                      GridColumn(
                        allowSorting: false,
                        allowFiltering: false,
                        columnName: 'Cambiar Estado',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(''),
                        ),
                      ),
                      GridColumn(
                        allowSorting: false,
                        allowFiltering: false,
                        width: 130,
                        columnName: 'Editar',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(''),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          // Botón de imprimir y añadir
          if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid)
            Center(
              child: Column(
                children: [
                  buildButton('Imprimir Reporte', () {
                    if (registros.isEmpty) {
                      noHayPDFModal(context);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PdfUsuariosAdministradorScreen(
                                      usuario: widget.usuarioAutenticado,
                                      registros: registros)));
                    }
                  }),
                ],
              ),
            )
          else if (!Responsive.isMobile(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('Imprimir Reporte', () {
                  if (registros.isEmpty) {
                    noHayPDFModal(context);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PdfUsuariosAdministradorScreen(
                                    usuario: widget.usuarioAutenticado,
                                    registros: registros)));
                  }
                }),
                const SizedBox(
                  width: defaultPadding,
                ),
                buildButton('Añadir', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadUsersCSV(
                                usuarioAutenticado: widget.usuarioAutenticado,
                              )));
                }),
              ],
            )
          else if (Responsive.isMobile(context))
            Center(
              child: Column(
                children: [
                  buildButton('Imprimir Reporte', () {
                    if (registros.isEmpty) {
                      noHayPDFModal(context);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PdfUsuariosAdministradorScreen(
                                      usuario: widget.usuarioAutenticado,
                                      registros: registros)));
                    }
                  }),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  buildButton('Añadir', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadUsersCSV(
                                  usuarioAutenticado: widget.usuarioAutenticado,
                                )));
                  }),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class UsuariosAdministradorDataGridSource extends DataGridSource {
  UsuariosAdministradorDataGridSource(
      {required List<Usuarios> usuarios, required BuildContext context}) {
    _usuariosAdministradorData = usuarios.map<DataGridRow>((usuario) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'Nombre', value: usuario.nombre),
        DataGridCell<String>(
            columnName: 'Apellido', value: usuario.apellido),
        DataGridCell<String>(
            columnName: 'Tipo Documento', value: usuario.tipoDocumento),
        DataGridCell<String>(
            columnName: 'Número Documento', value: usuario.numeroDocumento),
        DataGridCell<String>(
            columnName: 'Correo Electrónico', value: usuario.correoElectronico),
        DataGridCell<String>(
            columnName: 'Teléfono Celular', value: usuario.telefonoCelular),
        DataGridCell<String>(columnName: 'Rol', value: usuario.rol),
        DataGridCell<String>(columnName: 'Estado', value: usuario.activo),
        DataGridCell<String>(
            columnName: 'Fecha Registro', value: usuario.fechaRegistro),
        DataGridCell<Widget>(
            columnName: 'Cambiar Rol',
            value: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CambioRol();
                  },
                );
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor)),
              child: const Text("Cambiar Rol"),
            )),
        DataGridCell<Widget>(
            columnName: 'Cambiar Estado',
            value: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CambioEstado();
                  },
                );
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor)),
              child: const Text("Cambiar Estado"),
            )),
        DataGridCell<Widget>(
            columnName: 'Editar',
            value: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UsuarioFormularioEditar()));
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor)),
              child: const Text("Editar"),
            )),
      ]);
    }).toList();
  }

  List<DataGridRow> _usuariosAdministradorData = [];

  @override
  List<DataGridRow> get rows => _usuariosAdministradorData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    // Controlador del scroll.
    final ScrollController _scrollController2 = ScrollController();

    return DataGridRowAdapter(cells: [
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Scrollbar(
          controller: _scrollController2,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _scrollController2,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    backgroundColor: _getColor(),
                    radius: 18,
                    child: Text(
                      row.getCells()[0].value[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Text(row.getCells()[0].value.toString()),
                ),
              ],
            ),
          ),
        ),
      ),
      for (int i = 1; i < row.getCells().length; i++)
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          child: (row.getCells()[i].value is Widget)
              ? row.getCells()[i].value // Texto normal
              : Text(row
                  .getCells()[i]
                  .value
                  .toString()), // Texto modificado para valores enteros
        ),
    ]);
  }
}

Color _getColor() {
  final random = Random();
  final hue = random.nextDouble() * 360;
  final saturation = random.nextDouble() * (0.5 - 0.2) + 0.2;
  final value = random.nextDouble() * (0.9 - 0.5) + 0.5;

  return HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
}
