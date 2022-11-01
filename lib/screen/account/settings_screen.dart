import 'package:app_cham_cong_option_2/components/appbar.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool sound = false;
  double currentvol = 0.5;
  @override
  void initState() {
    PerfectVolumeControl.hideUI =
        false; //set if system UI is hided or not on volume up/down
    Future.delayed(Duration.zero, () async {
      currentvol = await PerfectVolumeControl.getVolume();
      setState(() {
        //refresh UI
      });
    });

    PerfectVolumeControl.stream.listen((volume) {
      setState(() {
        currentvol = volume;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: const CustomAppbar(
        tittle: "Cài đặt chung",
        elevate: 0,
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        width: double.infinity,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ngôn ngữ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const Text("Tiếng việt"),
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/icons/Group 3665.svg",
                      width: 8,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Chuông & âm báo",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Spacer(),
                    SizedBox(
                        width: 50,
                        height: 30,
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: CupertinoSwitch(
                              trackColor: kSwitchColor,
                              activeColor: kBackgroundColor,
                              value: sound,
                              onChanged: (newValue) {
                                setState(() {
                                  sound = newValue;
                                  PerfectVolumeControl.setVolume(0.0);
                                });
                              },
                            )))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SliderTheme(
                  data: SliderThemeData(
                      // disabledThumbColor: Colors.black12,
                      // disabledActiveTrackColor: Colors.black12,
                      trackHeight: 2,
                      //overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                      overlayShape: SliderComponentShape.noThumb,
                      thumbColor: Colors.green,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 15, // kích cỡ nút trượt
                      )),
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.volume_mute_sharp,
                          size: 30,
                          color: kBorderColor,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          activeColor:
                              kBackgroundColor, // màu của thanh trượt khi đã active
                          inactiveColor: kSwitchColor.withOpacity(
                              0.3), // màu của thanh trượt khi chưa active
                          thumbColor: Colors.white, // màu của núm tròn

                          value: currentvol,
                          onChanged: sound
                              ? (newvol) {
                                  currentvol = newvol;
                                  PerfectVolumeControl.setVolume(
                                      newvol); //set new volume
                                  setState(() {});
                                }
                              : null,
                          min: 0, //
                          max: 1,
                          divisions:
                              100, // chia thành các nấc trượt lấy giá trị max / divisions
                        ),
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {},
                          icon: Icon(
                            sound ? Icons.volume_up : Icons.volume_off_sharp,
                            size: 30,
                            color: kBorderColor,
                          ))
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Giao diện",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Giao diện màn hình"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/Group 5388.png",
                    ),
                    const Text("Sáng",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Radio(
                        value: ThemeMode.light,
                        groupValue: themeProvider.themeMode,
                        onChanged: (ThemeMode? newValue) {
                          themeProvider.themeMode = newValue!;
                          // setState(() {
                          //   _value = newValue!;
                          //   final provider = Provider.of<ThemeProvider>(context,
                          //       listen: false);
                          //   provider.toggleTheme(themeProvider.isDarkMode);
                          // });
                        }),
                  ],
                ),
                Column(
                  children: [
                    Image.asset("assets/images/Group 5384.png"),
                    const Text(
                      "Tối",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Radio(
                        value: ThemeMode.dark,
                        groupValue: themeProvider.themeMode,
                        onChanged: (ThemeMode? newValue) {
                          themeProvider.themeMode = newValue!;
                          // setState(() {
                          //   _value = newValue!;
                          //   final provider = Provider.of<ThemeProvider>(context,
                          //       listen: false);
                          //   provider.toggleTheme(themeProvider.isDarkMode);
                          // });
                        }),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
