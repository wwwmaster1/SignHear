import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_hear/screens/camera_screen.dart';
import 'package:sign_hear/screens/text_to_speech_screen.dart';
import 'package:sign_hear/utils/api_call.dart';

class OcrScreen extends StatefulWidget {
  OcrScreen({super.key, required this.text, required this.file});

  String? text;
  XFile? file;

  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  TextEditingController textEditingController = TextEditingController();

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.text!;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Hear the Sign"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                maxLines: 60,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (String newText) =>
                    setState(() => widget.text = newText),
              ),
            ),
            const SizedBox(height: 40),
            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // back btn
                FloatingActionButton(
                  heroTag: "crop-btn",
                  onPressed: () {
                    Get.back();
                  },
                  backgroundColor: Colors.black,
                  tooltip: 'Back',
                  child: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.white,
                  ),
                ),
                // play n stop btn
                TextToSpeechScreen(
                    text: "${widget.text}", flutterTts: flutterTts),
                // start over button
                FloatingActionButton(
                  heroTag: "start-over-btn",
                  onPressed: () {
                    debugPrint("-------my imp data-----");
                    debugPrint(
                      "title: ${widget.text!.characters.take(10)} \nscript:${widget.text} \npicture: ${widget.file!.path} \nlatitude: $reqLatitude \nlongitude: $reqLongitude \nelevation: $reqAltitude",
                    );
                    ApiCall.postData(
                      widget.text!.characters.take(10).toString(),
                      widget.text,
                      widget.file!.path,
                      reqLatitude,
                      reqLongitude,
                      reqAltitude,
                    );
                    flutterTts.stop();
                    Get.to(() => const CameraScreen());
                  },
                  backgroundColor: Colors.black,
                  tooltip: 'Start Over',
                  child: const Icon(Icons.restart_alt, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
