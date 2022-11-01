import 'dart:io';
import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/likes.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/posts_service.dart';
import 'package:app_cham_cong_option_2/screen/home_page.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostsViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _likeColor = false;
  int page = 0;
  bool _hasMore = true;
  static const limit = 5;

  List<Posts> _postListModel = [];

  late Posts _selectedPost;

  bool get loading => _loading;
  bool get likeColor => _likeColor;
  List<Posts> get postListModel => _postListModel;
  Posts get selectedPost => _selectedPost;
  bool get hasMore => _hasMore;

  sethasMore(bool hasMore) {
    _hasMore = hasMore;
    notifyListeners();
  }

  setPages(List<Posts> posts) {
    page++;
    if (posts.length < limit) {
      sethasMore(false);
    }
    notifyListeners();
  }

  PostsViewModel(context) {
    getPosts(context);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setLikeColor(bool likeColor) async {
    _likeColor = likeColor;
    notifyListeners();
  }

  // post list
  setPostListModel(List<Posts> postListModel) {
    _postListModel = postListModel;
  }

  // new item add post
  setNewPostListModel(List<Posts> postListModel) {
    _postListModel.addAll(postListModel);
    notifyListeners();
  }

  setPostSelected(Posts post) {
    _selectedPost = post;
  }

  clearCache() {
    page = 0;
    _hasMore = true;
    _postListModel.clear();
  }

  getPosts(BuildContext context) async {
    clearCache();
    setLoading(true);

    var response = await PostsService().getAllPosts(limit, page);

    if (response.error == null) {
      var itemPost = response.data as List<Posts>;
      setPostListModel(itemPost);
      page++;
    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error);
    }
    setLoading(false);
  }

  getNewItemPost(BuildContext context) async {
    var response = await PostsService().getAllPosts(limit, page);
    if (response.error == null) {
      var newItemPost = response.data as List<Posts>;
      setPages(newItemPost);
      setNewPostListModel(newItemPost);
    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error);
    }
  }

  Future<void> createPostDts(context, String content, String time, images,
      List<UserModel> usertags) async {
    var response =
        await PostsService().createPost(content, time, images, usertags);

    if (response.error == null) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   backgroundColor: kBackgroundColor,
      //   content: Text("Tải bài viết lên thành công"),
      //   duration: Duration(seconds: 3),
      // ));
      getPosts(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(
                    currentTab: 2,
                  )),
          (route) => false);
    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     duration: const Duration(seconds: 5),
      //     behavior: SnackBarBehavior.floating,
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //     content: CustomSnackBarError(
      //       error: response.error!,
      //     )));
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error);
    }
  }

  void updateList(int index) {
    postListModel.removeAt(index);
    notifyListeners();
  }

  void updateStateCommentCount(int index) {
    var item = postListModel[index];
    item.commentCount = item.commentCount! + 1;
    notifyListeners();
  }

  void updateStateRemoveCommentCount(int index) {
    var item = postListModel[index];
    item.commentCount = item.commentCount! - 1;
    notifyListeners();
  }

  void updateImageState(int index, indexImage) {
    var item = postListModel.elementAt(index);
    item.imagesPost!.removeAt(indexImage);
    notifyListeners();
  }

  deletePost(context, int index, idPost) async {
    var response = await PostsService().deletePost(idPost);

    if (response.error == null) {
      updateList(index);
    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: CustomSnackBarError(
            error: response.error!,
          )));
    }
  }

  // void likeAndDislikeItem(int index) {
  //   var itemPost = postListModel.elementAt(index);
  //   if (itemPost.likesList.isNotEmpty) {
  //     for (int i = 0; i < itemPost.likesList.length; i++) {
  //       if (itemPost.likesList[i].userId == itemPost.userModel.id) {
  //         itemPost.likesList.remove(itemPost.likesList[i]);
  //         setLikeColor(false);
  //       } else {
  //         itemPost.likesList.add(Likes(
  //             id: 0, userId: itemPost.userModel.id, postID: itemPost.idPost));
  //         setLikeColor(true);
  //       }
  //     }
  //   } else {
  //     itemPost.likesList.add(
  //         Likes(id: 0, userId: itemPost.userModel.id, postID: itemPost.idPost));
  //     setLikeColor(true);
  //   }
  //   notifyListeners();
  // }

  // void toggleFavourite(int index, Likes like) {
  //   var itemPost = postListModel.elementAt(index);

  //   final isExist = itemPost.likes.contains(like);

  //   if (isExist) {
  //     itemPost.likes.remove(like);
  //     itemPost.likesCount = itemPost.likesCount! - 1;
  //   } else {
  //     itemPost.likes.add(like);
  //     itemPost.likesCount = itemPost.likesCount! + 1;
  //   }
  //   notifyListeners();
  //   debugPrint(itemPost.toJson().toString());
  // }

  // bool isExist(int index, Likes like) {
  //   var itemPost = postListModel.elementAt(index);
  //   final isExist = itemPost.likes.contains(like);
  //   return isExist;
  // }

  void toggleFavourite(int index, Likes like) {
    var itemPost = postListModel[index];

    final isExist = itemPost.likes.isNotEmpty;

    if (isExist) {
      itemPost.likes = [];
      itemPost.likeCount = itemPost.likeCount! - 1;
    } else {
      itemPost.likes.add(like);
      itemPost.likeCount = itemPost.likeCount! + 1;
    }
    notifyListeners();
    //debugPrint(itemPost.toJson().toString());
  }

  bool isExist(int index) {
    var itemPost = postListModel[index];
    final isExist = itemPost.likes.isNotEmpty;
    return isExist;
  }

  // void likeAndDislikeItem() {
  //   if (_selectedPost.getSelfLike()) {
  //     _selectedPost.likesCount = _selectedPost.likesCount! - 1;
  //   } else {
  //     _selectedPost.likesCount = _selectedPost.likesCount! + 1;
  //   }
  //   notifyListeners();
  // }

  Future<void> handlePostLikeAndDislike(
      BuildContext context, int idPost) async {
    var response = await PostsService().likeUnLikePost(idPost);
    if (response.error == null) {
    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     duration: const Duration(seconds: 3),
      //     behavior: SnackBarBehavior.floating,
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //     content: CustomSnackBarError(
      //       error: response.error!,
      //     )));
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error);
    }
  }

  //delete image post
  Future<void> deletePostImage(
      context, int idPostImage, index, indexImage) async {
    updateImageState(index, indexImage);
    var response = await PostsService().deletePostImage(idPostImage);

    if (response.error == null) {
      //getTodos(context, todo.workId!);

    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     duration: const Duration(seconds: 5),
      //     behavior: SnackBarBehavior.floating,
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //     content: CustomSnackBarError(
      //       error: response.error!,
      //     )));
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error);
    }
  }

  // update post
  Future<void> editPostDts(context, Posts post, List<File> imageFiles) async {
    var response = await PostsService().editPost(post, imageFiles);

    if (response.error == null) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   backgroundColor: kBackgroundColor,
      //   content: Text("Tải bài viết lên thành công"),
      //   duration: Duration(seconds: 3),
      // ));
      //getPosts(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(
                    currentTab: 2,
                  )),
          (route) => false);
    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: CustomSnackBarError(
            error: response.error!,
          )));
    }
  }
}
