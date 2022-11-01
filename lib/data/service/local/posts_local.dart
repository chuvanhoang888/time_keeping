// import 'dart:convert';
// import 'dart:io';

// import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
// import 'package:app_cham_cong_option_2/data/models/dts_feed/comments.dart';
// import 'package:app_cham_cong_option_2/data/repositories/dts/post_repository.dart';
// import 'package:app_cham_cong_option_2/data/repositories/image/image_repository.dart';
// import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
// import 'package:dio/dio.dart';

// class PostsApi implements PostRepository, ImageRepository {
//   @override
//   Future<List<Posts>> getAllPosts() async {
//     final dio = Dio();
//     try {
//       final response = await dio.get(
//         Config.url + Config.getAllPost,
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> mapResponse = json.decode(response.data);

//         if (mapResponse["message"] == "ok") {
//           final listPosts = await mapResponse["data"].map<Posts>((json) {
//             return Posts.fromJson(json);
//           }).toList();
//           return listPosts;
//         } else {
//           return [];
//         }
//       } else {
//         return [];
//       }
//     } catch (e) {
//       return throw Exception('Failed to get all Post');
//     }
//   }

//   @override
//   Future<List<Comments>> getCommentsForPost(String idPost) async {
//     final dio = Dio();
//     try {
//       final response = await dio.get(
//         Config.url + Config.getCommentPosts + idPost,
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> mapResponse = json.decode(response.data);

//         if (mapResponse["message"] == "ok") {
//           final listCommentsPost =
//               await mapResponse["data"].map<Comments>((json) {
//             return Comments.fromJson(json);
//           }).toList();
//           return listCommentsPost;
//         } else {
//           return [];
//         }
//       } else {
//         return [];
//       }
//     } catch (e) {
//       throw Exception('Failed to get Comment for Post');
//     }
//   }

//   @override
//   Future<bool> uploadComments(Comments com) async {
//     final dio = Dio();
//     try {
//       final response =
//           await dio.post(Config.url + Config.addComments, data: com.toJson());

//       if (response.statusCode == 200) {
//         Map<String, dynamic> mapResponse = json.decode(response.data);

//         if (mapResponse["message"] == "ok") {
//           return true;
//         } else {
//           return false;
//         }
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//       //throw Exception('Failed to Add Comment');
//     }
//   }

//   @override
//   Future<bool> uploadPost(Posts post) {
//     // TODO: implement uploadPost
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> uploadFile(File _image) {
//     // TODO: implement uploadFile
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<String>> uploadFiles(List<File> _images) {
//     // TODO: implement uploadFiles
//     throw UnimplementedError();
//   }

//   @override
//   Future<bool> deletePost(String idPost) {
//     // TODO: implement deletePost
//     throw UnimplementedError();
//   }

//   @override
//   Future<bool> updatePost(Posts posts) {
//     // TODO: implement updatePost
//     throw UnimplementedError();
//   }

//   @override
//   Future<bool> deleteComment(String idComment) {
//     // TODO: implement deleteComment
//     throw UnimplementedError();
//   }

//   @override
//   Future<bool> updateComment(Comments com) {
//     // TODO: implement updateComment
//     throw UnimplementedError();
//   }
// }
