import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ChooseOption.dart';

class profileController extends GetxController {
  void signOut() async {
    SharedPreferences sigin = await SharedPreferences.getInstance();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("username");
    sp.remove("password");
    sigin.remove("name");
    sigin.remove("email");
    sigin.remove("userId");
    Get.offAll(const ChooseOption());
  }
}
