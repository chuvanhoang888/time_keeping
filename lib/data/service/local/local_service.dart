// import 'dart:convert';

// import 'package:app_cham_cong_option_2/data/models/dts_feed/comments.dart';
// import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
// import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';

// class DBService {
//   // get all posts
//   Future<List<Posts>> fetchAllPosts() async {
//     try {
//       final response = await rootBundle
//           .loadString("lib/data/service/local/jsonFile/posts.json");

//       Map<String, dynamic> mapResponse = json.decode(response);

//       if (mapResponse["message"] == "ok") {
//         final listPosts = await mapResponse["data"].map<Posts>((json) {
//           return Posts.fromJson(json);
//         }).toList();
//         return listPosts;
//       } else {
//         return [];
//       }
//     } catch (e) {
//       return throw Exception('Failed to get all Post');
//     }
//   }

//   // get comment for post
//   Future<List<Comments>> fetchComments() async {
//     try {
//       final response = await rootBundle
//           .loadString("lib/data/service/local/jsonFile/comments.json");

//       Map<String, dynamic> mapResponse = json.decode(response);

//       if (mapResponse["message"] == "ok") {
//         final listComment = await mapResponse["data"].map<Comments>((json) {
//           return Comments.fromJson(json);
//         }).toList();
//         return listComment;
//       } else {
//         return [];
//       }
//     } catch (e) {
//       return throw Exception('Failed to get Comments');
//     }
//   }

//   // add comment for post
//   Future<bool> addComments(Comments com) async {
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
// }
