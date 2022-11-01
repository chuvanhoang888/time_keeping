// import 'package:app_cham_cong_option_2/constant.dart';
// import 'package:app_cham_cong_option_2/screen/account/account_screen.dart';
// import 'package:app_cham_cong_option_2/screen/checkin/check_in_screen.dart';
// import 'package:app_cham_cong_option_2/screen/dts/components/dts_container.dart';
// import 'package:app_cham_cong_option_2/screen/dts/dts_screeen.dart';
// import 'package:app_cham_cong_option_2/screen/home/home_screen.dart';
// import 'package:app_cham_cong_option_2/screen/work/work_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int currentTab = 0;
//   final List<Widget> screens = [
//     const HomeScreen(),
//     const WorkScreen(),
//     const DtsScreen(),
//     const AccountScreen()
//   ];
//   final PageStorageBucket bucket = PageStorageBucket();
//   Widget currentScreen = const HomeScreen();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageStorage(
//         bucket: bucket,
//         child: currentScreen,
//       ),
//       floatingActionButton: Container(
//           decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 width: 2,
//                 color: Colors.white,
//               )),
//           width: 65,
//           height: 65,
//           child: FittedBox(
//             child: Visibility(
//               visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
//               child: FloatingActionButton(
//                 heroTag: null,
//                 elevation: 0,
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const CheckInScreen()));
//                 },
//                 child: SvgPicture.asset("assets/icons/security-pin.svg"),
//               ),
//             ),
//           )),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         notchMargin: 10,
//         child: SizedBox(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   MaterialButton(
//                     onPressed: () {
//                       setState(() {
//                         currentScreen = const HomeScreen();
//                         currentTab = 0;
//                       });
//                     },
//                     minWidth: 40,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           "assets/icons/home-24px.svg",
//                           color: currentTab == 0
//                               ? kBackgroundColor
//                               : kUnselectedColor,
//                         ),
//                         Text("Trang chủ",
//                             style: TextStyle(
//                                 fontSize: 10,
//                                 color: currentTab == 0
//                                     ? kBackgroundColor
//                                     : kUnselectedColor))
//                       ],
//                     ),
//                   ),
//                   MaterialButton(
//                     onPressed: () {
//                       setState(() {
//                         currentScreen = const WorkScreen();
//                         currentTab = 1;
//                       });
//                     },
//                     minWidth: 40,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset("assets/icons/text_snippet-24px.svg",
//                             color: currentTab == 1
//                                 ? kBackgroundColor
//                                 : kUnselectedColor),
//                         Text("Công việc",
//                             style: TextStyle(
//                                 fontSize: 10,
//                                 color: currentTab == 1
//                                     ? kBackgroundColor
//                                     : kUnselectedColor))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   MaterialButton(
//                     onPressed: () {
//                       setState(() {
//                         currentScreen = const DtsScreen();
//                         currentTab = 2;
//                       });
//                     },
//                     minWidth: 50,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                             "assets/icons/mark_email_unread-24px.svg",
//                             color: currentTab == 2
//                                 ? kBackgroundColor
//                                 : kUnselectedColor),
//                         Text("DTS feed",
//                             style: TextStyle(
//                                 fontSize: 10,
//                                 color: currentTab == 2
//                                     ? kBackgroundColor
//                                     : kUnselectedColor))
//                       ],
//                     ),
//                   ),
//                   MaterialButton(
//                     onPressed: () {
//                       setState(() {
//                         currentScreen = const AccountScreen();
//                         currentTab = 3;
//                       });
//                     },
//                     minWidth: 40,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset("assets/icons/account_box-24px.svg",
//                             color: currentTab == 3
//                                 ? kBackgroundColor
//                                 : kUnselectedColor),
//                         Text(
//                           "Cá nhân",
//                           style: TextStyle(
//                               fontSize: 10,
//                               color: currentTab == 3
//                                   ? kBackgroundColor
//                                   : kUnselectedColor),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
