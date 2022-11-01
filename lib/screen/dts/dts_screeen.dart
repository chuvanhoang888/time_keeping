import 'package:app_cham_cong_option_2/components/custom_page_route.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
import 'package:app_cham_cong_option_2/data/view_models/posts_view_model.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/dts_container.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/dts_new_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DtsScreen extends StatefulWidget {
  const DtsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DtsScreen> createState() => _DtsScreenState();
}

class _DtsScreenState extends State<DtsScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<Posts> listPosts = [
    // Posts(
    //     idPost: "1",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto:
    //               "assets/images/beautiful-moraine-lake-banff-national-park-alberta-canada_131985-98.jpg"),
    //       Images(
    //           id: "2",
    //           urlPhoto:
    //               "assets/images/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg"),
    //       Images(id: "3", urlPhoto: "assets/images/flowers-276014__340.jpg"),
    //       Images(
    //           id: "4",
    //           urlPhoto:
    //               "assets/images/main_image_star-forming_region_carina_nircam_final-1280.jpg")
    //     ],
    //     userId: "userId1",
    //     userName: "Hoài Phương",
    //     userPhoto:
    //         "assets/images/304910118_1082402442383504_6662280609816903930_n.jpg",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 3,
    //     view: 10),
    // Posts(
    //     idPost: "2",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto:
    //               "assets/images/278378744_532385931594377_9064210653151207013_n.jpg"),
    //       Images(
    //           id: "2", urlPhoto: "assets/images/nature-image-for-website.jpg")
    //     ],
    //     userId: "userId1",
    //     userName: "Hồng Vân",
    //     userPhoto:
    //         "assets/images/278403356_533572378142399_9039076143984300508_n.jpg",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 3,
    //     view: 10),
    // Posts(
    //     idPost: "3",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto: "assets/images/e5b6d1ccf370c01a66dd3a26e39c159b.png")
    //     ],
    //     userId: "userId1",
    //     userName: "Thanh Lê",
    //     userPhoto: "assets/images/1ea476a704a8737745dc8cad1e5ace6c.png",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 4,
    //     view: 10),
    // Posts(
    //     idPost: "1",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto:
    //               "assets/images/beautiful-moraine-lake-banff-national-park-alberta-canada_131985-98.jpg"),
    //       Images(
    //           id: "2",
    //           urlPhoto:
    //               "assets/images/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg"),
    //       Images(id: "3", urlPhoto: "assets/images/flowers-276014__340.jpg"),
    //       Images(
    //           id: "4",
    //           urlPhoto:
    //               "assets/images/main_image_star-forming_region_carina_nircam_final-1280.jpg")
    //     ],
    //     userId: "userId1",
    //     userName: "Thanh Lê",
    //     userPhoto:
    //         "assets/images/304910118_1082402442383504_6662280609816903930_n.jpg",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 2,
    //     view: 10),
    // Posts(
    //     idPost: "2",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto: "assets/images/e5b6d1ccf370c01a66dd3a26e39c159b.png"),
    //       Images(
    //           id: "2", urlPhoto: "assets/images/nature-image-for-website.jpg")
    //     ],
    //     userId: "userId1",
    //     userName: "Thanh Lê",
    //     userPhoto:
    //         "assets/images/278403356_533572378142399_9039076143984300508_n.jpg",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 2,
    //     view: 10),
    // Posts(
    //     idPost: "3",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto: "assets/images/e5b6d1ccf370c01a66dd3a26e39c159b.png")
    //     ],
    //     userId: "userId1",
    //     userName: "Thanh Lê",
    //     userPhoto: "assets/images/1ea476a704a8737745dc8cad1e5ace6c.png",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 2,
    //     view: 10),
    // Posts(
    //     idPost: "1",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto:
    //               "assets/images/beautiful-moraine-lake-banff-national-park-alberta-canada_131985-98.jpg"),
    //       Images(
    //           id: "2",
    //           urlPhoto:
    //               "assets/images/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg"),
    //       Images(id: "3", urlPhoto: "assets/images/flowers-276014__340.jpg"),
    //       Images(
    //           id: "4",
    //           urlPhoto:
    //               "assets/images/main_image_star-forming_region_carina_nircam_final-1280.jpg")
    //     ],
    //     userId: "userId1",
    //     userName: "Thanh Lê",
    //     userPhoto:
    //         "assets/images/304910118_1082402442383504_6662280609816903930_n.jpg",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 2,
    //     view: 10),
    // Posts(
    //     idPost: "2",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto: "assets/images/e5b6d1ccf370c01a66dd3a26e39c159b.png"),
    //       Images(
    //           id: "2", urlPhoto: "assets/images/nature-image-for-website.jpg")
    //     ],
    //     userId: "userId1",
    //     userName: "Thanh Lê",
    //     userPhoto:
    //         "assets/images/278403356_533572378142399_9039076143984300508_n.jpg",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 2,
    //     view: 10),
    // Posts(
    //     idPost: "3",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto: "assets/images/e5b6d1ccf370c01a66dd3a26e39c159b.png")
    //     ],
    //     userId: "userId1",
    //     userName: "Thanh Lê",
    //     userPhoto: "assets/images/1ea476a704a8737745dc8cad1e5ace6c.png",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 1,
    //     view: 10),
    // Posts(
    //     idPost: "1",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto:
    //               "assets/images/beautiful-moraine-lake-banff-national-park-alberta-canada_131985-98.jpg"),
    //       Images(
    //           id: "2",
    //           urlPhoto:
    //               "assets/images/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg"),
    //       Images(id: "3", urlPhoto: "assets/images/flowers-276014__340.jpg"),
    //       Images(
    //           id: "4",
    //           urlPhoto:
    //               "assets/images/main_image_star-forming_region_carina_nircam_final-1280.jpg")
    //     ],
    //     userId: "userId1",
    //     userName: "Thanh Lê",
    //     userPhoto:
    //         "assets/images/304910118_1082402442383504_6662280609816903930_n.jpg",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 2,
    //     view: 10),
    // Posts(
    //     idPost: "2",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto: "assets/images/e5b6d1ccf370c01a66dd3a26e39c159b.png"),
    //       Images(
    //           id: "2", urlPhoto: "assets/images/nature-image-for-website.jpg")
    //     ],
    //     userId: "userId1",
    //     userName: "Thanh Lê",
    //     userPhoto:
    //         "assets/images/278403356_533572378142399_9039076143984300508_n.jpg",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 3,
    //     view: 10),
    // Posts(
    //     idPost: "3",
    //     content:
    //         "Bao bì thiết kế xịn vl nè m.n ưi!! Tham khảo để có thêm nhiều ý tưởng nè <3",
    //     imagesPost: [
    //       Images(
    //           id: "1",
    //           urlPhoto: "assets/images/e5b6d1ccf370c01a66dd3a26e39c159b.png")
    //     ],
    //     userId: "userId1",
    //     userName: "Thanh Lê",
    //     userPhoto: "assets/images/1ea476a704a8737745dc8cad1e5ace6c.png",
    //     timeAgo: "1969-07-20 20:18:04Z",
    //     likes: ["1", "2"],
    //     commentsAmount: 2,
    //     view: 10)
  ];

  List<Posts> postList = [];
  int userId = 0;
  bool loading = true;
  final controller = ScrollController();
  bool isFabVisible = false;
  final PanelController _panelController = PanelController();

  void togglePanel() {
    _panelController.isPanelOpen
        ? _panelController.close()
        : _panelController.open();
  }

  @override
  void initState() {
    super.initState();
    var postsViewModel = Provider.of<PostsViewModel>(context, listen: false);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        postsViewModel.getNewItemPost(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PostsViewModel postsViewModel = context.watch<PostsViewModel>();
    // Size size = MediaQuery.of(context).size;
    // BorderRadiusGeometry radius = const BorderRadius.only(
    //   topLeft: Radius.circular(24.0),
    //   topRight: Radius.circular(24.0),
    // );
    return Scaffold(
        backgroundColor: kSwitchColor.withOpacity(0.3),
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
            titleSpacing: 0,
            title: const Text(
              "DTS feed",
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
            // Your widgets here

            ),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () => Navigator.push(
              context,
              CustompageRoute(
                  child: const DtsNewPost(), direction: AxisDirection.left)),
          child: const Icon(Icons.add),
        ),
        // body: loading
        //     ? const Center(
        //         child: CircularProgressIndicator(color: kBackgroundColor),
        //       )
        //     : RefreshIndicator(
        //         key: _refreshIndicatorKey,
        //         triggerMode: RefreshIndicatorTriggerMode.onEdge,
        //         color: kBackgroundColor,
        //         backgroundColor: Colors.white,
        //         strokeWidth: 2.0,
        //         onRefresh: () {
        //           return retrievePosts();
        //         },
        //         child: SingleChildScrollView(
        //           child: ListView.separated(
        //             shrinkWrap: true,
        //             physics: const NeverScrollableScrollPhysics(),
        //             itemBuilder: (context, index) {
        //               return DtsContainer(posts: postList[index]);
        //             },
        //             itemCount: postList.length,
        //             separatorBuilder: (context, index) => const SizedBox(
        //               height: 10,
        //             ),
        //           ),
        //         ))
        body: _ui(postsViewModel));
  }

  _ui(PostsViewModel postsViewModel) {
    if (postsViewModel.loading) {
      return ListView.separated(
          itemBuilder: ((context, index) {
            return Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SkeltonCircle(width: 50, height: 50),
                              const SizedBox(
                                width: 10,
                              ),
                              const Skelton(width: 50, height: 20),
                              const Spacer(),
                              Row(
                                children: const [
                                  SkeltonCircle(width: 5, height: 5),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  SkeltonCircle(width: 5, height: 5),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  SkeltonCircle(width: 5, height: 5)
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Skelton(width: 150, height: 10),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    const Skelton(width: double.infinity, height: 200)
                  ],
                ));
          }),
          separatorBuilder: (context, index) => const SizedBox(
                height: 30,
              ),
          itemCount: 5);
    } else {
      return RefreshIndicator(
          key: _refreshIndicatorKey,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: kBackgroundColor,
          backgroundColor: Colors.white,
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1),
                () => postsViewModel.getPosts(context));
          },
          child: SingleChildScrollView(
            controller: controller,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index < postsViewModel.postListModel.length) {
                  Posts post = postsViewModel.postListModel[index];

                  // return InkWell(
                  //   onTap: () async {
                  //     postsViewModel.setPostSelected(post);
                  //   },
                  //   child: DtsContainer(
                  //     post: post,
                  //     index: index,
                  //   ),
                  // );
                  return DtsContainer(post: post, index: index);
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                        child: postsViewModel.hasMore
                            ? CircularProgressIndicator(
                                color: kBorderColor.withOpacity(0.2),
                              )
                            : const Text("Không có thêm dữ liệu để tải")),
                  );
                }
              },
              itemCount: postsViewModel.postListModel.length + 1,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          ));
    }
  }
}

class Skelton extends StatelessWidget {
  const Skelton({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16)),
    );
  }
}

class SkeltonCircle extends StatelessWidget {
  const SkeltonCircle({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04), shape: BoxShape.circle),
    );
  }
}
