import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/comments_reply.dart';
import 'package:flutter/material.dart';

class AnimatedListCommentReply extends StatefulWidget {
  final int index;
  const AnimatedListCommentReply({
    Key? key,
    required this.comments,
    required this.index,
  }) : super(key: key);

  final CommentsReply comments;

  @override
  State<AnimatedListCommentReply> createState() =>
      _AnimatedListCommentReplyState();
}

class _AnimatedListCommentReplyState extends State<AnimatedListCommentReply> {
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
              Container(
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
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Thích",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: kBorderColor),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Phản hồi",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kBorderColor),
                  )
                ],
              )
            ],
          ))
        ],
      )),
    );
  }
}
