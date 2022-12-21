import 'package:get/get.dart';
import 'package:sign_hear/controllers/on_board_screen_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(OnBoardScreenController());
  }
}
