import 'package:app_cham_cong_option_2/data/models/dts_feed/user_tag.dart';
import 'package:app_cham_cong_option_2/data/repositories/post_check_in_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class PostUserTagService implements PostUserTagRepository {
  @override
  Future<ApiResponse> deleteUserTag(int idCheckInUser) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      String token = await AuthService().getToken();

      var response = await dio.delete(
          Config.checkInUserFullURL + "/$idCheckInUser",
          options: Options(headers: {
            'Accept': 'application/Json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;
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

  @override
  Future<ApiResponse> getUserTag(int idPost) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      String token = await AuthService().getToken();

      var response = await dio.get(Config.userTagURL + "/$idPost",
          options: Options(headers: {
            'Accept': 'application/Json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        //saveToken(data['token']);
        apiResponse.data = await data["checkIn-users"].map<UserTag>((json) {
          return UserTag.fromJson(json);
        }).toList();
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

  @override
  Future<ApiResponse> insertUserTag(int idPost, idUser) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      String token = await AuthService().getToken();
      FormData formData = FormData.fromMap({'user_id': idUser});

      var response = await dio.post(Config.userTagURL + "/$idPost",
          options: Options(headers: {
            'Accept': 'application/Json',
            'Authorization': 'Bearer $token'
          }),
          data: formData);
      if (response.statusCode == 200) {
        var data = response.data;

        //saveToken(data['token']);
        // apiResponse.data = await data["users"].map<UserWork>((json) {
        //   return UserWork.fromJson(json);
        // }).toList();
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
}
