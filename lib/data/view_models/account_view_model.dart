import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/account_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';

class AccountViewModel extends ChangeNotifier {
  bool _loading = false;

  List<Posts> _postListModel = [];

  bool get loading => _loading;

  List<Posts> get postListModel => _postListModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setPostListModel(List<Posts> posts) async {
    _postListModel = posts;
  }

  getPostForUser(BuildContext context, int idUser) async {
    setLoading(true);
    var response = await AccountService().getPostForUser(idUser);

    if (response.error == null) {
      setPostListModel(response.data as List<Posts>);
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
}
