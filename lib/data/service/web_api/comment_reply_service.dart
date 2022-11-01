import 'package:app_cham_cong_option_2/data/models/dts_feed/comments_reply.dart';
import 'package:app_cham_cong_option_2/data/repositories/comment_reply_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';

class CommentReplyService implements CommentReplyReponsitory {
  @override
  Future<ApiResponse> getCommentsReply(int idComment) async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(
          Config.commentURL +
              "/" +
              idComment.toString() +
              Config.commentReplyURL,
          options: Options(headers: {
            'Accept': 'application/Json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data =
            await data["comments-reply"].map<CommentsReply>((json) {
          return CommentsReply.fromJson(json);
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
  Future<ApiResponse> deleteCommentReply(int idCommentReply) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.delete(
          Config.commentReplyFullURL + "/$idCommentReply",
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
  Future<ApiResponse> updateCommentReply(CommentsReply comment) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.put(
          Config.commentReplyFullURL + "/" + comment.commentId.toString(),
          options: Options(headers: {
            'Accept': 'application/Json',
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
  Future<ApiResponse> uploadCommentsReply(int idComment, String content) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();

      //debugPrint("formData" + _documents.toString());
      FormData formData = FormData.fromMap({
        "content": content,
      });

      final response = await dio.post(
          Config.commentURL +
              "/" +
              idComment.toString() +
              Config.commentReplyURL,
          options: Options(headers: {
            'Accept': 'application/Json',
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
