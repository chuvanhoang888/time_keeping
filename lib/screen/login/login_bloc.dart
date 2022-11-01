import 'dart:async';

import 'package:app_cham_cong_option_2/validators/validations.dart';

class LoginBloc {
  final StreamController _userController = StreamController();
  final StreamController _passController = StreamController();

  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;

  bool isValidInfo(String username, String pass) {
    if (!Validations.isValidUser(username)) {
      _userController.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    if (!Validations.isValidPass(pass)) {
      _passController.sink.addError("Mật khẩu phải trên 6 ký tự");
      return false;
    }
    _userController.sink.add("Ok");
    _passController.sink.add("Ok");
    return true;
  }

  dispose() {
    _userController.close();
    _passController.close();
  }
}
