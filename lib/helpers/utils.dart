import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isPhoneValidate(String value) {
  String pattern = r'^(\+98|0)?9\d{9}$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return false;
  }
  return true;
}

Future<void> saveToken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
}

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}

Future<void> removeToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("token");
}

Future<String> convertFileToBase64(XFile file) async {
  var bytes = await file.readAsBytes(); // no need to use await async because we used readAsBytesSync()
  return base64Encode(bytes);
}

String generateRandomName() {
  var randomNumber = Random().nextInt(10000) + 999999;
  return randomNumber.toString();
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}