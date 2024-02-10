import '../models/user.dart';

class UsersResponse {
  List<User>? data;

  UsersResponse({this.data});

  UsersResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(User.fromJson(v));
      });
    }
  }
}
