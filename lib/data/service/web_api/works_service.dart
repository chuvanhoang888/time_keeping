import 'dart:io';
import 'package:app_cham_cong_option_2/data/models/work/work.dart';
import 'package:app_cham_cong_option_2/data/repositories/work_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class WorksService implements WorkRepository {
  ApiResponse apiResponse = ApiResponse();
  @override
  Future<ApiResponse> getAllWork() async {
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(Config.workURL,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data = await data["works"].map<Work>((json) {
          return Work.fromJson(json);
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
  Future<ApiResponse> createWork(
      String name, startDay, endDay, dateTime) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();

      FormData formData = FormData.fromMap({
        "name": name,
        "start_day": startDay,
        "end_day": endDay,
        "date_time": dateTime,
      });

      final response = await dio.post(Config.workURL,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: formData);

      if (response.statusCode == 200) {
        var data = response.data;
        apiResponse.data = data['message'];
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
  // edit Post

  @override
  Future<ApiResponse> editWork(Work work) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();

      final response = await dio.put(Config.workURL + "/" + work.id.toString(),
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: work.toJson());

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

  // Delete post
  @override
  Future<ApiResponse> deleteWork(int idWork) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.delete(
          Config.workURL + "/" + idWork.toString(),
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

  Future<List<String>> uploadFiles(List<File> _images) async {
    var imageUrls = await Future.wait(_images.map((_image) {
      return uploadFile(_image);
    }));

    return imageUrls;
  }

  Future<String> uploadFile(File _image) async {
    //String fileName = path.basename(_image.path);
    String fileName = _image.path.split('/').last;
    final dio = Dio();
    String? urlImage;

    try {
      String token = await AuthService().getToken();
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(_image.path, filename: fileName),
      });

      final response = await dio.post(Config.uploadImagePost,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: formData);

      if (response.statusCode == 200) {
        var data = response.data;

        urlImage = data['url_photo'];
      } else {}
    } catch (e) {
      print(e.toString);
    }
    return urlImage!;
  }
}
