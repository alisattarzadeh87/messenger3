import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void showErrorMessage(String text) {
  Get.snackbar(
    "خطا",
    text,
    colorText: Colors.white,
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.BOTTOM,
  );
}