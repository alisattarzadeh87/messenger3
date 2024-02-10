import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/backend/repositories/auth_repositiory.dart';
import 'package:messenger/backend/requests/register_request.dart';
import 'package:messenger/helpers/base_controller.dart';
import 'package:messenger/helpers/user_helper.dart';
import 'package:messenger/helpers/utils.dart';
import 'package:messenger/modules/home/pages/home_page.dart';

class RegisterController extends BaseController {
  RegisterRequest request = RegisterRequest();
  AuthRepository repository = AuthRepository();
  final formkey = GlobalKey<FormState>();

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      request.avatar = File(image.path);
      update();
    }
  }

  Future<void> register() async {
    if (formkey.currentState!.validate()) {
      load();
      var res = await repository.register(request);
      if(res != null) {
        userHelper.setToken(res);
        await saveToken(res);
        Get.to(HomePage());
      }
      load();
    }
  }
}