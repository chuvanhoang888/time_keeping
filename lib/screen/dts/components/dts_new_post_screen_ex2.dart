import 'dart:async';
import 'dart:io';

import 'package:app_cham_cong_option_2/components/custom_page_route.dart';
import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/view_models/auth_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/posts_view_model.dart';
import 'package:app_cham_cong_option_2/photo_picker/album_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DtsNewPost extends StatefulWidget {
  const DtsNewPost({Key? key}) : super(key: key);

  @override
  State<DtsNewPost> createState() => _DtsNewPostState();
}

class _DtsNewPostState extends State<DtsNewPost> with TickerProviderStateMixin {
  Timer? _timer;
  bool val1 = false;
  bool val2 = false;
  DateTime nowTime = DateTime.now();
  final TextEditingController _editTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final PanelController _panelController = PanelController();
  late AnimationController controller;
  List<String> imageUploadSuccess = [];
  List<String> imageWaitings = [
    "assets/icons/Group 3657.png",
    "assets/icons/Group 3657.png",
    "assets/icons/Group 3657.png",
  ];
  List<File> fileImageArray = [];
  Future<void> goToSecondScreen() async {
    var result = await Navigator.push(
        context,
        CustompageRoute(
            child: const AlbumImages(
              maxSelection: 20,
            ),
            direction: AxisDirection.up));
    if (result != null) {
      setState(() {
        fileImageArray.addAll(result);
      });
    } else {
      //
    }
  }

  Widget _previewImagesWaiting() {
    return Semantics(
        label: 'image_picker_example_picked_images',
        child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          itemCount: imageWaitings.length,
          itemBuilder: (context, index) {
            return Image.asset(
              imageWaitings[index],
              fit: BoxFit.cover,
            );
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(index == 0 ? 2 : 1, index == 0 ? 2 : 1),
        ));
  }

  Widget _previewImages(Size size) {
    //final imagesProviderDts = Provider.of<ImagesProviderDts>(context);
    if (fileImageArray.length == 1) {
      return SizedBox(
          height: 250,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Image.file(File(fileImageArray[0].path),
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
                        fileImageArray.removeAt(0);
                        setState(() {});
                      }),
                ),
              )
            ],
          ));
    } else if (fileImageArray.length == 2) {
      return StaggeredGridView.countBuilder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemCount: fileImageArray.length,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Image.file(File(fileImageArray[index].path),
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
                          fileImageArray.removeAt(index);
                          setState(() {});
                        }),
                  ),
                )
              ],
            );
          },
          staggeredTileBuilder: (int index) => const StaggeredTile.count(1, 1));
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
              itemCount: fileImageArray.length,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(File(fileImageArray[index].path),
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
                              fileImageArray.removeAt(index);
                              setState(() {});
                            }),
                      ),
                    )
                  ],
                );
              },
              staggeredTileBuilder: (int index) => fileImageArray.length <= 2
                  ? const StaggeredTile.count(1, 2)
                  : StaggeredTile.count(index == 0 ? 2 : 1, index == 0 ? 2 : 1),
            ),
          ));
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

  // Future<void> _uploadMultiImage(List<File> _imageArray) async {
  //   ApiResponse response =
  //       await PostsService().uploadMultiImagePost(_imageArray);

  //   if (response.error == null) {
  //     //_saveAndRedirectToHome(response.data as UserModel);
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         duration: const Duration(seconds: 3),
  //         behavior: SnackBarBehavior.floating,
  //         backgroundColor: Colors.transparent,
  //         elevation: 0,
  //         content: CustomSnackBarError(
  //           error: response.data.toString(),
  //         )));
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         duration: const Duration(seconds: 5),
  //         behavior: SnackBarBehavior.floating,
  //         backgroundColor: Colors.transparent,
  //         elevation: 0,
  //         content: CustomSnackBarError(
  //           error: response.error!,
  //         )));
  //   }
  // }

  Widget buildSheet() => Container(
        padding: const EdgeInsets.only(top: 15, bottom: 5),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                "Bạn chưa hoàn tất bài viết để tải lên",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/delete-10399.svg",
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Bỏ bài viết",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: const [
                      Icon(Icons.check, color: Colors.blueAccent),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Tiếp tục chỉnh sửa",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Future<bool> _onWillPop() async {
    if (_editTextController.text.isNotEmpty || fileImageArray.isNotEmpty) {
      return (await showModalBottomSheet(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              transitionAnimationController: controller,
              context: context,
              builder: (BuildContext context) {
                //return BuildSheet(context: mainContext);
                return buildSheet();
              })) ??
          false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 400);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    AuthViewModel authViewModel = context.watch<AuthViewModel>();
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            resizeToAvoidBottomInset:
                false, // Ngăn sliding up panel nhảy lên khi mở keyboard
            backgroundColor: Colors.white,
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.transparent),
              elevation: 0.5,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: InkWell(
                onTap: () =>
                    Navigator.of(context, rootNavigator: true).maybePop(),
                child: const Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
              title: const Text(
                "Bài viết mới",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              centerTitle: true,
            ),
            body: _ui(authViewModel, size, radius)));
  }

  _ui(AuthViewModel authViewModel, Size size, BorderRadiusGeometry radius) {
    if (authViewModel.loading) {
      return Container();
    } else {
      return SlidingUpPanel(
        backdropEnabled: true,
        backdropColor: Colors.transparent,
        backdropOpacity: 0,
        backdropTapClosesPanel: true,
        defaultPanelState: PanelState
            .OPEN, //Mở sẵn bảng điều khiển người dùng cần vuốt xuống để đóng
        controller: _panelController,
        //parallaxEnabled: true,  //đẩy phần body bên dưới lên
        minHeight: size.height * 0.04,

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
                  goToSecondScreen();
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
              DefaultButton(
                  title: "Đăng bài",
                  press: () async {
                    if (_editTextController.text.isNotEmpty) {
                      _timer?.cancel();
                      await EasyLoading.show(
                        status: 'Loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      // await _createPostDts().whenComplete(() {
                      //   EasyLoading.dismiss();
                      // });

                      var postsViewModel =
                          Provider.of<PostsViewModel>(context, listen: false);
                      // postsViewModel
                      //     .createPostDts(context, _editTextController.text,
                      //         nowTime.toString(), fileImageArray)
                      //     .whenComplete(() {
                      //   EasyLoading.dismiss();
                      // });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 5),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: CustomSnackBarError(
                            error: "Vui lòng nhập nội dung",
                          )));
                    }

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => const HomePage(
                    //               currentTab: 2,
                    //             ))));
                  })
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 0.2, color: kSwitchColor)),
                          padding: const EdgeInsets.all(0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: authViewModel.userModel.image == null
                                ? Image.asset(
                                    "assets/images/doraemon.png",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                    gaplessPlayback: true,
                                  )
                                : Image.network(
                                    authViewModel.userModel.image.toString(),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                    gaplessPlayback: true,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authViewModel.userModel.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: TextField(
                        controller: _editTextController,
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
                  ],
                ),
              ),
              fileImageArray.isEmpty
                  ? _previewImagesWaiting()
                  : _previewImages(size)
            ],
          ),
        ),
      );
    }
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
