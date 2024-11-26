// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:horarios_cba/AsignacionCoordinador/desplegablesAsignacionCoordinador.dart';
import 'package:horarios_cba/constantsDesign.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TablaCoordinador extends StatefulWidget {
  const TablaCoordinador({
    super.key,
  });

  @override
  State<TablaCoordinador> createState() => _TablaCoordinadorState();
}

class _TablaCoordinadorState extends State<TablaCoordinador> {
  late TablaCoordinadorDataGridSource _dataGridSource;

  List<ProgramaCoordinador> programas = [];

  List<DataGridRow> registros = [];

  // Controlador del scroll.
  final ScrollController _scrollController1 = ScrollController();

  @override
  void initState() {
    super.initState();

    programas = listaProgramasCoordinador;

    _dataGridSource =
        TablaCoordinadorDataGridSource(programas: programas, context: context);
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
            "Programas",
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
                    verticalScrollPhysics: const AlwaysScrollableScrollPhysics(),
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
                        width: 140,
                        columnName: 'Fecha Inicio',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Fecha Inicio'),
                        ),
                      ),
                      GridColumn(
                        width: 140,
                        columnName: 'Fecha Final',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Fecha Final'),
                        ),
                      ),
                      GridColumn(
                        width: 150,
                        columnName: 'Duración Lectiva',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Duración Lectiva'),
                        ),
                      ),
                      GridColumn(
                        width: 150,
                        columnName: 'Duración Productiva',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Duración Productiva'),
                        ),
                      ),
                      GridColumn(
                        width: 150,
                        columnName: 'Duración Total',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Duración Total'),
                        ),
                      ),
                      GridColumn(
                        width: 150,
                        columnName: 'Área',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Área'),
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
        ],
      ),
    );
  }
}

class TablaCoordinadorDataGridSource extends DataGridSource {
  TablaCoordinadorDataGridSource(
      {required List<ProgramaCoordinador> programas,
      required BuildContext context}) {
    _tablaCoordinadorData = programas.map<DataGridRow>((programa) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Nombre', value: programa.nombre),
        DataGridCell<String>(
            columnName: 'Fecha Inicio', value: programa.fechaInicio),
        DataGridCell<String>(
            columnName: 'Fecha Final', value: programa.fechaFinal),
        DataGridCell<String>(
            columnName: 'Duración Lectiva',
            value: "${programa.duracionLectiva} Horas"),
        DataGridCell<String>(
            columnName: 'Duración Productiva',
            value: "${programa.duracionProductiva} Horas"),
        DataGridCell<String>(
            columnName: 'Duración Total',
            value: "${programa.duracionTotal} Horas"),
        DataGridCell<String>(columnName: 'Área', value: programa.area),
      ]);
    }).toList();
  }

  List<DataGridRow> _tablaCoordinadorData = [];

  @override
  List<DataGridRow> get rows => _tablaCoordinadorData;

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
                  "assets/icons/programas.svg",
                  height: 30,
                  width: 30,
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF642EFE), BlendMode.srcIn),
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
