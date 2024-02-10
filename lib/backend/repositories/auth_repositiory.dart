import 'package:messenger/backend/repositories/base_repository.dart';
import 'package:messenger/backend/requests/register_request.dart';
import 'package:messenger/helpers/widgets/snakbars.dart';
import '../models/user.dart';
import '../requests/login_request.dart';

class AuthRepository extends BaseRepository {
  Future<String?> register(RegisterRequest request) async {
    var res = await dio.post("/auth/register", data: request.data());
    if (res.statusCode != 200) {
      showErrorMessage(res.data['errors'][0]);
      return null;
    }
    return res.data["token"];
  }

  Future<String?> login(LoginRequest request) async {
    var res = await dio.post("/auth/login", data: request.data());
    if (res.statusCode != 200) {
      showErrorMessage(res.data["errors"][0]);
      return null;
    }
    return res.data["token"];
  }

  Future<User?> getProfile() async {
    var res = await dio.get("/auth/profile");
    if (res.statusCode != 200) {
      showErrorMessage(res.data["errors"][0]);
      return null;
    }
    return User.fromJson(res.data["user"]);
  }
}