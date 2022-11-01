// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cham_cong_option_2/data/models/dts_feed/like_comment.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/likes.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/build_modal_edit_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/comments.dart';
import 'package:app_cham_cong_option_2/data/view_models/comments_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/posts_view_model.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/animated_list_item.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/dts_button.dart';

class DtsStates extends StatefulWidget {
  final Posts post;
  final int index;
  final Color textColor;
  const DtsStates({
    Key? key,
    required this.post,
    required this.index,
    required this.textColor,
  }) : super(key: key);

  @override
  State<DtsStates> createState() => _DtsStatesState();
}

class _DtsStatesState extends State<DtsStates> with TickerProviderStateMixin {
  Color likeColor = Colors.red;
  //Color likeCOlor = const Color(0xFFF0F2F5);
  Color basicColor = kSwitchColor;
  late AnimationController controller;
  List<Comments> listComments = [];
  @override
  void initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 400);

    // var postsProvider = Provider.of<PostsViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var commentsProvider =
        Provider.of<CommentsViewModel>(context, listen: false);
    var postsViewModel = Provider.of<PostsViewModel>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        DTSButton(
            textColor: widget.textColor,
            // colorIcon: postsViewModel.isExist(
            //   widget.index,
            // )
            //     ? likeColor
            //     : basicColor,
            image: postsViewModel.isExist(
              widget.index,
            )
                ? "assets/icons/love2.png"
                : "assets/icons/love-basic.png",
            text:
                postsViewModel.postListModel[widget.index].likeCount.toString(),
            onPress: () async {
              postsViewModel.toggleFavourite(
                  widget.index,
                  Likes(
                      userId: widget.post.userModel.id,
                      postID: widget.post.idPost));
              postsViewModel.handlePostLikeAndDislike(
                  context, widget.post.idPost);
            }),
        DTSButton(
          textColor: widget.textColor,
          // colorIcon: basicColor,
          image: "assets/icons/Group 5385.png",
          text: postsViewModel.postListModel[widget.index].commentCount!
              .toString(),
          onPress: () async {
            commentsProvider.getComments(
                context, postsViewModel.postListModel[widget.index].idPost);
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                transitionAnimationController: controller,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  //return BuildSheet(context: mainContext);
                  return BuildModalBottomSheet(
                    indexPost: widget.index,
                    idPost: postsViewModel.postListModel[widget.index].idPost,
                  );
                });
          },
        ),
        DTSButton(
          textColor: widget.textColor,
          //colorIcon: basicColor,
          image: "assets/icons/Group 5386.png",
          text: postsViewModel.postListModel[widget.index].view.toString(),
          onPress: () {},
        ),
      ]),
    );
  }
}

class BuildModalBottomSheet extends StatefulWidget {
  final int indexPost, idPost;

  const BuildModalBottomSheet({
    Key? key,
    required this.idPost,
    required this.indexPost,
  }) : super(key: key);

  @override
  State<BuildModalBottomSheet> createState() => _BuildModalBottomSheetState();
}

