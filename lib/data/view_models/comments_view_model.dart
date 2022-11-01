import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/comments.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/like_comment.dart';

import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/comment_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Comments> _commentListModel = [];

  bool get loading => _loading;
  List<Comments> get commentListModel => _commentListModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  void toggleLike(int index, LikeComment like) {
    var itemComment = commentListModel[index];

    final isExist = itemComment.likes.isNotEmpty;

    if (isExist) {
      itemComment.likes = [];
      itemComment.likesCount = itemComment.likesCount! - 1;
    } else {
      itemComment.likes.add(like);
      itemComment.likesCount = itemComment.likesCount! + 1;
    }
    notifyListeners();
    //debugPrint(itemPost.toJson().toString());
  }

  bool isExist(int index) {
    var itemComment = commentListModel[index];
    final isExist = itemComment.likes.isNotEmpty;
    return isExist;
  }

  //////////////////////////////////////////////////////////////
  updateStateComment(int index, String content) {
    var item = commentListModel[index];
    item.content = content;
    notifyListeners();
  }

  updateStateDelete(int index) {
    commentListModel.removeAt(index);

    notifyListeners();
  }

  setCommentListModel(List<Comments> commentListModel) {
    _commentListModel = commentListModel;
  }

  getComments(BuildContext context, int idPost) async {
    setLoading(true);
    var response = await CommentService().getCommentsForPost(idPost);

    if (response.error == null) {
      setCommentListModel(response.data as List<Comments>);
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
    setLoading(false);
  }

  // void updateList(int index) {
  //   postListModel.removeAt(index);
  //   notifyListeners();
  // }

  deleteComment(BuildContext context, int idComment) async {
    var response = await CommentService().deleteComment(idComment);

    if (response.error == null) {
      //
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

  updateComment(BuildContext context, Comments comment) async {
    var response = await CommentService().updateComment(comment);

    if (response.error == null) {
      //
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

  Future<void> uploadComments(
      BuildContext context, int idPost, String content) async {
    var response = await CommentService().uploadComments(idPost, content);

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

  Future<void> handleCommentLikeAndDislike(
      BuildContext context, int idComment) async {
    var response = await CommentService().likeUnLikeComment(idComment);
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
}
