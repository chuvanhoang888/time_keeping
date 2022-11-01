import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardWork extends StatelessWidget {
  final String dateTime;
  final String title;
  final String date;
  final int status;
  const CardWork({
    Key? key,
    required this.dateTime,
    required this.title,
    required this.date,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(color: kShadowColor, blurRadius: 5)]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dateTime,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      width: 19,
                      height: 19,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == 2
                              ? kBackgroundColor
                              : status == 1
                                  ? Colors.greenAccent
                                  : kSwitchColor,
                          shape: BoxShape.circle),
                      child: SvgPicture.asset("assets/icons/Path 3.svg",
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 10, fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
