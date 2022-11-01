import 'package:app_cham_cong_option_2/data/models/work/work_comment.dart';
import 'package:app_cham_cong_option_2/data/repositories/work_comment_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class WorkCommentService implements WorkCommentRepository {
  @override
  Future<ApiResponse> getAllWorkComment(int idWork) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(Config.workCommentURL + "/$idWork",
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data = await data["work-comments"].map<WorkComment>((json) {
          return WorkComment.fromJson(json);
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
  Future<ApiResponse> deleteWorkComment(int idWorkComment) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.delete(
          Config.workCommentURL + "/$idWorkComment",
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

  @override
  Future<ApiResponse> editWorkComment(WorkComment workComment) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.put(
          Config.workCommentURL + "/" + workComment.commentId.toString(),
          options: Options(headers: {
            'Accept': 'application/Json',
            'Authorization': 'Bearer $token'
          }),
          data: workComment.toJson());

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

  @override
  Future<ApiResponse> createWorkComment(int idWork, String content) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();

      //debugPrint("formData" + _documents.toString());
      FormData formData = FormData.fromMap({
        "content": content,
      });

      final response = await dio.post(Config.workCommentURL + "/$idWork",
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
}
