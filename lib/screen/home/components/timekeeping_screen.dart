import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimekeepingScreen extends StatefulWidget {
  const TimekeepingScreen({Key? key}) : super(key: key);

  @override
  State<TimekeepingScreen> createState() => _TimekeepingScreenState();
}

class _TimekeepingScreenState extends State<TimekeepingScreen> {
  String selected = "all";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                changeProgress("all");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selected == "all" ? kBackgroundColor : Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 5,
                          color: kSwitchColor)
                    ]),
                child: SvgPicture.asset("assets/icons/date_range-24px.svg",
                    color: selected == "all" ? Colors.white : Colors.black),
              ),
            ),
            InkWell(
              onTap: () {
                changeProgress("out");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selected == "out" ? kBackgroundColor : Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 5,
                          color: kSwitchColor)
                    ]),
                child: Text("Ca ra",
                    style: TextStyle(
                        color:
                            selected == "out" ? Colors.white : Colors.black)),
              ),
            ),
            InkWell(
              onTap: () {
                changeProgress("in");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selected == "in" ? kBackgroundColor : Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 5,
                          color: kSwitchColor)
                    ]),
                child: Text("Ca vào",
                    style: TextStyle(
                        color: selected == "in" ? Colors.white : Colors.black)),
              ),
            ),
            InkWell(
              onTap: () {
                changeProgress("infor");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        selected == "infor" ? kBackgroundColor : Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 5,
                          color: kSwitchColor)
                    ]),
                child: Text(
                  "Thông tin",
                  style: TextStyle(
                      color: selected == "infor" ? Colors.white : Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 2), blurRadius: 5, color: kSwitchColor)
              ]),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: const BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: const Center(
                    child: Text("Thứ ba, ngày 08/09/2020",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white))),
              ),
              const CardHistory(
                name: "Thanh Lê",
                content: "Ca ra - Giờ hành chính",
                time: "17:40pm",
                timeRange: "08:30 am - 17:30pm",
              ),
            ],
          ),
        ),
      )
    ]);
  }

  void changeProgress(String progress) {
    selected = progress;
    setState(() {});
  }
}

class CardHistory extends StatelessWidget {
  final String name;
  final String time;
  final String content;
  final String timeRange;
  const CardHistory({
    Key? key,
    required this.name,
    required this.time,
    required this.content,
    required this.timeRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            //                   <--- left side
            color: kSwitchColor,
            width: 0.5,
          ),
        )),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const Spacer(),
                Text(time,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(content),
            Text(timeRange),
          ],
        ));
  }
}
