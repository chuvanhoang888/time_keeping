import 'dart:io';

import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/screen/account/account_post_view.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/card_video_play.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:app_cham_cong_option_2/components/custom_page_route.dart';
import 'package:app_cham_cong_option_2/data/models/components/images.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
import 'package:app_cham_cong_option_2/data/view_models/posts_view_model.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/dts_edit_post.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/dts_states.dart';
import 'package:timeago/timeago.dart' as timeago;

class DtsContainer extends StatefulWidget {
  final Posts post;
  final int index;
  const DtsContainer({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  @override
  State<DtsContainer> createState() => _DtsContainerState();
}

class _DtsContainerState extends State<DtsContainer>
    with TickerProviderStateMixin {
  int userId = 0;
  late AnimationController controller;
  final fifteenAgo = DateTime.now();
  List<File> imageFiles = [];

  @override
  void initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 400);
  }

  int getUrlType(String url) {
    Uri uri = Uri.parse(url);
    String typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
    if (typeString == "mp4") {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    PostsViewModel postsViewModel = context.watch<PostsViewModel>();
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        //debugPrint(widget.post.userModel.position);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountPostView(
                                    userModel: widget.post.userModel)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 0.2, color: kSwitchColor)),
                        padding: const EdgeInsets.all(0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: widget.post.userModel.image == null
                              ? Image.asset(
                                  "assets/images/doraemon.png",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                  gaplessPlayback: true,
                                )
                              : Image.network(
                                  widget.post.userModel.image.toString(),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                  gaplessPlayback: true,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: widget.post.userModel.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 17),
                              children: <TextSpan>[
                                widget.post.userTag.isNotEmpty
                                    ? const TextSpan(
                                        text: ' ― với ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17))
                                    : const TextSpan(),
                                widget.post.userTag.isNotEmpty
                                    ? TextSpan(
                                        text: widget.post.userTag[0].user!.name
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17))
                                    : const TextSpan(),
                                widget.post.userTag.isNotEmpty
                                    ? const TextSpan(
                                        text: ' và ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17))
                                    : const TextSpan(),
                                widget.post.userTag.length > 1
                                    ? TextSpan(
                                        text: (widget.post.userTag.length - 1)
                                                .toString() +
                                            ' người khác.',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17))
                                    : const TextSpan(),
                              ],
                            ),
                          ),
                          // Text(
                          //   widget.post.userModel.name,
                          //   style: const TextStyle(
                          //       fontSize: 18, fontWeight: FontWeight.bold),
                          // ),
                          widget.post.userTag.isNotEmpty
                              ? Container()
                              : const SizedBox(
                                  height: 10,
                                ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (timeago
                                    .format(
                                        DateTime.tryParse(
                                            widget.post.timeAgo.toString())!,
                                        locale: 'vi')
                                    .toString()),
                                style: const TextStyle(color: kBorderColor),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset(
                                "assets/icons/Group 3650.svg",
                                color: kSwitchColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // showCupertinoModalPopup(
                        //     context: context, builder: buildActionSheet);
                        _showMoreButton(context, postsViewModel);
                      },
                      child: SizedBox(
                          width: 30,
                          child: SvgPicture.asset(
                              "assets/icons/dot-menu-more-2-svgrepo-com.svg")),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.post.content,
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
          _previewImages(widget.post.imagesPost!, postsViewModel),
          DtsStates(
            textColor: Colors.black,
            index: widget.index,
            post: widget.post,
          ),
          //DtsAddComment(post: post)
        ],
      ),
    );
  }

  Widget _previewImages(
      List<Images> listImages, PostsViewModel postsViewModel) {
    if (listImages.isEmpty) {
      return Container();
    } else if (listImages.length == 1) {
      if (listImages[0].type == 1) {
        return CardVideoPlay(
            pathh: listImages[0].urlPhoto, key: const ValueKey<int>(0));
      } else {
        return SizedBox(
            height: 300,
            child: InkWell(
              onTap: () {
                // widget.post.view = widget.post.view! + 1;
                // setState(() {});
                // postsViewModel.editPostDts(context, widget.post, imageFiles);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => PostDetailScreen(
                              index: widget.index,
                              indexImage: 0,
                              post: widget.post,
                            ))));
              },
              child: Hero(
                tag: "hero" + widget.index.toString() + 0.toString(),
                child: Image.network(listImages[0].urlPhoto,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    gaplessPlayback: true),
              ),
            ));
      }
    } else if (listImages.length == 2) {
      return StaggeredGridView.countBuilder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemCount: listImages.length,
          itemBuilder: (context, index) {
            if (listImages[index].type == 1) {
              return InkWell(
                  onTap: () {
                    // widget.post.view = widget.post.view! + 1;

                    // setState(() {});
                    // postsViewModel.editPostDts(context, widget.post, imageFiles);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PostDetailScreen(
                                  index: widget.index,
                                  indexImage: index,
                                  post: widget.post,
                                ))));
                  },
                  child: Hero(
                      tag: "hero" + widget.index.toString() + index.toString(),
                      child: CardVideoPlay(
                          pathh: listImages[index].urlPhoto,
                          key: const ValueKey<int>(0))));
            } else {
              return InkWell(
                  onTap: () {
                    // widget.post.view = widget.post.view! + 1;

                    // setState(() {});
                    // postsViewModel.editPostDts(context, widget.post, imageFiles);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PostDetailScreen(
                                  index: widget.index,
                                  indexImage: index,
                                  post: widget.post,
                                ))));
                  },
                  child: Hero(
                    tag: "hero" + widget.index.toString() + index.toString(),
                    child: Image.network(listImages[index].urlPhoto,
                        fit: BoxFit.cover, gaplessPlayback: true),
                  ));
            }
          },
          staggeredTileBuilder: (int index) => const StaggeredTile.count(1, 1));
    } else if (listImages.length == 3) {
      return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        itemCount: 3,
        itemBuilder: (context, index) {
          if (index > 1) {
            if (listImages[index].type == 1) {
              return InkWell(
                  onTap: () {
                    // widget.post.view = widget.post.view! + 1;

                    // setState(() {});
                    // postsViewModel.editPostDts(context, widget.post, imageFiles);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PostDetailScreen(
                                  index: widget.index,
                                  indexImage: index,
                                  post: widget.post,
                                ))));
                  },
                  child: Hero(
                      tag: "hero" + widget.index.toString() + index.toString(),
                      child: CardVideoPlay(
                          pathh: listImages[index].urlPhoto,
                          key: const ValueKey<int>(0))));
            } else {
              return InkWell(
                onTap: () {
                  // widget.post.view = widget.post.view! + 1;
                  // setState(() {});
                  // postsViewModel.editPostDts(context, widget.post, imageFiles);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PostDetailScreen(
                                index: widget.index,
                                indexImage: index,
                                post: widget.post,
                              ))));
                },
                child: Stack(
                  children: [
                    Hero(
                      tag: "hero" + widget.index.toString() + index.toString(),
                      child: Image.network(listImages[index].urlPhoto,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          gaplessPlayback: true),
                    ),
                    widget.post.imagesPost!.length > 3
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3)),
                            child: Center(
                              child: Text(
                                "+ " + (listImages.length - 3).toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 23),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            }
          } else {
            if (listImages[index].type == 1) {
              return InkWell(
                  onTap: () {
                    // widget.post.view = widget.post.view! + 1;

                    // setState(() {});
                    // postsViewModel.editPostDts(context, widget.post, imageFiles);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PostDetailScreen(
                                  index: widget.index,
                                  indexImage: index,
                                  post: widget.post,
                                ))));
                  },
                  child: Hero(
                      tag: "hero" + widget.index.toString() + index.toString(),
                      child: CardVideoPlay(
                          pathh: listImages[index].urlPhoto,
                          key: const ValueKey<int>(0))));
            } else {
              return InkWell(
                onTap: () {
                  // widget.post.view = widget.post.view! + 1;

                  // setState(() {});
                  // postsViewModel.editPostDts(context, widget.post, imageFiles);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PostDetailScreen(
                                index: widget.index,
                                indexImage: index,
                                post: widget.post,
                              ))));
                },
                child: Hero(
                  tag: "hero" + widget.index.toString() + index.toString(),
                  child: Image.network(listImages[index].urlPhoto,
                      fit: BoxFit.cover, gaplessPlayback: true),
                ),
              );
            }
          }
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(index == 0 ? 2 : 1, index == 0 ? 2 : 1),
      );
    } else {
      return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        itemCount: 4,
        itemBuilder: (context, index) {
          if (index > 2) {
            if (listImages[index].type == 1) {
              return InkWell(
                  onTap: () {
                    // widget.post.view = widget.post.view! + 1;

                    // setState(() {});
                    // postsViewModel.editPostDts(context, widget.post, imageFiles);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PostDetailScreen(
                                  index: widget.index,
                                  indexImage: index,
                                  post: widget.post,
                                ))));
                  },
                  child: Hero(
                      tag: "hero" + widget.index.toString() + index.toString(),
                      child: CardVideoPlay(
                          pathh: listImages[index].urlPhoto,
                          key: const ValueKey<int>(0))));
            } else {
              return InkWell(
                onTap: () {
                  // widget.post.view = widget.post.view! + 1;
                  // setState(() {});
                  // postsViewModel.editPostDts(context, widget.post, imageFiles);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PostDetailScreen(
                                index: widget.index,
                                indexImage: index,
                                post: widget.post,
                              ))));
                },
                child: Stack(
                  children: [
                    Hero(
                      tag: "hero" + widget.index.toString() + index.toString(),
                      child: Image.network(listImages[index].urlPhoto,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          gaplessPlayback: true),
                    ),
                    widget.post.imagesPost!.length > 3
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3)),
                            child: Center(
                              child: Text(
                                "+ " + (listImages.length - 3).toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 23),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            }
          } else {
            if (listImages[index].type == 1) {
              return InkWell(
                  onTap: () {
                    // widget.post.view = widget.post.view! + 1;

                    // setState(() {});
                    // postsViewModel.editPostDts(context, widget.post, imageFiles);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PostDetailScreen(
                                  index: widget.index,
                                  indexImage: index,
                                  post: widget.post,
                                ))));
                  },
                  child: Hero(
                      tag: "hero" + widget.index.toString() + index.toString(),
                      child: CardVideoPlay(
                          pathh: listImages[index].urlPhoto,
                          key: const ValueKey<int>(0))));
            } else {
              return InkWell(
                onTap: () {
                  // widget.post.view = widget.post.view! + 1;

                  // setState(() {});
                  // postsViewModel.editPostDts(context, widget.post, imageFiles);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PostDetailScreen(
                                index: widget.index,
                                indexImage: index,
                                post: widget.post,
                              ))));
                },
                child: Hero(
                  tag: "hero" + widget.index.toString() + index.toString(),
                  child: Image.network(listImages[index].urlPhoto,
                      fit: BoxFit.cover, gaplessPlayback: true),
                ),
              );
            }
          }
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(index == 0 ? 2 : 1, index == 0 ? 3 : 1),
      );
    }
  }

  _showMoreButton(BuildContext context, PostsViewModel postsViewModel) {
    return showDialog(
      barrierColor: Colors.grey.withOpacity(0.1),
      context: context,
      builder: (conttext) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
                insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                backgroundColor: Colors.transparent,
                content: SizedBox(
                  width: MediaQuery.of(context).size.width - 25,
                  child: Column(children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    CustompageRoute(
                                        child: DtsEditPostScreen(
                                          post: widget.post,
                                          index: widget.index,
                                        ),
                                        direction: AxisDirection.left));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text("Chỉnh sửa"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          Material(
                            child: InkWell(
                              onTap: () {
                                if (widget.post.offComment == 0) {
                                  widget.post.offComment = 1;
                                  setState(() {});
                                } else {
                                  widget.post.offComment = 0;
                                  setState(() {});
                                }
                                Navigator.pop(context);
                                postsViewModel.editPostDts(
                                    context, widget.post, imageFiles);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: widget.post.offComment == 1
                                        ? const Text("Tắt tính năng bình luận")
                                        : const Text("Bật tính năng bình luận"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20))),
                                    transitionAnimationController: controller,
                                    context: context,
                                    builder: (BuildContext context) {
                                      //return BuildSheet(context: mainContext);
                                      return buildSheet();
                                    });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text("Xóa"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text("Hủy"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                )),
          ],
        ),
      ),
    );
  }

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
                "Xác nhận xóa bài viết",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  var postsViewModel =
                      Provider.of<PostsViewModel>(context, listen: false);
                  postsViewModel.deletePost(
                      context, widget.index, widget.post.idPost);

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
                        "Xóa bài viết",
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
                        "Thoát",
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

  // tắt tính năng bình luận
  Widget buildSheet2() => Container(
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
                "Xác nhận tắt bình luận bài viết",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  var postsViewModel =
                      Provider.of<PostsViewModel>(context, listen: false);
                  widget.post.offComment = 0;
                  postsViewModel.editPostDts(context, widget.post, imageFiles);
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
                        "Tắt bình luận",
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
                        "Thoát",
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
}
