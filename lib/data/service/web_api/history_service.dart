import 'package:app_cham_cong_option_2/data/models/home/histories.dart';
import 'package:app_cham_cong_option_2/data/repositories/history_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class HitoryService implements HistoryRepository {
  @override
  Future<ApiResponse> getHistory(String param) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(Config.historyURL + '/param',
          options: Options(headers: {
            'Accept': 'application/Json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data = await data["histories"].map<Histories>((json) {
          return Histories.fromJson(json);
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
