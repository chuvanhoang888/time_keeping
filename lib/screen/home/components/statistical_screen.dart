import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({Key? key}) : super(key: key);

  @override
  State<StatisticalScreen> createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen> {
  String selected = "all";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      color:
                          selected == "all" ? kBackgroundColor : Colors.white,
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
                      color:
                          selected == "out" ? kBackgroundColor : Colors.white,
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
                          color:
                              selected == "in" ? Colors.white : Colors.black)),
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
                        color:
                            selected == "infor" ? Colors.white : Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      offset: const Offset(0, 2),
                      color: kSwitchColor,
                      blurRadius: 5),
                ]),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    children: [
                      Text("Ngày công thực tế"),
                      const Spacer(),
                      Text("7.5 công")
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    children: [
                      Text("Ngày công thực tế"),
                      const Spacer(),
                      Text("7.5 công")
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    children: [
                      Text("Ngày công thực tế"),
                      const Spacer(),
                      Text("7.5 công")
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    children: [
                      Text("Ngày công thực tế"),
                      const Spacer(),
                      Text("7.5 công")
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    children: [
                      Text("Ngày công thực tế"),
                      const Spacer(),
                      Text("7.5 công")
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    children: [
                      Text("Ngày công thực tế"),
                      const Spacer(),
                      Text("7.5 công")
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    children: [
                      Text("Ngày công thực tế"),
                      const Spacer(),
                      Text("7.5 công")
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void changeProgress(String progress) {
    selected = progress;
    setState(() {});
  }
}
