import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class TextToSpeechScreen extends StatefulWidget {
  const TextToSpeechScreen(
      {super.key, required this.text, required this.flutterTts});

  final FlutterTts flutterTts;
  final String text;

  @override
  State<TextToSpeechScreen> createState() => _TextToSpeechScreenState();
}

class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  final TextEditingController textEditingController = TextEditingController();

  Future _speak() async {
    await widget.flutterTts.setLanguage("en-US");
    await widget.flutterTts.setPitch(1);

    var result = await widget.flutterTts.speak(widget.text);

    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop() async {
    var result = await widget.flutterTts.stop();

    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await widget.flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    widget.flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return isPlaying
        ? FloatingActionButton(
            heroTag: "stop",
            onPressed: _stop,
            backgroundColor: Colors.black,
            tooltip: 'Stop',
            child: const Icon(Icons.stop, color: Colors.red),
          )
        : FloatingActionButton(
            heroTag: "play",
            onPressed: _speak,
            backgroundColor: Colors.black,
            tooltip: 'Play',
            child: const Icon(Icons.play_arrow, color: Colors.green),
          );
  }
}
