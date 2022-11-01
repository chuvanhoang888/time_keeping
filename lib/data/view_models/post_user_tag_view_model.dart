import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/user_tag.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/post_user_tag_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/posts_service.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';

class PostUserTagViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UserModel> _userList = [];
  List<UserTag> _userTagList = [];
  List<UserModel> listMember = [];

  bool get loading => _loading;
  List<UserModel> get userList => _userList;
  List<UserTag> get userTagList => _userTagList;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserList(List<UserModel> userList) {
    _userList = userList;
  }

  setCheckInUser(List<UserTag> userTagList) {
    _userTagList = userTagList;
    //Tại vì cần có idWork để get Data nên sử dụng WidgetsBinding.instance.addPostFrameCallback => việc lấy data phải chờ khi build xây dựng xong
    setSelectedCheckIn();
    //đặt setSelectedUserList ở đây sau khi get data work user thành công
  }

  PostUserTagViewModel(context) {
    getAllUser(context);
  }

  void addMembder(BuildContext context, int index) {
    var user = userList.elementAt(index);
    listMember.add(user);
    user.selected = true;
    //insertCheckInUser(context, idPost, user.id);
    notifyListeners();
  }

  void removeMember(BuildContext context, int index) {
    var user = userList.elementAt(index);
    listMember.remove(user);
    user.selected = false;
    //deleteCheckInUser(context, idCheckInUser);
    notifyListeners();
  }

  setSelectedCheckIn() {
    // debugPrint("workUser" + workUser.length.toString());
    // debugPrint("userListModel" + userListModel.length.toString());
    listMember.clear();
    for (int i = 0; i < userTagList.length; i++) {
      for (int j = 0; j < userList.length; j++) {
        if (userList[j].id == userTagList[i].userId) {
          userList[j].selected = true;
          // userList[j].idWorkUser = workUser[i].id;
          listMember.add(userList[j]);
        }
      }
    }
    notifyListeners();
  }

  Future<void> getAllUser(BuildContext context) async {
    setLoading(true);
    var response = await PostsService().getAllUser();

    if (response.error == null) {
      setUserList(response.data as List<UserModel>);
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

  Future<void> getUserTag(BuildContext context, int idPost) async {
    setLoading(true);
    var response = await PostUserTagService().getUserTag(idPost);

    if (response.error == null) {
      setCheckInUser(response.data as List<UserTag>);
      //debugPrint((response.data as List<WorkUser>).toString());
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

  //create user work
  Future<void> insertUserTag(context, int idPost, idUser) async {
    var response = await PostUserTagService().insertUserTag(idPost, idUser);

    if (response.error == null) {
      //getTodos(context, idWork);

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

  //delete user work
  Future<void> deleteUserTag(context, int idCheckInUser) async {
    var response = await PostUserTagService().deleteUserTag(idCheckInUser);

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
