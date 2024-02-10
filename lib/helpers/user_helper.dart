import 'package:get/get.dart';
import 'package:messenger/backend/models/user.dart';
import 'package:messenger/helpers/utils.dart';
import 'package:messenger/modules/auth/pages/start_page.dart';

class UserHelper extends GetxController {
  String? token;
  User? user;

  void setToken(String value) {
    token = value;
  }

  void setUser(User value) {
    user = value;
    update();
  }

  Future<void> logout() async {
    token = null;
    user = null;
    await removeToken();
    Get.off(StartPage());
  }
}

final userHelper = Get.find<UserHelper>();