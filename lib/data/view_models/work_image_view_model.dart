import 'dart:io';
import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/data/models/work/work_image.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/work_image_service.dart';
import 'package:app_cham_cong_option_2/photo_picker/album_image.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WorkImageViewModel extends ChangeNotifier {
  bool _loading = false;

  final List<WorkImage> _fileImageArray = [];
  List<WorkImage> _workImageList = [];

  bool get loading => _loading;
  List<WorkImage> get fileImageArray => _fileImageArray;
  List<WorkImage> get workImageList => _workImageList;
  // WorkTodoViewModel(context) {
  //   getTodos(context, selectedWork.id!);
  // }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setWorkImage(List<WorkImage> workImageList) {
    _workImageList = workImageList;
  }

  updateStateWorkImage(int index) {
    //var image = workImageList.elementAt(index);
    workImageList.removeAt(index);
    notifyListeners();
  }

  Future<void> getWorkImages(BuildContext context, int idWork) async {
    setLoading(true);
    var response = await WorkImageService().getAllWorkImage(idWork);

    if (response.error == null) {
      _fileImageArray.clear();
      setWorkImage(response.data as List<WorkImage>);
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
    setLoading(false);
  }

  Future<void> deleteWorkImages(
      BuildContext context, int indexImage, int idWorkImage) async {
    updateStateWorkImage(indexImage);
    var response = await WorkImageService().deleteWorkImage(idWorkImage);

    if (response.error == null) {
      //updateStateWorkImage(indexImage);
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

  Future<void> pickerImage(BuildContext context) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const AlbumImages(
                  maxSelection: 20,
                )));

    if (result != null) {
      _fileImageArray.clear();
      for (int i = 0; i < result.length; i++) {
        _fileImageArray.add(WorkImage(path: result[i].path));
      }
      notifyListeners();
    } else {
      //
    }
  }

  createImageWork(
      BuildContext context, int idWork, List<WorkImage> imageFiles) async {
    for (int i = 0; i < imageFiles.length; i++) {
      imageFiles[i].state = 1;
      notifyListeners();
      await uploadWorkImage(context, idWork, File(imageFiles[i].path!))
          .whenComplete(() {
        imageFiles[i].state = 2;
        notifyListeners();
      });
    }
  }

  Future<void> uploadWorkImage(context, int idWork, File image) async {
    var response = await WorkImageService().uploadWorkImage(idWork, image);

    if (response.error == null) {
      var workImage = response.data as WorkImage;
      workImageList.insert(
          0,
          WorkImage(
              id: workImage.id,
              images: workImage.images,
              workId: workImage.workId));
      notifyListeners();
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
