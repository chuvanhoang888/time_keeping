import 'dart:convert';
import 'dart:io';

import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<ApiResponse> login(String email, password) async {
    final data = {'email': email, 'password': password};
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      final response = await dio.post(
        Config.loginURL,
        options: Options(headers: {'content-type': 'application/json'}),
        data: data,
      );
      if (response.statusCode == 200) {
        var data = response.data;

        await saveToken(data['token']);
        await saveUserId(data['user']['id']);

        apiResponse.data = UserModel.fromJson(data['user']);
      }
      // switch (response.statusCode) {
      //   case 200:
      //     var data = response.data;

      //     //saveToken(data['token']);
      //     apiResponse.data = UserModel.fromJson(data['user']);

      //     break;
      //   case 422:
      //     var data = response.data;
      //     final errors = data['errors'];
      //     apiResponse.error = errors[errors.keys.elementAt(0)][0];
      //     break;
      //   case 403:
      //     var data = jsonDecode(response.data);
      //     apiResponse.error = data['message'];
      //     break;
      //   default:
      //     apiResponse.error = Config.somethingWentWrong;
      //     break;
      // }
    } on DioError catch (e) {
      if (e.response!.statusCode == 403) {
        apiResponse.error = e.response!.data['message'];
      } else if (e.response!.statusCode == 422) {
        var data = e.response!.data;
        final errors = data['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }

  Future<ApiResponse> register(String name, email, password) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password
    };
    final dio = Dio();
    Response response;
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      response = await dio.post(
        Config.registerURL,
        options: Options(headers: {'content-type': 'application/json'}),
        data: data,
      );
      if (response.statusCode == 200) {
        var data = response.data;

        await saveToken(data['token']);
        await saveUserId(data['user']['id']);
        apiResponse.data = UserModel.fromJson(data['user']);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 403) {
        apiResponse.error = e.response!.data['message'];
      } else if (e.response!.statusCode == 422) {
        var data = e.response!.data;
        final errors = data['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }

//get user detail
  Future<ApiResponse> getUserDetail() async {
    Response response;
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      String token = await getToken();

      response = await dio.get(Config.userURL,
          options: Options(headers: {
            //'Accept': 'application/Json',
            'Authorization': 'Bearer $token',
            'content-type': 'application/json'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        //saveToken(data['token']);
        apiResponse.data = UserModel.fromJson(data['user']);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 403) {
          apiResponse.error = e.response!.data['message'];
        } else if (e.response!.statusCode == 422) {
          var data = e.response!.data;
          final errors = data['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
        } else {
          apiResponse.error = e.toString();
        }
      } else {
        apiResponse.error = "Đường dẫn không chính xác";
      }
    }
    return apiResponse;
  }

// update image user
  Future<ApiResponse> updateImageUser(File _image) async {
    String fileName = _image.path.split('/').last;
    Response response;
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      String token = await getToken();
      FormData formData = FormData.fromMap({
        "imageFile":
            await MultipartFile.fromFile(_image.path, filename: fileName),
      });
      response = await dio.post(Config.imageUserURL,
          data: formData,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;
        //saveToken(data['token']);
        apiResponse.data = UserModel.fromJson(data['user']);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 403) {
        apiResponse.error = e.response!.data['message'];
      } else if (e.response!.statusCode == 422) {
        var data = e.response!.data;
        final errors = data['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }

//save token
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.setString('token', token);
  }

//get token
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

//save userId
  Future<void> saveUserId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.setInt('userId', id);
  }

//get user id
  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') ?? 0;
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove('token');
  }

  String? getStringImage(File? file) {
    if (file == null) {
      return null;
    } else {
      return base64Encode(file.readAsBytesSync());
    }
  }
}
