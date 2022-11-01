import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/home/notifications.dart';
import 'package:flutter/material.dart';

class CardEvent extends StatefulWidget {
  final Notifications notification;
  const CardEvent({Key? key, required this.notification}) : super(key: key);

  @override
  State<CardEvent> createState() => _CardEventState();
}

class _CardEventState extends State<CardEvent> {
  bool isReadmore = false;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 5, color: kShadowColor)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.notification.name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(widget.notification.time!,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          _buildText(widget.notification.content!),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isReadmore = !isReadmore;
              });
            },
            child: Text(
              isReadmore == true ? "Rút gọn" : "Xem thêm",
              style: const TextStyle(color: kPrimaryColor, fontSize: 10),
            ),
          ),

          // Text(
          //   "Trưa nay mọi người họp bàn về vấn đề và đưa ra kế hoạch làm sao để công ty phát triển,….",
          //   style: TextStyle(fontSize: 12),
          // ),
          // const Text(
          //   "Xem thêm",
          //   style: TextStyle(fontSize: 10),
          // )
        ],
      ),
    );
  }

  Widget _buildText(String text) {
    final lines = isReadmore ? null : 2;
    return Text(
      text,
      style: const TextStyle(fontSize: 12),
      maxLines: lines,
      overflow: isReadmore ? TextOverflow.visible : TextOverflow.ellipsis,
    );
  }
}
