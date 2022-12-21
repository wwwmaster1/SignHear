import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_hear/screens/camera_screen.dart';
import 'package:sign_hear/screens/ocr_screen.dart';

class EditImageScreen extends StatefulWidget {
  XFile? file;

  EditImageScreen({super.key, required this.file});

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  CroppedFile? _croppedFile;
  String? scannedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _imageCard()),
        ],
      ),
    );
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else if (widget.file != null) {
      final path = widget.file!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // delete image
        FloatingActionButton(
          heroTag: "delete",
          onPressed: () => _clear(),
          backgroundColor: Colors.redAccent,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        // crop image
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: FloatingActionButton(
            heroTag: "crop",
            onPressed: () => _cropImage(),
            backgroundColor: Colors.black,
            tooltip: 'Crop',
            child: const Icon(Icons.crop),
          ),
        ),
        // direct ocr
        FloatingActionButton(
          heroTag: "ocr",
          onPressed: () async {
            if (_croppedFile == null) {
              await getRecognisedText(widget.file);
              Get.to(() => OcrScreen(text: scannedText, file: widget.file));
            } else {
              await getRecognisedText(_croppedFile);
              Get.to(() => OcrScreen(text: scannedText, file: widget.file));
            }
          },
          backgroundColor: Colors.black,
          tooltip: 'Start',
          child: const Icon(Icons.forward, color: Colors.white),
        ),
      ],
    );
  }

  Future<void> _cropImage() async {
    if (widget.file != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: widget.file!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  void _clear() {
    setState(() {
      widget.file = null;
      _croppedFile = null;
    });
    Get.to(() => const CameraScreen());
  }

  Future<void> getRecognisedText(final image) async {
    final inputImage = InputImage.fromFilePath(image.path);

    final textRecognizer = GoogleMlKit.vision.textRecognizer();

    RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    await textRecognizer.close();
    scannedText = "";

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = "$scannedText${line.text}\n";
      }
    }
    setState(() {});
  }
}
