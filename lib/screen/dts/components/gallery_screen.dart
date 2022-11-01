import 'dart:collection';
import 'dart:typed_data';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Tất cả ảnh",
          style: TextStyle(
              fontWeight: FontWeight.normal, color: Colors.black, fontSize: 18),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: MediaGrid(),
    );
  }
}

class MediaGrid extends StatefulWidget {
  @override
  _MediaGridState createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  List<AssetEntity> _mediaList = [];
  AssetPathEntity? _album;
  // set an int with value -1 since no card has been selected

  int selectedCount = 0;
  int currentPage = 0;
  int lastPage = 0;
  List selectItems = [];
  bool isMultiSelectionEnabled = false;

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  //select multi image count
  void doMultiSelection(path) {
    if (isMultiSelectionEnabled) {
      if (selectItems.contains(path)) {
        selectItems.remove(path);
      } else {
        selectItems.add(path);

        selectedCount += 1;
        print(selectedCount);
      }
      setState(() {});
    } else {
      //
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      // success
      //load the album list
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      setState(() {
        _album = albums.first;
      });
      //final List<AssetEntity> media = await path.getAssetListPaged(page: 0, size: 80);
      final List<AssetEntity> media =
          await _album!.getAssetListPaged(page: currentPage, size: 60);

      setState(() {
        _mediaList.addAll(media);
        currentPage++;
      });

      //AssetEntity entity = _mediaList[0];

      //Uint8List? originBytes = await entity.originBytes; // image/video original file content,

      //Uint8List? thumbBytes = await entity.;
      // thumb data ,you can use Image.memory(thumbBytes); size is 64px*64px;

    }
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        return _handleScrollEvent(scroll) ?? false;
      },
      child: GridView.builder(
          itemCount: _mediaList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 2, mainAxisSpacing: 2, crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder(
              future: _mediaList[index]
                  .thumbnailDataWithSize(const ThumbnailSize(200, 200)),
              builder:
                  (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return InkWell(
                      onTap: () {
                        // ontap of each card, set the defined int to the grid view index
                        isMultiSelectionEnabled = true;
                        doMultiSelection(_mediaList[index]);
                        //print(snapshot.data);
                      },
                      child: Stack(children: [
                        Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Image.memory(
                                snapshot.data!,
                                fit: BoxFit.cover,
                                gaplessPlayback: true,
                              ),
                            ),
                            if (_mediaList[index].type == AssetType.video)
                              const Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.play_circle_outline_outlined,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                          ],
                        ),
                        Visibility(
                            visible: selectItems.contains(_mediaList[index]),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                child: Center(
                                  child: Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: const BoxDecoration(
                                          color: kBackgroundColor,
                                          shape: BoxShape.circle),
                                      child: Text(
                                        selectedCount.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )))
                      ]));
                }
                return Container(
                  decoration: const BoxDecoration(color: kSwitchColor),
                );
              },
            );
          }),
    );
  }
}
