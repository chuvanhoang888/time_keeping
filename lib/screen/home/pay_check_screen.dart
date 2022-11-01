import 'dart:convert';
import 'dart:io';

import 'package:app_cham_cong_option_2/components/appbar.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/components/json.dart';
import 'package:app_cham_cong_option_2/screen/home/pay_check_view_screen.dart';
import 'package:dio/dio.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class PayCheckScreen extends StatefulWidget {
  const PayCheckScreen({Key? key}) : super(key: key);

  @override
  State<PayCheckScreen> createState() => _PayCheckScreenState();
}

class _PayCheckScreenState extends State<PayCheckScreen> {
  List pdfList = [];

  String prosgress = "0";

  final Dio dio = Dio();
  bool loading = true;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // Future fetchAllPdf() async {
  //   final response = await dio.getUri();
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       pdfList = jsonDecode(response.data);
  //       loading = false;
  //     });
  //     print(pdfList);
  //   }
  // }

  //permission status
  Future<bool> requestPermission() async {
    final permission = await Permission.storage.request();
    if (permission != PermissionStatus.granted) {
      await [Permission.storage].request();
    }
    return permission == PermissionStatus.granted;
  }

  //download directory
  Future<Directory?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPath.downloadsDirectory();
    }
    return getApplicationDocumentsDirectory();
  }

  Future startDownload(String savePath, String urlPath) async {
    Map<String, dynamic> result = {
      "isSuccess": false,
      "filePath": null,
      "error": null
    };
    try {
      var response = await dio.download(urlPath, savePath,
          onReceiveProgress: _onReceiveProgress);
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (e) {
      result['error'] = e.toString();
    } finally {
      _showNotification(result);
    }
  }

  _onReceiveProgress(int receive, int total) {
    if (total != -1) {
      setState(() {
        prosgress = (receive / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future _showNotification(Map<String, dynamic> downloadStatus) async {
    const android = AndroidNotificationDetails("channelId", "channelName",
        channelDescription: "channelDescription",
        priority: Priority.high,
        importance: Importance.max);
    const ios = IOSNotificationDetails();
    const notificationDetails = NotificationDetails(android: android, iOS: ios);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];
    await FlutterLocalNotificationsPlugin().show(
        0,
        isSuccess ? "Success" : "error",
        isSuccess ? "File Download Successful" : "File Download Failed",
        notificationDetails,
        payload: json);
  }

  Future _onselectedNotification(String? json) async {
    final obj = jsonDecode(json!);
    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(obj['error']),
              ));
    }
  }

  Future download(String fileUrl, String fileName) async {
    final dir = await getDownloadDirectory();
    final permissionStatus = await requestPermission();
    if (permissionStatus) {
      final savePath = path.join(dir!.path, fileName);
      await startDownload(savePath, fileUrl);
    } else {
      print("Permission Deined!");
    }
  }

  @override
  void initState() {
    super.initState();
    //fetchAllPdf();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings('mipmap/ic_launcher');
    const ios = IOSInitializationSettings();
    const initSetting = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: _onselectedNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tittle: "Phiếu lương",
        elevate: 1,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return PayCheckCard(
                  title: lisPdf[index].name,
                  onPress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PayCheckViewScreen())),
                  onDownload: () {
                    download(lisPdf[index].pdf, lisPdf[index].name);
                  },
                );
              },
              itemCount: lisPdf.length,
            ),
          ),
          prosgress == "0"
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text("Download progress :" + prosgress),
                )
        ],
      ),
    );
  }
}

class PayCheckCard extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final VoidCallback onDownload;
  const PayCheckCard({
    Key? key,
    required this.title,
    required this.onPress,
    required this.onDownload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                      text: TextSpan(
                          text: title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: const [
                        TextSpan(
                            text: " (01/09/2020 - 30/09/2020) ",
                            style: TextStyle(fontWeight: FontWeight.normal))
                      ])),
                ),
                InkWell(
                  onTap: onDownload,
                  child: SvgPicture.asset(
                    "assets/icons/cloud_download-24px.svg",
                    color: kSwitchColor,
                    width: 30,
                  ),
                )
              ],
            ),
            //
          ),
          const Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}
