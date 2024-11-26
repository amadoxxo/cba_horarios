// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:horarios_cba/dashboard/listas/programacion.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/PDF/CoordinadorPDF/pdfProgramacionesCoordinador.dart';
import 'package:horarios_cba/PDF/modalsPdf.dart';
import 'package:horarios_cba/Programacion/Crear/programacionFormularioCrear.dart';
import 'package:horarios_cba/Programacion/Editar/programacionFormularioEditar.dart';
import 'package:horarios_cba/Programacion/programacionView.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:horarios_cba/responsive.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProgramacionesCoordinador extends StatefulWidget {
  final UsuarioModel usuarioAutenticado;
  const ProgramacionesCoordinador(
      {super.key, required this.usuarioAutenticado});

  @override
  State<ProgramacionesCoordinador> createState() =>
      _ProgramacionesCoordinadorState();
}

class _ProgramacionesCoordinadorState extends State<ProgramacionesCoordinador> {
  late ProgramacionesCoordinadorDataGridSource _dataGridSource;

  List<Programacion> programacion = [];

  List<DataGridRow> registros = [];

  // Controlador del scroll.
  final ScrollController _scrollController1 = ScrollController();

  @override
  void initState() {
    super.initState();

    programacion = listaProgramacion;

    _dataGridSource = ProgramacionesCoordinadorDataGridSource(
        programaciones: programacion, context: context);
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
            "Programaciones",
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
                        width: 150,
                        columnName: 'Planeación',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Planeación'),
                        ),
                      ),
                      GridColumn(
                        width: 150,
                        columnName: 'Resultado Aprendizaje',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Resultado Aprendizaje'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Instructor',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Instructor'),
                        ),
                      ),
                      GridColumn(
                        width: 140,
                        columnName: 'Ficha',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Ficha'),
                        ),
                      ),
                      GridColumn(
                        width: 140,
                        columnName: 'Trimestre',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Trimestre'),
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
                        width: 140,
                        columnName: 'Tipo Oferta',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Tipo Oferta'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Competencia',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Competencia'),
                        ),
                      ),
                      GridColumn(
                        width: 145,
                        columnName: 'Días Asignados',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Días Asignados'),
                        ),
                      ),
                      GridColumn(
                        allowSorting: false,
                        allowFiltering: false,
                        width: 130,
                        columnName: 'Ver',
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
          if (!Responsive.isMobile(context))
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
                                PdfProgramacionesCoordinadorScreen(
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
                      builder: (context) => const ProgramacionFormularioCrear(),
                    ),
                  );
                }),
              ],
            ),
          if (Responsive.isMobile(context))
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
                                  PdfProgramacionesCoordinadorScreen(
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
                        builder: (context) =>
                            const ProgramacionFormularioCrear(),
                      ),
                    );
                  }),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ProgramacionesCoordinadorDataGridSource extends DataGridSource {
  ProgramacionesCoordinadorDataGridSource(
      {required List<Programacion> programaciones,
      required BuildContext context}) {
    _programacionData = programaciones.map<DataGridRow>((programacion) {
      return DataGridRow(cells: [
        DataGridCell<int>(
            columnName: 'Planeación', value: programacion.planeacion),
        DataGridCell<String>(
            columnName: 'Resultado Aprendizaje',
            value: programacion.nombreResultado),
        DataGridCell<String>(
            columnName: 'Instructor', value: programacion.nombreInstructor),
        DataGridCell<String>(
            columnName: 'Ficha', value: programacion.codigoFicha),
        DataGridCell<String>(
            columnName: 'Trimestre', value: programacion.nombreTrimestre),
        DataGridCell<String>(
            columnName: 'Programa', value: programacion.nombrePrograma),
        DataGridCell<String>(
            columnName: 'Tipo Oferta', value: programacion.tipoOferta),
        DataGridCell<String>(
            columnName: 'Competencia', value: programacion.nombreCompetencia),
        DataGridCell<String>(
            columnName: 'Días Asignados',
            value: "${programacion.diasAsignados} Días"),
        DataGridCell<Widget>(
            columnName: 'Ver',
            value: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProgramacionView()));
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor)),
              child: const Text("Ver"),
            )),
        DataGridCell<Widget>(
            columnName: 'Editar',
            value: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ProgramacionFormularioEditar()));
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor)),
              child: const Text("Editar"),
            )),
      ]);
    }).toList();
  }

  List<DataGridRow> _programacionData = [];

  @override
  List<DataGridRow> get rows => _programacionData;

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
                  "assets/icons/programacion.svg",
                  height: 30,
                  width: 30,
                  colorFilter:
                      const ColorFilter.mode(Color(0xFFFF33CC), BlendMode.srcIn),
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
