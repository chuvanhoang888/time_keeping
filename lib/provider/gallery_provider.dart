import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryProvider extends ChangeNotifier {
  List<AssetEntity> imageList = [];

  void add(AssetEntity entity) {
    imageList.add(entity);
    notifyListeners();
  }

  void removeA(AssetEntity entity) {
    imageList.remove(entity);
    notifyListeners();
  }
}
