import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/screen/home_page.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context, String name, password) async {
    setLoading(true);
    var response = await AuthService().login(name, password);

    if (response.error == null) {
      //_saveAndRedirectToHome(response.data as UserModel);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
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
