import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagesProviderDts extends ChangeNotifier {
  List<XFile>? imageFileList = [];

  void add(List<XFile>? pickedFileList) {
    imageFileList!.addAll(pickedFileList!);
    notifyListeners();
  }

  void removeImage(int index) {
    imageFileList!.removeAt(index);
    notifyListeners();
  }
}
