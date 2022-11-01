import 'package:app_cham_cong_option_2/data/models/work/work.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/works_service.dart';
import 'package:app_cham_cong_option_2/screen/home_page.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WorkViewModel extends ChangeNotifier {
  bool _loading = false;

  List<Work> _workListModel = [];
  late Work _selectedWork;

  bool get loading => _loading;

  List<Work> get workListModel => _workListModel;
  Work get selectedWork => _selectedWork;

  WorkViewModel(context) {
    getWorks(context);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setWorkListModel(List<Work> workListModel) {
    _workListModel = workListModel;
  }

  setSelectedWork(Work work) {
    _selectedWork = work;
  }

  updateSelectedWorkPath(String path) {
    selectedWork.path = path;
    notifyListeners();
  }

  updateStateWorkList(int index, Work work) {
    var itemWork = workListModel.elementAt(index);
    itemWork.name = work.name;
    itemWork.startDay = work.startDay;
    itemWork.endDay = work.endDay;
    itemWork.path = work.path;
    itemWork.status = work.status;
    notifyListeners();
  }

  getWorks(BuildContext context) async {
    setLoading(true);
    var response = await WorksService().getAllWork();

    if (response.error == null) {
      setWorkListModel(response.data as List<Work>);
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

  Future<void> createWork(
      context, String name, startDay, endDay, dateTime) async {
    var response =
        await WorksService().createWork(name, startDay, endDay, dateTime);

    if (response.error == null) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   backgroundColor: kBackgroundColor,
      //   content: Text("Tải bài viết lên thành công"),
      //   duration: Duration(seconds: 3),
      // ));
      getWorks(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(
                    currentTab: 1,
                  )),
          (route) => false);
    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     duration: const Duration(seconds: 5),
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

  Future<void> editWork(context, Work work) async {
    var response = await WorksService().editWork(work);

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
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     duration: const Duration(seconds: 5),
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
}
