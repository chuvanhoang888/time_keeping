import 'package:app_cham_cong_option_2/data/models/home/permission.dart';
import 'package:app_cham_cong_option_2/data/repositories/permission_mail_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class PermissionsMailService implements PermissionMailRepository {
  @override
  Future<ApiResponse> createPermission(
      String time, day, content, type, toMail) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    try {
      FormData formData = FormData.fromMap({
        'time': time,
        'day': day,
        'content': content,
        'type': type,
        'to_mail': toMail
      });

      String token = await AuthService().getToken();
      final response = await dio.post(Config.permissionURL,
          data: formData,
          options: Options(headers: {
            'Accept': 'application/Json',
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        var data = response.data;

        //apiResponse.data = await data["notifications"] as Notifications;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        apiResponse.error = Config.unauthorized;
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }

  @override
  Future<ApiResponse> getPermission() async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(Config.permissionURL,
          options: Options(headers: {
            'Accept': 'application/Json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data =
            await data["permission_mail"].map<PermissonModel>((json) {
          return PermissonModel.fromJson(json);
        }).toList();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        apiResponse.error = Config.unauthorized;
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }

  @override
  Future<ApiResponse> deletePermission(int id) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.delete(Config.permissionURL + "/$id",
          options: Options(headers: {
            'Accept': 'application/Json',
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        var data = response.data;
        apiResponse.data = data['message'];
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 403) {
        var data = e.response!.data;
        final errors = data['message'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
      } else if (e.response!.statusCode == 401) {
        apiResponse.error = Config.unauthorized;
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }
}
