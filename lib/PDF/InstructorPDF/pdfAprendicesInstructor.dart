// Importaciones necesarias para Flutter.
// ignore_for_file: no_logic_in_create_state, file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:horarios_cba/Models/usuarioModel.dart';
import 'package:horarios_cba/PDF/menu.dart';
import 'package:horarios_cba/PDF/url_text.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PdfAprendicesInstructorScreen extends StatefulWidget {
  const PdfAprendicesInstructorScreen({
    super.key,
    required this.usuario,
    required this.registros,
  });

  final UsuarioModel usuario;

  final List<DataGridRow> registros;

  @override
  State<PdfAprendicesInstructorScreen> createState() =>
      _PdfAprendicesInstructorScreenState(
          usuario: usuario, registros: registros);
}

class _PdfAprendicesInstructorScreenState
    extends State<PdfAprendicesInstructorScreen> {
  final UsuarioModel usuario;

  final List<DataGridRow> registros;

  _PdfAprendicesInstructorScreenState({
    required this.usuario,
    required this.registros,
  });

  PrintingInfo? printingInfo;

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();

    setState(() {
      printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;

    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(
          icon: Icon(
            Icons.save,
            color: primaryColor,
          ),
          onPressed: saveAsFile,
        ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "CBA MOSQUERA",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: primaryColor,
        ),
        body: PdfPreview(
          maxPageWidth: 700,
          actions: actions,
          onPrinted: showPrintedToast,
          onShared: showSharedToast,
          build: generatePdf,
        ),
      ),
    );
  }

  Future<Uint8List> generatePdf(final PdfPageFormat format) async {
    final doc = pw.Document(
      title: 'CBA Mosquera reporte de aprendices',
    );

    final logoImage = pw.MemoryImage(
        (await rootBundle.load('assets/img/logo2.png')).buffer.asUint8List());

    final tableHeaders = [
      'Nombre Completo',
      'Tipo Documento',
      'Número Documento',
      'Correo Electrónico',
      'Teléfono Celular',
      'Vocero',
      'Ficha',
      'Lider Ficha',
      'Programa',
      'Tipo Programa',
    ];
    final tableData = registros.map((item) {
      final cellsWithIndex = item.getCells().asMap().entries;

      return cellsWithIndex.where((entry) {
        return entry.key < cellsWithIndex.length - 0;
      }).map((entry) {
        //final index = entry.key;
        final cell = entry.value;

        return cell.value.toString();
      }).toList();
    }).toList();

    // Agrega una página al documento PDF.
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        orientation: pw.PageOrientation.landscape,
        // Configuración del encabezado de la página.
        header: (final context) => pw.Image(
          alignment: pw.Alignment.topLeft,
          logoImage,
          fit: pw.BoxFit.contain,
          width: 70,
        ),
        // Construcción del contenido de la página.
        build: (final context) => [
          pw.Container(
            padding: const pw.EdgeInsets.only(left: 10, bottom: 20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Padding(padding: const pw.EdgeInsets.only(top: 60)),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                              "Nombre: ${usuario.nombres} ${usuario.apellidos}",
                              style: const pw.TextStyle(fontSize: 13)),
                          pw.Text("Correo: ${usuario.correoElectronico}",
                              style: const pw.TextStyle(fontSize: 13)),
                          pw.Text(
                              "Teléfono: ${usuario.telefonoCelular} - ${usuario.telefono}",
                              style: const pw.TextStyle(fontSize: 13)),
                          pw.Text(
                              "Documento: ${usuario.tipoDocumento} - ${usuario.numeroDocumento}",
                              style: const pw.TextStyle(fontSize: 13)),
                        ]),
                    pw.SizedBox(width: 20),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Contáctenos",
                            style: const pw.TextStyle(fontSize: 13)),
                        UrlText('CBA MOSQUERA', "15462323",
                            style: const TextStyle(
                                fontSize: 13, color: primaryColor)),
                        UrlText('proyectohorarioscba@gmail.com', 'CBA MOSQUERA',
                            style: const TextStyle(
                                fontSize: 13, color: primaryColor)),
                      ],
                    ),
                    pw.SizedBox(width: 40),
                    pw.Padding(padding: pw.EdgeInsets.zero),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Center(
            child: pw.Text(
              "Reporte de aprendices",
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 20, // Ajustar el tamaño para un texto secundario
                fontWeight: pw.FontWeight.normal,
              ),
            ),
          ),
          pw.SizedBox(height: 10),

          // Tabla
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.black, width: 1),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                children: tableHeaders.map((header) {
                  return pw.Container(
                    padding: const pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      header,
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
              ...tableData.map((row) {
                return pw.TableRow(
                  children: row.map((cell) {
                    return pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        cell,
                        style: const pw.TextStyle(
                          fontSize: 10,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
          pw.Center(
            child: pw.Padding(
              padding: const pw.EdgeInsets.only(top: 60),
              child: pw.Text(
                '¡CBA MOSQUERA!',
                style:
                    pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
    // Guarda el documento y retorna los datos del PDF.
    return doc.save();
  }
}
