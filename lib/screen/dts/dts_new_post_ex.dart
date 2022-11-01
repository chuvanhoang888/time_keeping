import 'dart:io';

import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/gallery_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
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

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

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
                ? const StaggeredTile.count(2, 3)
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
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
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Scrollbar(
                      controller: _scrollController,
                      isAlwaysShown: true,
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
                  StaggeredGridView.countBuilder(
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
                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        index == 0 ? 2 : 1, index == 0 ? 2 : 1),
                  )
                ],
              ),
            ),
            SlidingUpPanel(
                minHeight: size.height * 0.42,
                borderRadius: radius,
                panel: Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 30, right: 30, bottom: 50),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        width: 85,
                        height: 3,
                        decoration: BoxDecoration(
                            color: kUnderlinedColor,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      ButtonFunction(
                        title: "Thêm ảnh",
                        icon: "assets/icons/Group 5340.svg",
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GalleryScreen())),
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
                ))
          ],
        ),
      ),
    );
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
