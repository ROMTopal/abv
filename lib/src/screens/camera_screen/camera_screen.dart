import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skendy/src/custom_widgets/snackbar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:syncfusion_flutter_pdf/pdf.dart' as sp;
class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  CameraController? cameraController;
  List<XFile> imageList = [];
  String pdfFile = '';
  var pdf = pw.Document();
  Future<void> startCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }
  createPdfFile(List<Uint8List> myImages) async {

    final List<pw.Widget> pdfImages = myImages.map((image) {
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
    print("documentPath $documentDirectory");
    File file = File("$documentPath/skendy$id.pdf");
    file.writeAsBytesSync(await pdf.save());
    setState(() {
      pdfFile = file.path;
      pdf = pw.Document();
    });
    print("PDF SAVED SUCCESSFULLY");
  }
  extractText()
  async {
    String extractedText = "";
    for (var element in imageList) {
      extractedText += await FlutterTesseractOcr.extractText(element.path);
    }

    print("extractedText $extractedText");

  }
  @override
  void initState() {
    // TODO: implement initState
    startCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController!=null && cameraController!.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                child: CameraPreview(
                  cameraController!,
                )),
            Positioned(
              bottom: 30,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,

                      scrollDirection: Axis.horizontal,
                      itemCount: imageList.length,
                      itemBuilder: (c, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                            File(imageList[i].path),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: FloatingActionButton(
                          onPressed: () {
                            cameraController!.takePicture().then((XFile? value) {
                              if (mounted) {
                                if (value != null) {
                                  imageList.add(value);
                                  setState(() {});
                                  print("FILE $value");
                                }
                              }
                            });
                          },
                          child: const Icon(Icons.camera_alt_outlined),
                        ),
                      ),

                        GestureDetector(
                          child: FloatingActionButton(
                            onPressed: () async {
                              if(imageList.isEmpty)
                                {
                                  snackBar(context, "Please take at least one picture");
                                  return;
                                }
                              else{
                                List<Uint8List> pdfImage = [];
                                for (var element in imageList) {
                                  pdfImage.add(await element.readAsBytes());

                                }
                                setState(() {});
                                await createPdfFile(pdfImage);
                                await savePdfFile();
                               // await extractText();
                              }
                            },
                            child: const Icon(Icons.check),
                          ),
                        ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cameraController!.dispose();
    super.dispose();
  }
}
