import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/comments_reply.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/post_reply.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/comment_reply_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';

class CommentReplyViewModel extends ChangeNotifier {
  bool _loading = false;
  //List<CommentsReply> _commentReplyListModel = [];
  List<PostReply> _postReplyListModel = [];

  bool get loading => _loading;
  //List<CommentsReply> get commentReplyListModel => _commentReplyListModel;
  List<PostReply> get postReplyListModel => _postReplyListModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  // CommentReplyViewModel() {
  //   _postReplyListModel.clear();
  // }

  setPostReplyListModel(List<CommentsReply> commentReplyModel, int idComment) {
    _postReplyListModel
        .add(PostReply(replies: commentReplyModel, commentId: idComment));
    notifyListeners();
  }

  getComments(BuildContext context, int idComment) async {
    setLoading(true);
    var response = await CommentReplyService().getCommentsReply(idComment);

    if (response.error == null) {
      setPostReplyListModel(response.data as List<CommentsReply>, idComment);
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
    setLoading(false);
  }

  // void updateList(int index) {
  //   postListModel.removeAt(index);
  //   notifyListeners();
  // }

  deleteComment(BuildContext context, int idCommentReply) async {
    var response =
        await CommentReplyService().deleteCommentReply(idCommentReply);

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

  updateComment(BuildContext context, CommentsReply comment) async {
    var response = await CommentReplyService().updateCommentReply(comment);

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

  Future<void> uploadCommentReply(
      BuildContext context, int idComment, String content) async {
    var response =
        await CommentReplyService().uploadCommentsReply(idComment, content);

    if (response.error == null) {
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
}
