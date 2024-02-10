import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConversationRequest {
  String type = "PRIVATE";
  List<int>? participants;
  TextEditingController name = TextEditingController();
  File? image;

  Future<FormData> data() async {
    var form = FormData.fromMap({
      'name': name.text,
      'type': type,
      if(image != null)
        'image': await MultipartFile.fromFile(image!.path, filename: image!.path.split("/").last),
    });
    participants?.forEach((element) {
      form.fields.add(MapEntry("participants[]", element.toString()));
    });
    return form;
  }

}