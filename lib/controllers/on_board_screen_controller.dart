import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_hear/main.dart';

class OnBoardScreenController extends GetxController {
  static OnBoardScreenController controller = Get.find();

  Future<void> setValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('openedOnce', 1);
    openedOnce = prefs.getInt('openedOnce');
  }
}
