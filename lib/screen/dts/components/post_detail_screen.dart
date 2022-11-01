import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/card_video_play.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/dts_states.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/sliding_animation.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/sliding_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

class _PostDetailScreenState extends State<PostDetailScreen>
    with SingleTickerProviderStateMixin {
  final fifteenAgo = DateTime.now();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  bool _visible = true;
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    //itemScrollController.jumpTo(index: 1, alignment: 0);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //PostsViewModel postsViewModel = context.watch<PostsViewModel>();

    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: SlidingAppBar(
            controller: _controller,
            visible: _visible,
            child: AppBar(
              titleSpacing: 0,
              // toolbarHeight: 5,
              elevation: 0,
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      width: 20,
                      child: SvgPicture.asset(
                        "assets/icons/more-vertical-svgrepo-com.svg",
                        color: Colors.white,
                      ),
                    ))
              ],
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.userModel.name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            timeago
                                .format(
                                    DateTime.tryParse(
                                        widget.post.timeAgo.toString())!,
                                    locale: 'vi')
                                .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          "assets/icons/Group 3650.svg",
                          color: kSwitchColor,
                        )
                      ],
                    )
                  ]),
              //Phải có cái này mới dùng được SystemUiOverlayStyle
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.transparent),
            )),
        body: Builder(builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                itemCount: widget.post.imagesPost!.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  if (widget.post.imagesPost![itemIndex].type == 1) {
                    return CardVideoPlay(
                        view: true,
                        pathh: widget.post.imagesPost![itemIndex].urlPhoto);
                  } else {
                    return Hero(
                        tag: "hero" +
                            widget.index.toString() +
                            itemIndex.toString(),
                        child: InkWell(
                          onTap: () => setState(() => _visible = !_visible),
                          child: Image.network(
                              widget.post.imagesPost![itemIndex].urlPhoto),
                        ));
                  }
                },
                options: CarouselOptions(
                  height: height,
                  // aspectRatio: 16 / 9,
                  // viewportFraction: 0.8,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  initialPage: 0,
                  //Không cho lặp lại
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  //autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,

                  //onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SlidingAnimation(
                  controller: _controller,
                  visible: _visible,
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                widget.post.content,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(height: 0, color: Colors.white),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: DtsStates(
                                textColor: Colors.white,
                                post: widget.post,
                                index: widget.index,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          );
        }));
  }
}
