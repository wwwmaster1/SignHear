import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:camera/camera.dart';
import 'package:sign_hear/screens/camera_screen.dart';
import 'package:sign_hear/screens/on_board_screen.dart';
import 'package:sign_hear/utils/app_bindings.dart';
import 'package:sign_hear/utils/app_constants.dart';
import 'package:sign_hear/utils/app_pallete.dart';

int? openedOnce;

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    openedOnce = prefs.getInt('openedOnce');
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: ThemeData(primarySwatch: Palette.primaryColor),
      home: const DecisionPage(),
    );
  }
}

class DecisionPage extends StatelessWidget {
  const DecisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return openedOnce == null ? const OnBoardScreen() : const CameraScreen();
  }
}
