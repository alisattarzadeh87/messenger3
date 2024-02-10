import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/backend/repositories/auth_repositiory.dart';
import 'package:messenger/helpers/base_controller.dart';

import '../../../backend/requests/login_request.dart';
import '../../../helpers/user_helper.dart';
import '../../../helpers/utils.dart';
import '../../home/pages/home_page.dart';

class LoginController extends BaseController {
  AuthRepository repository = AuthRepository();
  LoginRequest request = LoginRequest();

  final formkey = GlobalKey<FormState>();

  Future<void> login() async {
    if(formkey.currentState!.validate()) {
      load();
      var res = await repository.login(request);
      if(res != null) {
        userHelper.setToken(res);
        await saveToken(res);
        Get.to(HomePage());
      }
      load();
    }
  }
}