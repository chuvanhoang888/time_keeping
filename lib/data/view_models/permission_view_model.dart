import 'package:app_cham_cong_option_2/data/models/home/permission.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/permisions_service.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PermissionViewModel extends ChangeNotifier {
  bool _loading = false;
  List<PermissonModel> _permissionListModel = [];

  bool get loading => _loading;
  List<PermissonModel> get permissionListModel => _permissionListModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setPermission(List<PermissonModel> permission) async {
    _permissionListModel = permission;
  }

  PermissionViewModel(context) {
    getAllPermission(context);
  }

  Future<void> createPermission(
      BuildContext context, String time, day, content, type, toMail) async {
    setLoading(true);
    var response = await PermissionsMailService()
        .createPermission(time, day, content, type, toMail);

    if (response.error == null) {
      getAllPermission(context);
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

  Future<void> getAllPermission(BuildContext context) async {
    setLoading(true);
    var response = await PermissionsMailService().getPermission();

    if (response.error == null) {
      setPermission(response.data as List<PermissonModel>);
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

  Future<void> deletePermission(BuildContext context, int id) async {
    setLoading(true);
    var response = await PermissionsMailService().deletePermission(id);

    if (response.error == null) {
      getAllPermission(context);
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
}
