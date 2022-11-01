import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class PostUserTagRepository {
  Future<ApiResponse> getUserTag(int idPost);
  Future<ApiResponse> insertUserTag(int idPost, idUser);
  Future<ApiResponse> deleteUserTag(int idCheckInUser);
}