class _BuildModalBottomSheetState extends State<BuildModalBottomSheet>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final _editTextController = TextEditingController();
  late FocusNode _focusNode;
  bool isButtonEnabled = false;
  late AnimationController controller2;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    controller2 = BottomSheet.createAnimationController(this);
    controller2.duration = const Duration(milliseconds: 400);
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 600);
  }

  bool isEmpty() {
    setState(() {
      if (_editTextController.text.isNotEmpty) {
        isButtonEnabled = true;
      } else {
        isButtonEnabled = false;
      }
    });
    return isButtonEnabled;
  }

  @override
  void dispose() {
    super.dispose();
    _editTextController.dispose();
    controller2.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var commentsProvider =
        Provider.of<CommentsViewModel>(context, listen: true);
    var postViewModel = Provider.of<PostsViewModel>(context, listen: true);
    return DraggableScrollableSheet(
        initialChildSize: 0.96,
        builder: ((context, scrollController) => StatefulBuilder(
            builder: (context, setState) => Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 5, right: 5),
                            child: _ui(commentsProvider, postViewModel,
                                widget.indexPost)),
                      ),
                      postViewModel
                                  .postListModel[widget.indexPost].offComment ==
                              1
                          ? const Divider(
                              height: 0,
                            )
                          : Container(),
                      postViewModel
                                  .postListModel[widget.indexPost].offComment ==
                              1
                          ? Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Đang phản hồi ',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text: 'Hoàng Văn',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15)),
                                            ],
                                          ),
                                        ),
                                        Material(
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            onTap: () {},
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Text("hủy"),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Scrollbar(
                                          controller: _scrollController,
                                          thumbVisibility: true,
                                          child: TextField(
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            autofocus: false,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            scrollController: _scrollController,
                                            focusNode: _focusNode,
                                            onChanged: (val) {
                                              isEmpty();
                                            },
                                            controller: _editTextController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10),
                                              filled: true,
                                              fillColor: kBackgroundComment,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide.none),
                                              hintStyle: const TextStyle(
                                                  color: kBorderColor,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 13),
                                              hintText: "Viết bình luận...",
                                            ),
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom >
                                                0
                                            ? isButtonEnabled
                                                ? SizedBox(
                                                    width: 30,
                                                    child: InkWell(
                                                        onTap: () {
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                          postViewModel
                                                              .updateStateCommentCount(
                                                                  widget
                                                                      .indexPost);
                                                          commentsProvider
                                                              .uploadComments(
                                                                  context,
                                                                  widget.idPost,
                                                                  _editTextController
                                                                      .text)
                                                              .whenComplete(() {
                                                            commentsProvider
                                                                .getComments(
                                                                    context,
                                                                    widget
                                                                        .idPost);
                                                          });

                                                          _editTextController
                                                              .clear();
                                                          isButtonEnabled =
                                                              false;
                                                        },
                                                        child: const Icon(
                                                          Icons.send_rounded,
                                                          color:
                                                              kBackgroundColor,
                                                          size: 35,
                                                        )),
                                                  )
                                                : SizedBox(
                                                    width: 30,
                                                    child: InkWell(
                                                        onTap: () {},
                                                        child: const Icon(
                                                          Icons.send_rounded,
                                                          size: 35,
                                                        )),
                                                  )
                                            : Container()
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ))));
  }

  _ui(CommentsViewModel commentsViewModel, PostsViewModel postViewModel,
      int indexPost) {
    if (commentsViewModel.loading) {
      return Container();
    } else {
      if (commentsViewModel.commentListModel.isNotEmpty) {
        return SingleChildScrollView(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: commentsViewModel.commentListModel.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedListItem(
                      onLongPress: () async {
                        await showModalBottomSheet(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            transitionAnimationController: controller2,
                            context: context,
                            builder: (BuildContext context) {
                              //return BuildSheet(context: mainContext);
                              return buildSheetEdit(
                                  commentsViewModel.commentListModel[index],
                                  index,
                                  commentsViewModel,
                                  postViewModel,
                                  indexPost);
                            });
                      },
                      onPressLike: () {
                        commentsViewModel.toggleLike(
                            index,
                            LikeComment(
                                userId: commentsViewModel
                                    .commentListModel[index].userId,
                                commentID: commentsViewModel
                                    .commentListModel[index].commentId));
                        commentsViewModel.handleCommentLikeAndDislike(
                            context,
                            commentsViewModel
                                .commentListModel[index].commentId);
                      },
                      onPressFeedback: () {
                        _focusNode.requestFocus();
                      },
                      comments: commentsViewModel.commentListModel[index],
                      index: index,
                      key: ValueKey<int>(index)),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
          ),
        );
      } else {
        return Container(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/comment.png",
                  width: 300,
                ),
                const Text("Chưa có bình luận nào",
                    style: TextStyle(color: kBorderColor, fontSize: 17)),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Hãy là người đầu tiên bình luận ",
                  style: TextStyle(color: kSwitchColor),
                )
              ],
            ));
      }
    }
  }

  Widget buildSheetEdit(
          Comments comment,
          int index,
          CommentsViewModel commentsViewModel,
          PostsViewModel postViewModel,
          int indexPost) =>
      Container(
        padding: const EdgeInsets.only(top: 15, bottom: 5),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Padding(
            //   padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            //   child: Text(
            //     "Bạn chưa hoàn tất bài viết để tải lên",
            //     style: TextStyle(fontSize: 17),
            //   ),
            // ),

            Material(
              child: InkWell(
                onTap: () async {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      transitionAnimationController: controller,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        //return BuildSheet(context: mainContext);
                        return BuildModalEditComment(
                            comment: comment, index: index);
                      });
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
                        "Chỉnh sửa bình luận ",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      transitionAnimationController: controller,
                      context: context,
                      builder: (BuildContext context) {
                        //return BuildSheet(context: mainContext);
                        return buildSheetDelete(comment, index,
                            commentsViewModel, postViewModel, indexPost);
                      });
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
                        "Xóa bình luận",
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
                  Navigator.of(context).pop(true);
                },
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: const [
                      Icon(Icons.clear_rounded, color: Colors.black),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Hủy",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  Widget buildSheetDelete(
          Comments comments,
          int index,
          CommentsViewModel commentsViewModel,
          PostsViewModel postsViewModel,
          int indexPost) =>
      Container(
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
                "Xác nhận xóa bình luận",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(context).pop(true);
                  postsViewModel.updateStateRemoveCommentCount(indexPost);
                  commentsViewModel.updateStateDelete(index);
                  commentsViewModel.deleteComment(context, comments.commentId);
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
                        "Xóa bình luận",
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
