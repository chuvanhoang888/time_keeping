import 'dart:io';
import 'package:app_cham_cong_option_2/data/models/work/work_image.dart';
import 'package:app_cham_cong_option_2/data/repositories/work_image_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class WorkImageService implements WorkImageRepository {
  ApiResponse apiResponse = ApiResponse();
  @override
  Future<ApiResponse> getAllWorkImage(int idWork) async {
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(Config.workImageURL + "/$idWork",
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data = await data["work-images"].map<WorkImage>((json) {
          return WorkImage.fromJson(json);
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

  //create post
  @override
  Future<ApiResponse> uploadWorkImage(int idWork, File imagesFile) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      var fileName = imagesFile.path.split('/').last;
      var path = imagesFile.path;
      FormData formData = FormData.fromMap({
        "files": await MultipartFile.fromFile(path, filename: fileName),
      });

      final response = await dio.post(Config.workImageURL + "/$idWork",
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: formData);

      if (response.statusCode == 200) {
        var data = response.data;
        apiResponse.data = WorkImage.fromJson(data['work-image']);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 422) {
        var data = e.response!.data;
        final errors = data['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
      } else if (e.response!.statusCode == 401) {
        apiResponse.error = Config.unauthorized;
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }

  // Delete post
  @override
  Future<ApiResponse> deleteWorkImage(int idWorkImage) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.delete(
          Config.workImageURL + "/" + idWorkImage.toString(),
          options: Options(headers: {
            'content-type': 'application/json',
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
