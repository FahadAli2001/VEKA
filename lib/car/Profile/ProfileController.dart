import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ChooseOption.dart';

class profileController extends GetxController{

  void SignOut()async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    SharedPreferences signupshared = await SharedPreferences.getInstance();
    signupshared.remove("username");
    signupshared.remove("email");
    sp.remove("username");
    sp.remove("password");
    Get.offAll(ChooseOption());
    print(sp.getString("username"));
    print(signupshared.getString("email"));

  }
}