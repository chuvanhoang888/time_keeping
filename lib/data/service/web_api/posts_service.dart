import 'dart:io';
import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
import 'package:app_cham_cong_option_2/data/repositories/post_repository.dart';
import 'package:app_cham_cong_option_2/data/repositories/image_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PostsService implements PostRepository, ImageRepository {
  ApiResponse apiResponse = ApiResponse();
  @override
  Future<ApiResponse> getAllPosts(int pageSize, int page) async {
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(
          Config.postURL +
              "?pageSize=" +
              pageSize.toString() +
              "&page=" +
              page.toString(),
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data = await data["posts"].map<Posts>((json) {
          return Posts.fromJson(json);
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

  //create post
  @override
  Future<ApiResponse> createPost(String content, String timeAgo,
      List<File> _imageFileList, List<UserModel> usertags) async {
    List<dynamic> _documents = [];
    List<int> _userId = [];
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      for (int i = 0; i < _imageFileList.length; i++) {
        var fileName = _imageFileList[i].path.split('/').last;
        var path = _imageFileList[i].path;
        _documents.add(await MultipartFile.fromFile(path, filename: fileName));
      }

      if (usertags.isNotEmpty) {
        for (int i = 0; i < usertags.length; i++) {
          var userId = usertags[i].id;
          _userId.add(userId);
        }
      } else {
        _userId = [];
      }
      // final data = {
      //   'content': content,
      //   'time_ago': timeAgo,
      //   'tags[]': _userId,
      //   'files[]': _documents
      // };
      FormData formData = FormData.fromMap({
        "content": content,
        "time_ago": timeAgo,
        "tags[]": _userId,
        "files[]": _documents,
      });
      debugPrint(formData.fields.toString());

      final response = await dio.post(Config.postURL,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: formData);

      if (response.statusCode == 200) {
        var data = response.data;
        apiResponse.data = data['post'];
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
  // @override
  // Future<ApiResponse> createPost(String content, List<String> images) async {
  //   ApiResponse apiResponse = ApiResponse();
  //   final dio = Dio();
  //   try {
  //     String token = await getToken();
  //     var data = {"content": content, "images": images};
  //     final response = await dio.post(Config.postsURL,
  //         options: Options(headers: {
  //           'Accept': 'application/Json',
  //           'Authorization': 'Bearer $token'
  //         }),
  //         data: data);

  //     if (response.statusCode == 200) {
  //       var data = response.data;
  //       apiResponse.data = data['message'];
  //     } else {
  //       //
  //     }
  //   } on DioError catch (e) {
  //     if (e.response!.statusCode == 422) {
  //       var data = e.response!.data;
  //       final errors = data['errors'];
  //       apiResponse.error = errors[errors.keys.elementAt(0)][0];
  //     } else if (e.response!.statusCode == 401) {
  //       apiResponse.error = Config.unauthorized;
  //     } else {
  //       apiResponse.error = e.toString();
  //     }
  //   }
  //   return apiResponse;
  // }

  // edit Post
  @override
  Future<ApiResponse> editPost(Posts posts, List<File> imageFiles) async {
    ApiResponse apiResponse = ApiResponse();
    List<dynamic> _documents = [];
    final dio = Dio();
    try {
      String token = await AuthService().getToken();

      for (int i = 0; i < imageFiles.length; i++) {
        var fileName = imageFiles[i].path.split('/').last;
        var path = imageFiles[i].path;
        _documents.add(await MultipartFile.fromFile(path, filename: fileName));
      }

      FormData formData = FormData.fromMap({
        "content": posts.content,
        "view_count": posts.view,
        "off_comment": posts.offComment,
        "imagesPost[]": _documents,
      });
      final response = await dio.post(
          Config.postURL + "/" + posts.idPost.toString(),
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

  // Delete post
  @override
  Future<ApiResponse> deletePost(int idPost) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.delete(
          Config.postURL + "/" + idPost.toString(),
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

  // @override
  // Future<bool> uploadComments(Comments com) async {
  //   final dio = Dio();
  //   try {
  //     final response =
  //         await dio.post(Config.url + Config.addComments, data: com.toJson());

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> mapResponse = json.decode(response.data);

  //       if (mapResponse["message"] == "ok") {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to upload Comment');
  //   }
  // }

  @override
  Future<List<String>> uploadFiles(List<File> _images) async {
    var imageUrls = await Future.wait(_images.map((_image) {
      return uploadFile(_image);
    }));

    return imageUrls;
  }

  @override
  Future<String> uploadFile(File _image) async {
    //String fileName = path.basename(_image.path);
    String fileName = _image.path.split('/').last;
    final dio = Dio();
    String? urlImage;

    try {
      String token = await AuthService().getToken();
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(_image.path, filename: fileName),
      });

      final response = await dio.post(Config.uploadImagePost,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: formData);

      if (response.statusCode == 200) {
        var data = response.data;

        urlImage = data['url_photo'];
      } else {}
    } catch (e) {
      print(e.toString);
    }
    return urlImage!;
  }

  @override
  Future<ApiResponse> uploadMultiImagePost(List<File> _imageFileList) async {
    List<MultipartFile> _documents = [];
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      for (int i = 0; i < _imageFileList.length; i++) {
        var fileName = _imageFileList[i].path.split('/').last;
        var path = _imageFileList[i].path;
        _documents.add(await MultipartFile.fromFile(path, filename: fileName));
      }
      debugPrint("formData" + _documents.toString());
      FormData formData = FormData.fromMap({
        "files": _documents,
      });

      final response = await dio.post(Config.uploadImagePost,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: formData);

      if (response.statusCode == 200) {
        var data = response.data;
        apiResponse.data = data['url_photo'];
      }
    } catch (e) {
      apiResponse.error = e.toString();
      debugPrint("Error: " + e.toString());
    }
    return apiResponse;
  }

  @override
  Future<ApiResponse> likeUnLikePost(int idPost) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.post(
          Config.postLikeURL + "/" + idPost.toString(),
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

  @override
  Future<ApiResponse> deletePostImage(int idPostImage) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.delete(
          Config.deleteImagePost + "/$idPostImage",
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

  Future<ApiResponse> getAllUser() async {
    final dio = Dio();
    ApiResponse apiResponse = ApiResponse();
    //bool tokenExist = await getToken();
    try {
      String token = await AuthService().getToken();

      var response = await dio.get(Config.allUserURL,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        //saveToken(data['token']);
        apiResponse.data = await data["users"].map<UserModel>((json) {
          return UserModel.fromJson(json);
        }).toList();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 403) {
        apiResponse.error = e.response!.data['message'];
      } else if (e.response!.statusCode == 422) {
        var data = e.response!.data;
        final errors = data['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }
}
