import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/comments.dart';

abstract class CommentReponsitory {
  Future<ApiResponse> getCommentsForPost(int idPost);
  Future<ApiResponse> uploadComments(int idPost, String content);
  Future<ApiResponse> updateComment(Comments com);
  Future<ApiResponse> deleteComment(int idComment);
  Future<ApiResponse> likeUnLikeComment(int idComment);
}
