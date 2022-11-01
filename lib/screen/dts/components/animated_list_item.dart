// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cham_cong_option_2/data/view_models/comments_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:provider/provider.dart';
import '../../../data/models/dts_feed/comments.dart';

class AnimatedListItem extends StatefulWidget {
  final int index;
  const AnimatedListItem({
    Key? key,
    required this.index,
    required this.comments,
    required this.onPressLike,
    required this.onPressFeedback,
    required this.onLongPress,
  }) : super(key: key);

  final Comments comments;
  final VoidCallback onPressLike;
  final VoidCallback onPressFeedback;
  final VoidCallback onLongPress;

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;
  //static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      setState(() {
        _animate = true;
        //_isStart = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var commentViewModel =
        Provider.of<CommentsViewModel>(context, listen: false);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: SizedBox(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.comments.userModel.image == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/doraemon.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  ))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.comments.userModel.image!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onLongPress: widget.onLongPress,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kBackgroundComment),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.comments.userModel.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(widget.comments.content)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(3),
                      onTap: widget.onPressLike,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: Text(
                          "Thích",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: kBorderColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  // InkWell(
                  //   onTap: widget.onPressFeedback,
                  //   child: const Text(
                  //     "Phản hồi",
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold, color: kBorderColor),
                  //   ),
                  // )
                  commentViewModel.commentListModel[widget.index].likesCount! >
                          0
                      ? Row(
                          children: [
                            Text(commentViewModel
                                .commentListModel[widget.index].likesCount
                                .toString()),
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/icons/love2.png",
                              width: 25,
                            )
                          ],
                        )
                      : Container()
                ],
              ),

              //CommentReply(comment: widget.comments)
            ],
          ))
        ],
      )),
    );
  }
}
