import 'dart:io';
import 'package:album_image/album_image.dart';
import 'package:app_cham_cong_option_2/components/onTapScaleAndFade.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';

class AlbumImages extends StatefulWidget {
  final int maxSelection;
  const AlbumImages({Key? key, required this.maxSelection}) : super(key: key);

  @override
  State<AlbumImages> createState() => _AlbumImagesState();
}

class _AlbumImagesState extends State<AlbumImages> {
  int itemLenght = 0;
  List<File> fileImageArray = [];
  List<AssetEntity> assetA = [];
  Future<void> returnFile(List<AssetEntity> assetArray) async {
    for (var imageAsset in assetA) {
      File? tempFile = await imageAsset.file;
      if (tempFile!.existsSync()) {
        fileImageArray.add(tempFile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        final thumbnailQuality = MediaQuery.of(context).size.width ~/ 3;
        return AlbumImagePicker(
          onSelected: (items) async {
            setState(() {
              itemLenght = items.length;

              assetA = items;
            });
          },
          centerTitle: true,
          selectionBuilder: (_, selected, index) {
            // if (selected) {
            //   return CircleAvatar(
            //     backgroundColor: kBackgroundColor,
            //     child: Text(
            //       '${index + 1}',
            //       style: const TextStyle(
            //           fontSize: 13,
            //           height: 1.4,
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold),
            //     ),
            //     radius: 13,
            //   );
            // }
            // return Container();
            if (selected) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: kBackgroundColor, width: 3)),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: kBackgroundColor,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      radius: 13,
                    ),
                  )
                ],
              );
            }
            return Container();
          },
          crossAxisCount: 3,
          maxSelection: widget.maxSelection,
          onSelectedMax: () {
            print('Reach max');
          },
          albumBackGroundColor: Colors.white,
          selectedItemBackgroundColor: Colors.white.withOpacity(0.1),
          albumDividerColor: Colors.black,
          appBarHeight: 50,
          albumHeaderTextStyle:
              const TextStyle(color: Colors.black, fontSize: 18),
          itemBackgroundColor: Colors.grey[100]!,
          appBarColor: Colors.white,
          albumTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
          albumSubTextStyle: const TextStyle(color: Colors.grey, fontSize: 10),
          type: AlbumType.all,
          appBarActionWidgets: [
            itemLenght > 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OnTapScaleAndFade(
                        onTap: (() async {
                          await returnFile(assetA).whenComplete(() {
                            Navigator.of(context).pop(fileImageArray);
                          });
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: kBackgroundColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: const Center(
                            child: Text(
                              "Tiếp",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        )))
                : Container()
          ],
          closeWidget: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.clear_outlined,
                color: Colors.black,
              )),
          thumbnailQuality: thumbnailQuality * 3,
        );
      }),
    );
  }
}
