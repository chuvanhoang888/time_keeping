import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/models/work/work_user.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/work_user_service.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WorkUserViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _loadingUser = false;

  List<UserModel> _userListModel = [];
  List<WorkUser> _workUser = [];
  List<UserModel> listMember = [];

  bool get loading => _loading;
  bool get loadingUser => _loadingUser;

  List<UserModel> get userListModel => _userListModel;
  List<WorkUser> get workUser => _workUser;

  WorkUserViewModel(context) {
    getAllUser(context);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setSelectedUserList() {
    debugPrint("workUser" + workUser.length.toString());
    debugPrint("userListModel" + userListModel.length.toString());
    listMember.clear();
    for (int i = 0; i < workUser.length; i++) {
      for (int j = 0; j < userListModel.length; j++) {
        if (userListModel[j].id == workUser[i].userId) {
          userListModel[j].selected = true;
          userListModel[j].idWorkUser = workUser[i].id;
          listMember.add(userListModel[j]);
        }
      }
    }
    notifyListeners();
  }

  setLoadingUser(bool loading) async {
    _loadingUser = loading;
    notifyListeners();
  }

  void addMembder(BuildContext context, int index, idWork) {
    var user = userListModel.elementAt(index);
    listMember.add(user);
    user.selected = true;
    insertWorkUser(context, idWork, user.id);
    notifyListeners();
  }

  void removeMember(BuildContext context, int index, idWorkUser) {
    var user = userListModel.elementAt(index);
    listMember.remove(user);
    user.selected = false;
    deleteWorkUser(context, idWorkUser);
    notifyListeners();
  }

  setUserListModel(List<UserModel> userListModel) {
    _userListModel = userListModel;
  }

  setWorkUser(List<WorkUser> workUser) {
    _workUser = workUser;
    debugPrint(workUser.length.toString());
    //Tại vì cần có idWork để get Data nên sử dụng WidgetsBinding.instance.addPostFrameCallback => việc lấy data phải chờ khi build xây dựng xong
    setSelectedUserList();
    //đặt setSelectedUserList ở đây sau khi get data work user thành công
  }

  Future<void> getAllUser(BuildContext context) async {
    setLoading(true);
    var response = await WorkUserService().getAllUser();

    if (response.error == null) {
      setUserListModel(response.data as List<UserModel>);
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
      debugPrint(response.error!);
    }
    setLoading(false);
  }

  Future<void> getWorkUser(BuildContext context, int idWork) async {
    setLoadingUser(true);
    var response = await WorkUserService().getWorkUser(idWork);

    if (response.error == null) {
      setWorkUser(response.data as List<WorkUser>);
      //debugPrint((response.data as List<WorkUser>).toString());
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
    setLoadingUser(false);
  }

  //create user work
  Future<void> insertWorkUser(context, int idWork, idUser) async {
    var response = await WorkUserService().insertWorkUser(idWork, idUser);

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
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error!);
    }
  }

  //delete user work
  Future<void> deleteWorkUser(context, int idWorkUser) async {
    var response = await WorkUserService().deleteWorkUser(idWorkUser);

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
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error!);
    }
  }
}
