import 'dart:io';
import 'package:app_cham_cong_option_2/data/models/components/user_image.dart';
import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/photo_picker/album_image.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthViewModel extends ChangeNotifier {
  bool _loading = false;
  UserModel? _userModel;
  List<UserModel> _userListModel = [];
  UserImage? fileImage;

  bool get loading => _loading;
  UserModel get userModel => _userModel!;
  List<UserModel> get userListModel => _userListModel;

  AuthViewModel(context) {
    getUserDetail(context);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserModel(UserModel userModel) async {
    _userModel = userModel;
  }

  setUserListModel(List<UserModel> userListModel) async {
    _userListModel = userListModel;
  }

  updateStateUserModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  getUserDetail(BuildContext context) async {
    setLoading(true);
    var response = await AuthService().getUserDetail();

    if (response.error == null) {
      setUserModel(response.data as UserModel);
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
      debugPrint(response.error!);
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error!);
    }
    setLoading(false);
  }

  // void updateList(int index) {
  //   postListModel.removeAt(index);
  //   notifyListeners();
  // }

  updateImageUser(BuildContext context, File _image) async {
    var response = await AuthService().updateImageUser(_image);

    if (response.error == null) {
      updateStateUserModel(response.data as UserModel);
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
  }

  ///////////////////////////////////////////////////////////////////
  Future<void> pickerImage(BuildContext context) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const AlbumImages(
                  maxSelection: 1,
                )));

    if (result != null) {
      fileImage = null;

      fileImage = UserImage(path: result[0].path);

      notifyListeners();
    } else {
      //
    }
  }

  createImageUser(BuildContext context, UserImage imageFile) async {
    imageFile.state = 1;
    notifyListeners();
    await updateImageUser(context, File(imageFile.path!)).whenComplete(() {
      imageFile.state = 2;
      notifyListeners();
    });
  }
}
