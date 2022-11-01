import 'package:app_cham_cong_option_2/data/models/dts_feed/comments.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/repositories/comment_reponsitory.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class CommentService implements CommentReponsitory {
  @override
  Future<ApiResponse> getCommentsForPost(int idPost) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(
          Config.commentURL + "/" + idPost.toString(),
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data = await data["post-comments"].map<Comments>((json) {
          return Comments.fromJson(json);
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
  Future<ApiResponse> deleteComment(int idComment) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.delete(Config.commentURL + "/$idComment",
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        var data = response.data;
        apiResponse.data = data['message'];
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 403) {
          var data = e.response!.data;
          final errors = data['message'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
        } else if (e.response!.statusCode == 401) {
          apiResponse.error = Config.unauthorized;
        } else {
          apiResponse.error = e.toString();
        }
      } else {
        apiResponse.error = "Liên kết đến API của bạn không chính xác";
      }
    }
    return apiResponse;
  }

  @override
  Future<ApiResponse> updateComment(Comments comment) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.put(
          Config.commentURL + "/" + comment.commentId.toString(),
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: comment.toJson());

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
  Future<ApiResponse> uploadComments(int idPost, String content) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();

      //debugPrint("formData" + _documents.toString());
      FormData formData = FormData.fromMap({
        "content": content,
      });

      final response = await dio.post(
          Config.commentURL + "/" + idPost.toString(),
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

  @override
  Future<ApiResponse> likeUnLikeComment(int idComment) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.post(
          Config.commentLikeURL + "/" + idComment.toString(),
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
