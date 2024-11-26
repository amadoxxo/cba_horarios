// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:horarios_cba/dashboard/listas/fichas.dart';
import 'package:horarios_cba/Ficha/fichaView.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/PDF/AprendizPDF/pdfFichasAprendices.dart';
import 'package:horarios_cba/PDF/modalsPdf.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FichasAprendiz extends StatefulWidget {
  final UsuarioModel usuarioAutenticado;
  const FichasAprendiz({super.key, required this.usuarioAutenticado});

  @override
  State<FichasAprendiz> createState() => _FichasAprendizState();
}

class _FichasAprendizState extends State<FichasAprendiz> {
  late FichasAprendizDataGridSource _dataGridSource;

  List<Fichas> fichas = [];

  List<DataGridRow> registros = [];

  // Controlador del scroll.
  final ScrollController _scrollController1 = ScrollController();

  @override
  void initState() {
    super.initState();

    fichas = listaFichas;

    _dataGridSource =
        FichasAprendizDataGridSource(fichas: fichas, context: context);
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
            "Fichas",
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
                        columnName: 'Código',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Código'),
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
                        width: 140,
                        columnName: 'Modalidad',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Modalidad'),
                        ),
                      ),
                      GridColumn(
                        width: 140,
                        columnName: 'Estado',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Estado'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Lider',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Lider'),
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
                        columnName: 'Tipo Programa',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Tipo Programa'),
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
                        columnName: 'Coordinador',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Coordinador'),
                        ),
                      ),
                      GridColumn(
                        width: 130,
                        allowSorting: false,
                        allowFiltering: false,
                        columnName: 'Ver',
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
                            builder: (context) => PdfFichasAprendicesScreen(
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

class FichasAprendizDataGridSource extends DataGridSource {
  FichasAprendizDataGridSource(
      {required List<Fichas> fichas, required BuildContext context}) {
    _fichaAprendizData = fichas.map<DataGridRow>((ficha) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Código', value: ficha.codigoFicha),
        DataGridCell<String>(
            columnName: 'Fecha Inicio', value: ficha.fechaInicio),
        DataGridCell<String>(
            columnName: 'Fecha Final', value: ficha.fechaFinal),
        DataGridCell<String>(columnName: 'Modalidad', value: ficha.modalidad),
        DataGridCell<String>(columnName: 'Estado', value: ficha.estado),
        DataGridCell<String>(columnName: 'Lider', value: ficha.liderFicha),
        DataGridCell<String>(columnName: 'Programa', value: ficha.programa),
        DataGridCell<String>(
            columnName: 'Tipo Programa', value: ficha.tipoPrograma),
        DataGridCell<String>(
            columnName: 'Tipo Oferta', value: ficha.tipoOferta),
        DataGridCell<String>(
            columnName: 'Coordinador', value: ficha.nombreCoordinador),
        DataGridCell<Widget>(
            columnName: 'Ver',
            value: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FichaView()));
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor)),
              child: const Text("Ver"),
            )),
      ]);
    }).toList();
  }

  List<DataGridRow> _fichaAprendizData = [];

  @override
  List<DataGridRow> get rows => _fichaAprendizData;

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
                  "assets/icons/fichas.svg",
                  height: 30,
                  width: 30,
                  colorFilter:
                      const ColorFilter.mode(Color(0xFF3333CC), BlendMode.srcIn),
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
