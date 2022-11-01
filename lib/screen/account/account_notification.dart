import 'package:app_cham_cong_option_2/components/appbar.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/screen/account/components/notification_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountNotification extends StatefulWidget {
  const AccountNotification({Key? key}) : super(key: key);

  @override
  State<AccountNotification> createState() => _AccountNotificationState();
}

class _AccountNotificationState extends State<AccountNotification> {
  bool valEmail = false;
  bool valPushNotifi = false;
  bool valMessage = false;
  bool valReminder = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppbar(
        tittle: "Thông báo",
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
              "Công việc",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Nhận phân công từ nội bộ công ty trong hệ thống"),
            const SizedBox(
              height: 20,
            ),
            NotificationSwitch(
              title: "Email",
              sButton: valEmail,
              details: "",
              onChanged: (newValue) {
                setState(() {
                  valEmail = newValue;
                });
              },
            ),
            NotificationSwitch(
              title: "Thông báo đẩy",
              sButton: valPushNotifi,
              details:
                  "Nhận tin nhắn trên thiết bị di động hoặc máy tính bảng của bạn.",
              onChanged: (newValue) {
                setState(() {
                  valPushNotifi = newValue;
                });
              },
            ),
            NotificationSwitch(
              title: "Tin nhắn văn bản",
              sButton: valMessage,
              details: "",
              onChanged: (newValue) {
                setState(() {
                  valMessage = newValue;
                });
              },
            ),
            NotificationSwitch(
              title: "Lời nhắc",
              sButton: valReminder,
              details:
                  "Nhận lời nhắc công việc, các thông báo, new feed, và nhắc nhở đến hạn hoàn thành công việc trong hệ thống",
              onChanged: (newValue) {
                setState(() {
                  valReminder = newValue;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
