import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../helpers/utils.dart'; // For picking images

class RegisterRequest {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  File? avatar;


  String? nameValidator(String? value) {
    return value == null || value.isEmpty ? "لطفا نام را وارد کنید" : null;
  }


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

  String? passwordConfirmValidator(String? value) {
    if(value == null || value.isEmpty) {
      return "لطفا تکرار رمز عبور را وارد کنید";
    } else if(value != password.text) {
      return "تکرار رمز عبور اشتباه است";
    }
    return null;
  }

  Future<FormData> data() async {
    return FormData.fromMap({
      'name': name.text,
      'mobile': mobile.text,
      'password': password.text,
      'passwordConfirm': passwordConfirm.text,
      if(avatar != null)
        'avatar': await MultipartFile.fromFile(avatar!.path, filename: avatar!.path.split("/").last),
    });
  }
}