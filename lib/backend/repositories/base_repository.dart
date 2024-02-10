import 'package:dio/dio.dart';
import 'package:messenger/helpers/user_helper.dart';

class BaseRepository {
  Dio dio = Dio(BaseOptions(
      baseUrl: "https://chat.hitaldev.ir/api/v1",
    validateStatus: (status) => status! < 500 ,
    headers: {
        if (userHelper.token != null)
          "Authorization" : "Bearer ${userHelper.token}"
    }
  ));
}