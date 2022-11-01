import 'dart:io';

import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<XFile>? _imageFileList;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    try {
      final List<XFile>? pickedFileList = await _picker.pickMultiImage();
      setState(() {
        _imageFileList = pickedFileList;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImages() {
    if (_imageFileList != null) {
      return Semantics(
          label: 'image_picker_example_picked_images',
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            itemCount: _imageFileList!.length > 3 ? 3 : _imageFileList!.length,
            itemBuilder: (context, index) {
              if (index > 1) {
                return Stack(
                  children: [
                    Image.file(
                      File(_imageFileList![index].path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5)),
                      child: Center(
                        child: Text(
                          "+ " + (_imageFileList!.length - 3).toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 23),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Image.file(
                  File(_imageFileList![index].path),
                  fit: BoxFit.cover,
                );
              }
            },
            staggeredTileBuilder: (int index) => _imageFileList!.length <= 2
                ? const StaggeredTile.count(3, 3)
                : StaggeredTile.count(index == 0 ? 2 : 1, index == 0 ? 2 : 1),
          ));
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _imageFileList = response.files;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title!"),
      ),
      body: Center(
          child: FutureBuilder<void>(
        future: retrieveLostData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Text(
                'You have not yet picked an image.',
                textAlign: TextAlign.center,
              );
            case ConnectionState.done:
              return _handlePreview();
            default:
              if (snapshot.hasError) {
                return Text(
                  'Pick image/video error: ${snapshot.error}}',
                  textAlign: TextAlign.center,
                );
              } else {
                return const Text(
                  'You have not yet picked an image.',
                  textAlign: TextAlign.center,
                );
              }
          }
        },
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(
                  ImageSource.gallery,
                  context: context,
                  isMultiImage: true,
                );
              },
              heroTag: 'image1',
              tooltip: 'Pick Multiple Image from gallery',
              child: const Icon(Icons.photo_library),
            ),
          ),
        ],
      ),
    );
  }
}
