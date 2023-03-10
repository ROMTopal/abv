// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  final List<Uint8List>? myImages;

  const PdfScreen({super.key, this.myImages});

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  String pdfFile = '';
  var pdf = pw.Document();

  createAndSave()
  async {
    await createPdfFile(widget.myImages!);
    savePdfFile();
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    createAndSave();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expanded(
              //   child: Visibility(
              //     visible: pdfFile.isNotEmpty,
              //     child: SfPdfViewer.file(File(pdfFile),
              //         canShowScrollHead: false, canShowScrollStatus: false),
              //   ),
              // ),
              TextButton(
                  onPressed: () async {
                    await createPdfFile(widget.myImages!);
                    savePdfFile();
                  },
                  child: const Text('Create a Pdf')),
            ],
          ),
        ),
      ),
    );
  }


  createPdfFile(List<Uint8List> myImages) async {

    final List<pw.Widget> pdfImages = widget.myImages!.map((image) {
      return pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisSize: pw.MainAxisSize.max,
              children: [
                pw.SizedBox(height: 10),
                pw.Image(
                    pw.MemoryImage(
                      image,
                    ),
                    height: 400,
                    fit: pw.BoxFit.fitHeight)
              ]));
    }).toList();

    //add pages to pdf
    pdf.addPage(pw.MultiPage(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisSize: pw.MainAxisSize.max,
                children: pdfImages),
          ];
        }));
  }

  savePdfFile() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    String id = DateTime.now().toString();
    File file = File("$documentPath/skendy$id.pdf");
    file.writeAsBytesSync(await pdf.save());
    setState(() {
      pdfFile = file.path;
      pdf = pw.Document();
    });
    print("PDF SAVED SUCCESSFULLY");
  }
}