import 'dart:io';

import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/provider/images_new_dts_provide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DtsNewPostScreen extends StatefulWidget {
  const DtsNewPostScreen({Key? key}) : super(key: key);

  @override
  State<DtsNewPostScreen> createState() => _DtsNewPostScreenState();
}

class _DtsNewPostScreenState extends State<DtsNewPostScreen> {
  bool val1 = false;
  bool val2 = false;
  TextEditingController _editTextController = TextEditingController();

// Initialise a scroll controller.
  ScrollController _scrollController = ScrollController();
  List<String> listImages = [
    "assets/icons/Group 3657.png",
    "assets/icons/Group 3657.png",
    "assets/icons/Group 3657.png",
  ];
  List<XFile>? _imageFileList;
  dynamic _pickImageError;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  PanelController _panelController = PanelController();

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    try {
      final List<XFile>? pickedFileList = await _picker.pickMultiImage();
      setState(() {
        _imageFileList!.addAll(pickedFileList!);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _previewImagesWaiting() {
    if (listImages.isNotEmpty) {
      return Semantics(
          label: 'image_picker_example_picked_images',
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            itemCount: listImages.length,
            itemBuilder: (context, index) {
              return Image.asset(
                listImages[index],
                fit: BoxFit.cover,
              );
            },
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(index == 0 ? 2 : 1, index == 0 ? 2 : 1),
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

  Widget _previewImages(Size size) {
    //final imagesProviderDts = Provider.of<ImagesProviderDts>(context);
    if (_imageFileList != null) {
      if (_imageFileList!.length == 1) {
        return SizedBox(
            height: 250,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.file(File(_imageFileList![0].path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    gaplessPlayback: true),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Material(
                    color: kBackgroundComment.withOpacity(0.3),
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(
                        highlightColor: Colors.red,
                        padding: const EdgeInsets.all(5),
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.clear_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _imageFileList!.removeAt(0);
                        }),
                  ),
                )
              ],
            ));
      } else if (_imageFileList!.length == 2) {
        return StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            itemCount: _imageFileList!.length,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.file(File(_imageFileList![index].path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      gaplessPlayback: true),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Material(
                      color: kBackgroundComment.withOpacity(0.3),
                      shape: const CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      child: IconButton(
                          highlightColor: Colors.red,
                          padding: const EdgeInsets.all(5),
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.clear_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _imageFileList!.removeAt(index);
                          }),
                    ),
                  )
                ],
              );
            },
            staggeredTileBuilder: (int index) =>
                const StaggeredTile.count(1, 1));
      } else {
        return Semantics(
            label: 'image_picker_example_picked_images',
            child: Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.22),
              child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                itemCount: _imageFileList!.length,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(File(_imageFileList![index].path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          gaplessPlayback: true),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Material(
                          color: kBackgroundComment.withOpacity(0.3),
                          shape: const CircleBorder(),
                          clipBehavior: Clip.hardEdge,
                          child: IconButton(
                              highlightColor: Colors.red,
                              padding: const EdgeInsets.all(5),
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.clear_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _imageFileList!.removeAt(index);
                              }),
                        ),
                      )
                    ],
                  );
                },
                staggeredTileBuilder: (int index) => _imageFileList!.length <= 2
                    ? const StaggeredTile.count(1, 2)
                    : StaggeredTile.count(
                        index == 0 ? 2 : 1, index == 0 ? 2 : 1),
              ),
            ));
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return _handlePreviewWaiting();
    }
  }

  Widget _handlePreviewWaiting() {
    return _previewImagesWaiting();
  }

  Widget _handlePreview(Size size) {
    return _previewImages(size);
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

  onChangeSwitch(bool newValue1) {
    setState(() {
      val1 = newValue1;
    });
  }

  onChangeSwitch2(bool newValue1) {
    setState(() {
      val2 = newValue1;
    });
  }

  void togglePanel() {
    _panelController.isPanelOpen
        ? _panelController.close()
        : _panelController.open();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
        resizeToAvoidBottomInset:
            false, // Ngăn sliding up panel nhảy lên khi mở keyboard
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: const Text(
            "Bài viết mới",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: SlidingUpPanel(
          defaultPanelState: PanelState
              .OPEN, //Mở sẵn bảng điều khiển người dùng cần vuốt xuống để đóng
          controller: _panelController,
          //parallaxEnabled: true,  //đẩy phần body bên dưới lên
          minHeight: size.height * 0.1,

          maxHeight: size.height * 0.42,

          borderRadius: radius,
          panel: Container(
            padding:
                const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
            width: double.infinity,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    togglePanel();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: 85,
                    height: 5,
                    decoration: BoxDecoration(
                        color: kUnderlinedColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ButtonFunction(
                  title: "Thêm ảnh",
                  icon: "assets/icons/Group 5340.svg",
                  // onPress: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => GalleryScreen())),
                  onPress: () {
                    _onImageButtonPressed(
                      ImageSource.gallery,
                      context: context,
                      isMultiImage: true,
                    ).whenComplete(() {
                      final imagesProviderDts = Provider.of<ImagesProviderDts>(
                          context,
                          listen: false);
                      imagesProviderDts.add(_imageFileList);
                    });
                  },
                ),
                ButtonFunction(
                  title: "Gắn thẻ người khác",
                  icon: "assets/icons/Group 5341.svg",
                  onPress: () {},
                ),
                ButtonFunction(
                  title: "Thêm địa điểm",
                  icon: "assets/icons/Group 5342.svg",
                  onPress: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Facebook",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                          width: 50,
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: CupertinoSwitch(
                                trackColor: kSwitchColor,
                                activeColor: kBackgroundColor,
                                value: val1,
                                onChanged: (newValue) {
                                  onChangeSwitch(newValue);
                                }),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Instagram",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                          width: 50,
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: CupertinoSwitch(
                                trackColor: kSwitchColor,
                                activeColor: kBackgroundColor,
                                value: val2,
                                onChanged: (newValue) {
                                  onChangeSwitch2(newValue);
                                }),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DefaultButton(title: "Đăng bài", press: () {})
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: TextField(
                      autocorrect: false,
                      enableSuggestions: false,
                      scrollController: _scrollController,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (s) => {},
                      decoration: const InputDecoration(
                        hintText: "Nội dung bài viết...",
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: FutureBuilder<void>(
                  future: retrieveLostData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return _handlePreviewWaiting();
                      case ConnectionState.done:
                        return _handlePreview(size);
                      default:
                        if (snapshot.hasError) {
                          return Text(
                            'Pick image/video error: ${snapshot.error}}',
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return _handlePreviewWaiting();
                        }
                    }
                  },
                )),
              ],
            ),
          ),
        ));
  }
}

class ButtonFunction extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onPress;
  const ButtonFunction({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          ),
          InkWell(
            onTap: onPress,
            child: SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                  icon,
                  color: kBorderColor,
                )),
          )
        ],
      ),
    );
  }
}
