import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
import 'package:app_cham_cong_option_2/data/repositories/account_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class AccountService implements AccountRepository {
  @override
  Future<ApiResponse> getPostForUser(int idUser) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(
          Config.postsUserFullURL + "/" + idUser.toString(),
          options: Options(headers: {
            'Accept': 'application/Json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data = await data["posts"].map<Posts>((json) {
          return Posts.fromJson(json);
        }).toList();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          apiResponse.error = Config.unauthorized;
        } else {
          apiResponse.error = e.toString();
        }
      } else {
        apiResponse.error = "Liên kết API không chính xác";
      }
    }
    return apiResponse;
  }
}
