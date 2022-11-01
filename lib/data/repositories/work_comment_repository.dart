import 'package:app_cham_cong_option_2/data/models/work/work_comment.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class WorkCommentRepository {
  Future<ApiResponse> getAllWorkComment(int idWork);
  Future<ApiResponse> createWorkComment(int idWork, String content);
  Future<ApiResponse> editWorkComment(WorkComment workComment);
  Future<ApiResponse> deleteWorkComment(int idWorkComment);
}
