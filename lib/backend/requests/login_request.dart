import 'package:flutter/cupertino.dart';

import '../../helpers/utils.dart';

class LoginRequest {
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();

  String? mobileValidator(String? value) {
    return value == null || !isPhoneValidate(value) ? "موبایل نا معتبر است" : null;
  }

  String? passwordValidator(String? value) {
    if(value == null || value.isEmpty) {
      return "لطفا رمز عبور را وارد کنید";
    } else if(value.length < 8) {
      return "رمز عبور باید حداقل 8 حرف باشد";
    }
    return null;
  }

  Map<String, String> data() {
    return {
      'mobile': mobile.text,
      'password': password.text
    };
  }
}