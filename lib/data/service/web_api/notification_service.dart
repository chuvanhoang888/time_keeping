import 'package:app_cham_cong_option_2/data/models/home/notifications.dart';
import 'package:app_cham_cong_option_2/data/repositories/notification_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class NotificationService implements NotificationRepository {
  @override
  Future<ApiResponse> createNotification(String name, content, time) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'content': content,
        'time': time,
      });

      String token = await AuthService().getToken();
      final response = await dio.post(Config.notificationURL,
          data: formData,
          options: Options(headers: {
            'content-type': 'application/json',
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
  Future<ApiResponse> getNotification() async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(Config.notificationURL,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data =
            await data["notifications"].map<Notifications>((json) {
          return Notifications.fromJson(json);
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
}
