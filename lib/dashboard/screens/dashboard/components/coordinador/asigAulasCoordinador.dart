// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:horarios_cba/dashboard/listas/asignacion_aulas.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/PDF/CoordinadorPDF/pdfAsigAulasCoordinador.dart';
import 'package:horarios_cba/PDF/modalsPdf.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AsignacionAulasCoordinador extends StatefulWidget {
  final UsuarioModel usuarioAutenticado;
  const AsignacionAulasCoordinador(
      {super.key, required this.usuarioAutenticado});

  @override
  State<AsignacionAulasCoordinador> createState() =>
      _AsignacionAulasCoordinadorState();
}

class _AsignacionAulasCoordinadorState
    extends State<AsignacionAulasCoordinador> {
  late AsignacionAulasCoordinadorDataGridSource _dataGridSource;

  List<AsignacionAulas> asignacionesCoordinador = [];

  List<DataGridRow> registros = [];

  // Controlador del scroll.
  final ScrollController _scrollController1 = ScrollController();

  @override
  void initState() {
    super.initState();

    asignacionesCoordinador = listaAsignacionAulas;

    _dataGridSource = AsignacionAulasCoordinadorDataGridSource(
        asignaciones: asignacionesCoordinador);
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
            "Aulas",
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
                        width: 140,
                        columnName: 'Aula',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Aula'),
                        ),
                      ),
                      GridColumn(
                        width: 140,
                        columnName: 'Estado Aula',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Estado Aula'),
                        ),
                      ),
                      GridColumn(
                        width: 145,
                        columnName: 'Capacidad',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Capacidad'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Programa',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Programa'),
                        ),
                      ),
                      GridColumn(
                        width: 150,
                        columnName: 'Tipo Programa',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Tipo Programa'),
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
          // Botón de imprimir
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
                            builder: (context) => PdfAsigAulasCoordinadorScreen(
                                usuario: widget.usuarioAutenticado,
                                registros: registros)));
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AsignacionAulasCoordinadorDataGridSource extends DataGridSource {
  AsignacionAulasCoordinadorDataGridSource(
      {required List<AsignacionAulas> asignaciones}) {
    _asignacionesCoordinadorData = asignaciones.map<DataGridRow>((asignacion) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Aula', value: asignacion.aula),
        DataGridCell<String>(
            columnName: 'Estado Aula', value: asignacion.estadoAula),
        DataGridCell<String>(
            columnName: 'Capacidad', value: "${asignacion.capacidad} Personas"),
        DataGridCell<String>(
            columnName: 'Programa', value: asignacion.nombrePrograma),
        DataGridCell<String>(
            columnName: 'Tipo Programa', value: asignacion.tipoPrograma),
      ]);
    }).toList();
  }

  List<DataGridRow> _asignacionesCoordinadorData = [];

  @override
  List<DataGridRow> get rows => _asignacionesCoordinadorData;

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
                SvgPicture.asset(
                  "assets/icons/asignacion aulas.svg",
                  height: 30,
                  width: 30,
                  colorFilter: const ColorFilter.mode(
                      Color(0xFFA16DCC), BlendMode.srcIn),
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
              ? row.getCells()[i].value
              : Text(row.getCells()[i].value.toString()), // Formato Texto
        ),
    ]);
  }
}
