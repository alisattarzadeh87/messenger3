
import '../models/message.dart';

class MessagesResponse {
  List<Message>? data;

  MessagesResponse({this.data});

  MessagesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Message>[];
      json['data'].forEach((v) {
        data!.add(Message.fromJson(v));
      });
    }
  }
}