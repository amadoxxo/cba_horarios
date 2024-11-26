// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:horarios_cba/dashboard/listas/instructores.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/PDF/CoordinadorPDF/pdfInstructoresCoordinador.dart';
import 'package:horarios_cba/PDF/modalsPdf.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class InstructoresCoordinador extends StatefulWidget {
  final UsuarioModel usuarioAutenticado;
  const InstructoresCoordinador({super.key, required this.usuarioAutenticado});

  @override
  State<InstructoresCoordinador> createState() =>
      _InstructoresCoordinadorState();
}

class _InstructoresCoordinadorState extends State<InstructoresCoordinador> {
  late InstructoresCoordinadorDataGridSource _dataGridSource;

  List<Instructores> instructorescoordinador = [];

  List<DataGridRow> registros = [];

  // Controlador del scroll.
  final ScrollController _scrollController1 = ScrollController();

  @override
  void initState() {
    super.initState();

    instructorescoordinador = listaInstructores;

    _dataGridSource = InstructoresCoordinadorDataGridSource(
        instructores: instructorescoordinador);
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
            "Instructores",
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
                        columnName: 'Nombre',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Nombre'),
                        ),
                      ),
                      GridColumn(
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
                        width: 154,
                        columnName: 'Teléfono Celular',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Teléfono Celular'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Titulación',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Titulación'),
                        ),
                      ),
                      GridColumn(
                        width: 150,
                        columnName: 'Cargo',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Cargo'),
                        ),
                      ),
                      GridColumn(
                        width: 154,
                        columnName: 'Especialidad',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Especialidad'),
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
                        width: 145,
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
                              builder: (context) =>
                                  PdfInstructoresCoordinadorScreen(
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

class InstructoresCoordinadorDataGridSource extends DataGridSource {
  InstructoresCoordinadorDataGridSource(
      {required List<Instructores> instructores}) {
    _instructorescoordinadorData = instructores.map<DataGridRow>((instructor) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'Nombre', value: instructor.nombre),
        DataGridCell<String>(
            columnName: 'Apellido', value: instructor.apellido),
        DataGridCell<String>(
            columnName: 'Tipo Documento', value: instructor.tipoDocumento),
        DataGridCell<String>(
            columnName: 'Número Documento', value: instructor.numeroDocumento),
        DataGridCell<String>(
            columnName: 'Correo Electrónico',
            value: instructor.correoElectronico),
        DataGridCell<String>(
            columnName: 'Teléfono Celular', value: instructor.telefonoCelular),
        DataGridCell<String>(
            columnName: 'Titulación', value: instructor.titulacion),
        DataGridCell<String>(columnName: 'Cargo', value: instructor.cargo),
        DataGridCell<String>(
            columnName: 'Especialidad', value: instructor.especialidad),
        DataGridCell<String>(
            columnName: 'Programa', value: instructor.programa),
        DataGridCell<String>(
            columnName: 'Tipo Programa', value: instructor.tipoPrograma),
      ]);
    }).toList();
  }

  List<DataGridRow> _instructorescoordinadorData = [];

  @override
  List<DataGridRow> get rows => _instructorescoordinadorData;

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
                  "assets/icons/instructores.svg",
                  height: 30,
                  width: 30,
                  colorFilter:
                      const ColorFilter.mode(Color(0xFF7FE1B0), BlendMode.srcIn),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
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
