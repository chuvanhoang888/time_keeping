import 'package:dio/dio.dart';

import '../models/components/user_model.dart';

abstract class Authlogin {
  Future<UserModel?> login(String email, String password) async {
    const api = 'https://reqres.in/api/login';
    final data = {'email': email, 'password': password};
    final dio = Dio();
    Response response;
    try {
      response = await dio.post(
        api,
        data: data,
      );
      if (response.statusCode == 200) {
        // final body = response.data;
        // return UserModel(
        //   id: "1",
        //   name: "name",
        //   email: "email",
        // );
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to login');
    }
  }
}
