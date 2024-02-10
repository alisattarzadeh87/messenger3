import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:messenger/helpers/utils.dart';
import 'package:messenger/modules/home/pages/home_page.dart';

import '../../../helpers/user_helper.dart';

class StartController extends GetxController {
  @override
  void onInit() {
    getToken().then((value) {
      if(value != null) {
        userHelper.setToken(value);
        Get.to(HomePage());
      }
    });

    super.onInit();
  }
}