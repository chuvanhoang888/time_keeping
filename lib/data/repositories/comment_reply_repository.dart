import 'package:app_cham_cong_option_2/data/models/dts_feed/comments_reply.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class CommentReplyReponsitory {
  Future<ApiResponse> getCommentsReply(int idComment);
  Future<ApiResponse> uploadCommentsReply(int idComment, String content);
  Future<ApiResponse> updateCommentReply(CommentsReply com);
  Future<ApiResponse> deleteCommentReply(int idCommentReply);
}
