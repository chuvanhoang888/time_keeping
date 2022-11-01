import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/dts_states.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostDetailScreen extends StatefulWidget {
  final int index;
  final int indexImage;
  final Posts post;
  const PostDetailScreen(
      {Key? key,
      required this.index,
      required this.post,
      required this.indexImage})
      : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final fifteenAgo = DateTime.now();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    //itemScrollController.jumpTo(index: 1, alignment: 0);
  }

  @override
  Widget build(BuildContext context) {
    //PostsViewModel postsViewModel = context.watch<PostsViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 5,
        elevation: 0,
        backgroundColor: Colors.transparent,
        //Phải có cái này mới dùng được SystemUiOverlayStyle
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: kStatusbarColor),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
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
                                )
                              : Image.network(
                                  widget.post.userModel.image.toString(),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      // ClipOval(

                      //   clipBehavior: Clip.none,
                      //   child: postsViewModel.selectedPost.userModel.image == null
                      //       ? Image.asset(
                      //           "assets/images/account_circle-24px@3x.png",
                      //           width: 50,
                      //           height: 50,
                      //         )
                      //       : Image.network(postsViewModel
                      //           .selectedPost.userModel.image
                      //           .toString()),
                      // ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.userModel.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (timeago
                                      .format(fifteenAgo, locale: 'vi')
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.post.content,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 0,
                ),
                DtsStates(
                  textColor: Colors.black,
                  post: widget.post,
                  index: widget.index,
                ),
              ],
            ),
          ),

          Container(
            color: kStatusbarColor.withOpacity(0.3),
            height: 7,
          ),
          //
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(color: Colors.white),
                child: Hero(
                  tag: "hero" + widget.index.toString() + index.toString(),
                  child: Image.network(
                    widget.post.imagesPost![index].urlPhoto,
                  ),
                ),
              );
            },
            itemCount: widget.post.imagesPost!.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
          ),
          // ScrollablePositionedList.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   // initialScrollIndex: widget.indexImage,
          //   itemCount: widget.post.imagesPost!.length,
          //   itemBuilder: (context, index) {
          //     return Column(mainAxisSize: MainAxisSize.min, children: [
          //       AspectRatio(
          //           aspectRatio: 1,
          //           child: Container(
          //             width: double.infinity,
          //             padding: const EdgeInsets.all(5),
          //             decoration: const BoxDecoration(color: Colors.white),
          //             child: Hero(
          //               tag:
          //                   "hero" + widget.index.toString() + index.toString(),
          //               child: Image.network(
          //                 widget.post.imagesPost![index].urlPhoto,
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //           ))
          //     ]);
          //   },
          //   itemScrollController: itemScrollController,
          //   itemPositionsListener: itemPositionsListener,
          // )

          //DtsAddComment(posts: posts)
        ]),
      )),
    );
  }
}
