import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/models/work/work_user.dart';
import 'package:app_cham_cong_option_2/data/repositories/work_user_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class WorkUserService implements WorkUserrepository {
  @override
  //get all user
  Future<ApiResponse> getAllUser() async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      String token = await AuthService().getToken();

      var response = await dio.get(Config.allUserURL,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        //saveToken(data['token']);
        apiResponse.data = await data["users"].map<UserModel>((json) {
          return UserModel.fromJson(json);
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
  Future<ApiResponse> deleteWorkUser(int idWorkUser) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      String token = await AuthService().getToken();

      var response = await dio.delete(Config.workUserURL + "/$idWorkUser",
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
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

  @override
  Future<ApiResponse> getWorkUser(int idWork) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      String token = await AuthService().getToken();

      var response = await dio.get(Config.workUserURL + "/$idWork",
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        //saveToken(data['token']);
        apiResponse.data = await data["work-users"].map<WorkUser>((json) {
          return WorkUser.fromJson(json);
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
  Future<ApiResponse> insertWorkUser(int idWork, idUser) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      String token = await AuthService().getToken();
      FormData formData = FormData.fromMap({'user_id': idUser});

      var response = await dio.post(Config.workUserURL + "/$idWork",
          options: Options(headers: {
            'content-type': 'application/json',
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
