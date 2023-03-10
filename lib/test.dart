// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:skendy/src/custom_widgets/snackbar.dart';
import 'package:skendy/src/utils/my_strings.dart';

class MyTest extends StatefulWidget {
    const MyTest({Key? key}):super(key : key);

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  File? file;
  bool textScanning =false;
  String scannedText ="";

  importFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'jpeg', 'png', 'docx'],
    );
    if (result != null) {
      textScanning = true;
       file = File(result.files.single.path!);
       setState(() {

       });
       if(file !=null)
      {
        await extractText(file!);
      }
      snackBar(context, MyStrings.fileImportedSuccessfully);
    } else {
      snackBar(context, MyStrings.pleaseSelectFile);
    }
  }


  extractText(File image)
  async{
    // final inputImage = InputImage.fromFilePath(image.path);
    // final textDetector = GoogleMlKit.vision.textRecognizer();
    // RecognizedText recognizedText = await textDetector.processImage(inputImage);
    // await textDetector.close();
    // scannedText = "";
    // for(TextBlock block in recognizedText.blocks)
    //   {
    //     for(TextLine line in block.lines)
    //       {
    //        scannedText +="${line.text} \n";
    //       }
    //   }
    // print(scannedText);
    // textScanning = false;
    // setState(() {});

    // final textRecognizer = TextRecognizer();
    // final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    // await textDetector.close();
    // String text = recognizedText.text;
    // for (TextBlock block in recognizedText.blocks) {
      // final Rect rect = block.rect;
      // final List<Point<int>> cornerPoints = block.cornerPoints;
      // final String text = block.text;
      // final List<String> languages = block.recognizedLanguages;

      // for (TextLine line in block.lines) {
        // Same getters as TextBlock
        // for (TextElement element in line.elements) {
          // Same getters as TextBlock
          // scannedText +="${element.text} \n";
        // }
      // }
      // print(scannedText);
      // textScanning = false;
      // setState(() {});
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(body:SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              // importFile();
            }, child: const Text("Select File")),
            // if(file !=null)
            //   Image.file(file!,height: 400,width: 300,)

          ],
        ),
      ),
    ),);
  }
}
