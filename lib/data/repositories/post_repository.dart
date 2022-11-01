import 'dart:io';

import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';

abstract class PostRepository {
  Future<void> getAllPosts(int pageSize, int page);
  Future<void> createPost(String content, String timeAgo, List<File> images,
      List<UserModel> usertags);
  Future<void> editPost(Posts posts, List<File> imageFiles);
  Future<void> deletePost(int idPost);
  Future<void> deletePostImage(int idPostImage);
  Future<ApiResponse> likeUnLikePost(int idPost);
}
