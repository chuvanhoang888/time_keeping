import 'dart:convert';
import 'dart:io';
import 'package:app_cham_cong_option_2/data/view_models/work_image_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_view_model.dart';
import 'package:app_cham_cong_option_2/photo_picker/album_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:filesize/filesize.dart';

class WorkPhoto extends StatefulWidget {
  final int idWork;
  const WorkPhoto({
    Key? key,
    required this.idWork,
  }) : super(key: key);

  @override
  State<WorkPhoto> createState() => _WorkPhotoState();
}

class _WorkPhotoState extends State<WorkPhoto> {
  String prosgress = "0";
  int indexImageDownload = 0;
  final Dio dio = Dio();
  bool loading = false;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

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
      "fileSize": null,
      "error": null
    };
    try {
      setState(() {
        loading = true;
      });
      var response = await dio.download(urlPath, savePath,
          onReceiveProgress: _onReceiveProgress);
      final fileSize = response.headers["content-length"]!.first;

      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
      result['fileSize'] = fileSize;
    } catch (e) {
      result['error'] = e.toString();
    } finally {
      _showNotification(result);
      setState(() {
        loading = false;
      });
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
        // visibility: NotificationVisibility.public,
        importance: Importance.max);
    const ios = IOSNotificationDetails();
    const notificationDetails = NotificationDetails(android: android, iOS: ios);
    final json = jsonEncode(downloadStatus);
    debugPrint(json);
    final isSuccess = downloadStatus['isSuccess'];
    final fileName = downloadStatus['filePath'].split('/').last;
    final fileSize = filesize(downloadStatus['fileSize']);
    await FlutterLocalNotificationsPlugin().show(
        0, // id nếu chung các thông báo sẽ ghi đè nhau
        isSuccess ? fileName : "error",
        isSuccess
            ? "Quá trình tải xuống hoàn tất: $fileSize"
            : "Lỗi khi tải xuống file",
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
      debugPrint("Permission Deined!");
    }
  }

  //////////////////////////////////////////////////////////////
  List<File> fileImageArray = [];
  Future<void> pickerImage() async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const AlbumImages(
                  maxSelection: 20,
                )));

    if (result != null) {
      setState(() {
        fileImageArray.addAll(result);
      });
    } else {
      //
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WorkImageViewModel>(context, listen: false)
          .getWorkImages(context, widget.idWork);
    });
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings('mipmap/ic_launcher');
    const ios = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const initSetting = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: _onselectedNotification);
  }

  @override
  Widget build(BuildContext context) {
    final workImageViewModel =
        Provider.of<WorkImageViewModel>(context, listen: true);
    final workViewModel = Provider.of<WorkViewModel>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/Path 1267.svg"),
              const SizedBox(
                width: 15,
              ),
              const Text(
                "CÁC TỆP ĐÍNH KÈM ẢNH",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              IconButton(
                  splashRadius: 25,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () async {
                    await workImageViewModel
                        .pickerImage(context)
                        .whenComplete(() {
                      workImageViewModel.createImageWork(
                          context,
                          workViewModel.selectedWork.id!,
                          workImageViewModel.fileImageArray);
                    });
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          _ui(workImageViewModel)
        ],
      ),
    );
  }

  _ui(WorkImageViewModel workImageViewModel) {
    if (workImageViewModel.loading) {
      return Container();
    } else {
      return previewImage(workImageViewModel);
    }
  }

  previewImage(WorkImageViewModel workImageViewModel) {
    if (workImageViewModel.fileImageArray.isEmpty &&
        workImageViewModel.workImageList.isEmpty) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
                width: 146,
                height: 146,
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset("assets/icons/Group 3657.png")),
            Container(
                width: 146,
                height: 146,
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset("assets/icons/Group 3657.png")),
            Container(
                width: 146,
                height: 146,
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset("assets/icons/Group 3657.png"))
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 146,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return SizedBox(
                      width: 146,
                      height: 146,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        clipBehavior: Clip.none,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      width: 146,
                                      height: 146,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(
                                              workImageViewModel
                                                  .fileImageArray[index]
                                                  .path!)),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  Container(
                                      width: 146,
                                      height: 146,
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.black.withOpacity(0.6))),
                                ],
                              ),
                              Image.file(
                                File(workImageViewModel
                                    .fileImageArray[index].path!),
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          workImageViewModel.fileImageArray[index].state == 0 ||
                                  workImageViewModel
                                          .fileImageArray[index].state ==
                                      1
                              ? Positioned(
                                  right: 3,
                                  bottom: 3,
                                  child: Container(
                                      width: 30,
                                      height: 30,
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Lottie.asset(
                                          'assets/icons/async.json',
                                          animate: workImageViewModel
                                                      .fileImageArray[index]
                                                      .state ==
                                                  1
                                              ? true
                                              : false)),
                                )
                              : Container()
                        ],
                      ),
                    );
                  }),
                  separatorBuilder: ((context, index) => const SizedBox(
                        width: 5,
                      )),
                  itemCount: workImageViewModel.fileImageArray.length),
              const SizedBox(
                width: 5,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return SizedBox(
                      width: 146,
                      height: 146,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        clipBehavior: Clip.none,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      width: 146,
                                      height: 146,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(workImageViewModel
                                              .workImageList[index].images!),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  Container(
                                      width: 146,
                                      height: 146,
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.black.withOpacity(0.6))),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    workImageViewModel
                                        .workImageList[index].images!,
                                    fit: BoxFit.cover,
                                  ),
                                  loading == false
                                      ? Container()
                                      : indexImageDownload == index
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                "Đang tải :" + prosgress,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          : Container(),
                                ],
                              ),
                            ],
                          ),
                          PopupMenuButton<int>(
                            color: Colors.white,
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            splashRadius: 25,
                            elevation: 0.1,
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context) {
                              return <PopupMenuEntry<int>>[
                                PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        indexImageDownload = index;
                                      });
                                      var fileName2 = workImageViewModel
                                          .workImageList[index].images!
                                          .split('/')
                                          .last;
                                      download(
                                          workImageViewModel
                                              .workImageList[index].images!,
                                          fileName2);
                                    },
                                    height: 20,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text("Tải về"),
                                      ],
                                    ),
                                    value: 0),
                                PopupMenuItem(
                                    onTap: () {
                                      workImageViewModel.deleteWorkImages(
                                          context,
                                          index,
                                          workImageViewModel
                                              .workImageList[index].id!);
                                    },
                                    height: 20,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text("Xóa"),
                                      ],
                                    ),
                                    value: 1),
                              ];
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                  separatorBuilder: ((context, index) => const SizedBox(
                        width: 5,
                      )),
                  itemCount: workImageViewModel.workImageList.length),
            ],
          ),
        ),
      );
    }
  }
}
