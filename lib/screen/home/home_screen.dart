import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/home/notifications.dart';
import 'package:app_cham_cong_option_2/data/view_models/auth_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/notification_view_model.dart';
import 'package:app_cham_cong_option_2/screen/home/components/card_button.dart';
import 'package:app_cham_cong_option_2/screen/home/components/card_event.dart';
import 'package:app_cham_cong_option_2/screen/home/components/history_screen.dart';
import 'package:app_cham_cong_option_2/screen/home/components/permission_screen.dart';
import 'package:app_cham_cong_option_2/screen/home/pay_check_screen.dart';
import 'package:app_cham_cong_option_2/screen/home/preferential_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _editTextNameController = TextEditingController();
  final TextEditingController _editTextContentController =
      TextEditingController();

  final ScrollController _scrollController = ScrollController();
  bool isReadmore = false;
  int currentIndex = 0;
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final text = MediaQuery.of(context).platformBrightness == Brightness.dark
    //     ? 'DarkTheme'
    //     : 'LightTheme';
    AuthViewModel authViewModel = context.watch<AuthViewModel>();
    NotificationViewModel notificationViewModel =
        context.watch<NotificationViewModel>();
    return _ui(authViewModel, size, notificationViewModel);
  }

  _ui(AuthViewModel authViewModel, Size size,
      NotificationViewModel notificationViewModel) {
    if (authViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: kBackgroundColor,
        ),
      );
    } else {
      return Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            //Phải có cái này mới dùng được SystemUiOverlayStyle
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: kBackgroundColor),
          ),

          // bottomNavigationBar: BottomNavigationBar(
          //   elevation: 10.0,
          //   currentIndex: currentIndex,
          //   backgroundColor: Colors.white,
          //   selectedItemColor: kBackgroundColor,
          //   unselectedItemColor: kUnselectedColor,
          //   onTap: (index) => setState(() => currentIndex = index),
          //   type: BottomNavigationBarType.fixed,
          //   items: [
          //     BottomNavigationBarItem(
          //         backgroundColor: kBackgroundColor,
          //         icon: SvgPicture.asset(
          //           "assets/icons/home-24px.svg",
          //           color: currentIndex == 0 ? kBackgroundColor : kUnselectedColor,
          //         ),
          //         label: "Trang chủ"),
          //     BottomNavigationBarItem(
          //         icon: SvgPicture.asset(
          //           "assets/icons/text_snippet-24px.svg",
          //           color: currentIndex == 1 ? kBackgroundColor : kUnselectedColor,
          //         ),
          //         label: "Công việc"),
          //     BottomNavigationBarItem(
          //         icon: SvgPicture.asset(
          //           "assets/icons/mark_email_unread-24px.svg",
          //           color: currentIndex == 2 ? kBackgroundColor : kUnselectedColor,
          //         ),
          //         label: "DTS feed"),
          //     BottomNavigationBarItem(
          //         icon: SvgPicture.asset(
          //           "assets/icons/account_box-24px.svg",
          //           color: currentIndex == 3 ? kBackgroundColor : kUnselectedColor,
          //         ),
          //         label: "Cá nhân")
          //   ],
          // ),

          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: size.height / 6,
                      decoration: const BoxDecoration(color: kBackgroundColor),
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 20,
                              color: kShadowColor)
                        ]),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authViewModel.userModel.name,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              authViewModel.userModel.position!,
                              style: const TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                        const Spacer(),
                        authViewModel.userModel.image == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  "assets/images/doraemon.png",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fill,
                                ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network(
                                  authViewModel.userModel.image!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fill,
                                ))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  //height: size.height / 3,
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      childAspectRatio: .75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        CardButton(
                          icon: "assets/icons/restore-24px.svg",
                          title: "Lịch sử \nchấm công",
                          onPress: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HistoryScreen())),
                        ),
                        CardButton(
                          icon: "assets/icons/001-writing.svg",
                          title: "Quản lý \nphép",
                          onPress: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PermissionScreen())),
                        ),
                        CardButton(
                          icon: "assets/icons/002-gift.svg",
                          title: "Ưu đãi \ncá nhân",
                          onPress: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PreferentialScreen())),
                        ),
                        CardButton(
                          icon: "assets/icons/004-bill.svg",
                          title: "Phiếu lương",
                          onPress: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PayCheckScreen())),
                        ),
                        authViewModel.userModel.userRolePermission == 1
                            ? CardButton(
                                icon:
                                    "assets/icons/pending-bell-notification-icon.svg",
                                title: "Thêm thông báo",
                                onPress: () {
                                  showDialogAlert(
                                      context, notificationViewModel);
                                },
                              )
                            : Container(),
                      ])),
              Container(
                width: double.infinity,
                //decoration: BoxDecoration(color: Colors.white),
                margin: const EdgeInsets.symmetric(horizontal: 30),

                child: Column(
                  children: [_ui2(notificationViewModel)],
                ),
              )
            ],
          )));
    }
  }

  _ui2(NotificationViewModel notificationViewModel) {
    if (notificationViewModel.loading) {
      return Container();
    } else {
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            Notifications notifications =
                notificationViewModel.notificationListModel[index];
            return CardEvent(notification: notifications);
          }),
          separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
          itemCount: notificationViewModel.notificationListModel.length);
    }
  }

  showDialogAlert(
      BuildContext context, NotificationViewModel notificationViewModel) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.blueGrey.withOpacity(0.1),
        context: context,
        builder: (context) => Center(
            child: AlertDialog(
                insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                backgroundColor: Colors.transparent,
                content: Material(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 8,
                    child: Container(
                        width: MediaQuery.of(context).size.width - 30,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tên thông báo",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _editTextNameController,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: kBackgroundColor, width: 5.0),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Nội dung",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Scrollbar(
                                  controller: _scrollController,
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    controller: _editTextContentController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: kBackgroundColor, width: 5.0),
                                    )),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(50, 30)),
                                  child: const Text(
                                    "Hủy",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              const SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: kBackgroundColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(50, 30)),
                                  child: const Text(
                                    "Thêm",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    notificationViewModel
                                        .createNotification(
                                            context,
                                            _editTextNameController.text,
                                            _editTextContentController.text,
                                            DateFormat('hh:mm a')
                                                .format(time)
                                                .toLowerCase())
                                        .whenComplete(() {
                                      _editTextNameController.clear();
                                      _editTextContentController.clear();
                                      Navigator.pop(context);
                                    });
                                  })
                            ],
                          )
                        ]))))));
  }
}
