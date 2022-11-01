import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/history_service.dart';
import 'package:flutter/material.dart';

class HistoryViewModel extends ChangeNotifier {
  bool _loading = false;
  String _param = "all";

  bool get loading => _loading;
  String get param => _param;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setparam(String param) async {
    _param = param;
    notifyListeners();
  }

  Future<void> getHistory(
    BuildContext context,
  ) async {
    setLoading(true);
    var response = await HitoryService().getHistory(param);

    if (response.error == null) {
      //_saveAndRedirectToHome(response.data as UserModel);

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
