import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_hear/controllers/on_board_screen_controller.dart';
import 'package:sign_hear/screens/camera_screen.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () async {
          OnBoardScreenController.controller.setValue();
          Get.to(() => const CameraScreen());
        },
        child: Scaffold(
          backgroundColor: const Color(0xffDEDEDE),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // icon and text box
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/favicon.png",
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                    Column(
                      children: [
                        Text(
                          "SignHear",
                          style: GoogleFonts.rubik(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                        ),
                        Text(
                          "hear photos of signs\nand help others learn",
                          style: GoogleFonts.rubik(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xff727272),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                // alert box
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 4,
                    ),
                  ),
                  child: Text(
                    "WARNING: This app tracks your precise location and can scan photos while running in the background. ",
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
                //
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'STEP 1',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      " ALLOW PRECISE LOCATION\nAND CAMERA ACCESS",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                // camera image and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text.rich(
                      TextSpan(
                        text: 'STEP 2',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(
                            text: " TAKE PHOTO OF ANY SIGN",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/instruction.png",
                        height: 180,
                      ),
                    )
                  ],
                ),
                //
                const Text.rich(
                  TextSpan(
                    text: 'STEP 3',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff50933C),
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: " HEAR WHAT THE SIGN SAYS",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
                //
                const Center(
                  child: Text(
                    "tap anywhere to give permission...",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
