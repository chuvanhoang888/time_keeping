import 'package:app_cham_cong_option_2/data/models/home/notifications.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Notifications> _notificationListModel = [];

  bool get loading => _loading;
  List<Notifications> get notificationListModel => _notificationListModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setNotification(List<Notifications> notification) async {
    _notificationListModel = notification;
  }

  NotificationViewModel(context) {
    getAllNotification(context);
  }

  Future<void> createNotification(
      BuildContext context, String name, content, time) async {
    setLoading(true);
    var response =
        await NotificationService().createNotification(name, content, time);

    if (response.error == null) {
      getAllNotification(context);
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

  Future<void> getAllNotification(BuildContext context) async {
    setLoading(true);
    var response = await NotificationService().getNotification();

    if (response.error == null) {
      setNotification(response.data as List<Notifications>);
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
}
