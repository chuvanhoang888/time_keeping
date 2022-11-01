import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/data/models/work/work_comment.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/work_comment_service.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WorkCommentsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<WorkComment> _workCommentListModel = [];

  bool get loading => _loading;
  List<WorkComment> get workCommentListModel => _workCommentListModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setWorkCommentListModel(List<WorkComment> workCommentListModel) {
    _workCommentListModel = workCommentListModel;
  }

  getWorkComments(BuildContext context, int idWork) async {
    setLoading(true);
    var response = await WorkCommentService().getAllWorkComment(idWork);

    if (response.error == null) {
      setWorkCommentListModel(response.data as List<WorkComment>);
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
      debugPrint(response.error!);
    }
    setLoading(false);
  }

  deleteWorkComment(BuildContext context, int idWorkComment) async {
    var response = await WorkCommentService().deleteWorkComment(idWorkComment);

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
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error!);
    }
  }

  updateComment(BuildContext context, WorkComment workComment) async {
    var response = await WorkCommentService().editWorkComment(workComment);

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
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error!);
    }
  }

  Future<void> createWorkComment(
      BuildContext context, int idWork, String content) async {
    var response =
        await WorkCommentService().createWorkComment(idWork, content);

    if (response.error == null) {
      getWorkComments(context, idWork);
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
      debugPrint(response.error!);
    }
  }
}
