import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';

class GalleryMediaPickerScreen extends StatefulWidget {
  const GalleryMediaPickerScreen({Key? key}) : super(key: key);

  @override
  State<GalleryMediaPickerScreen> createState() =>
      _GalleryMediaPickerScreenState();
}

class _GalleryMediaPickerScreenState extends State<GalleryMediaPickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bài viết mới")),
      body: GalleryMediaPicker(
        /// required params
        pathList: (path) {
          /// => (type List<PickedAssetModel>) return a list map with selected media metadata
          /// returned data model
          //PickedAssetModel(
          //   'id': String,
          //   'path': String,
          //   'type': String,
          //   'videoDuration': Duration,
          //   'createDateTime': DateTime,
          //   'latitude': double,
          //   'longitude': double,
          //   'thumbnail': Uint8List,
          //   'height': double,
          //   'width': double,
          //   'orientationHeight': int,
          //   'orientationWidth': int,
          //   'orientationSize': Size,
          //   'file': Future<File>,
          //   'modifiedDateTime': DateTime,
          //   'title': String,
          //   'size': Size,
          // )
        },

        /// optional params
        maxPickImages: 9,

        /// (type int)
        singlePick: false,

        /// (type bool)
        appBarColor: Colors.white,

        /// (type Color)
        albumBackGroundColor: Colors.white,

        /// (type Color)
        /// (type Color)
        /// (type Color)
        appBarTextColor: Colors.black,
        albumTextColor: Colors.black,

        /// (type Color)
        crossAxisCount: 3,

        /// /// (type int)
        gridViewBackgroundColor: Colors.white,

        /// (type Color)
        childAspectRatio: 1,

        /// (type double)

        appBarHeight: 50,

        /// (type double)
        imageBackgroundColor: kSwitchColor,

        /// (type Color)
        albumDividerColor: Colors.blue,

        selectedBackgroundColor: Colors.white.withOpacity(0.2),

        /// (type Color)
        selectedCheckColor: kBackgroundColor,

        /// (type Color)

        selectedCheckBackgroundColor: Colors.white,
        thumbnailQuality: 100,

        /// (type Color)
        /// (type int) optional param, you can set the gallery thumbnail quality (higher is better but reduce performance)
      ),
    );
  }
}
