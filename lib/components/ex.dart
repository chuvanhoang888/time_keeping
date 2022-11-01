// bottom sheet tự chế
// Container(
//               margin: EdgeInsets.only(top: size.height * 0.48),
//               padding: const EdgeInsets.only(
//                   top: 10, left: 30, right: 30, bottom: 50),
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30)),
//                   color: Colors.white,
//                   boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 5)]),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 85,
//                     height: 2,
//                     decoration: BoxDecoration(
//                         color: kUnderlinedColor,
//                         borderRadius: BorderRadius.circular(5)),
//                   ),
//                   ButtonFunction(
//                     title: "Thêm ảnh",
//                     icon: "assets/icons/Group 5340.svg",
//                     onPress: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => GalleryScreen())),
//                   ),
//                   ButtonFunction(
//                     title: "Gắn thẻ người khác",
//                     icon: "assets/icons/Group 5341.svg",
//                     onPress: () {},
//                   ),
//                   ButtonFunction(
//                     title: "Thêm địa điểm",
//                     icon: "assets/icons/Group 5342.svg",
//                     onPress: () {},
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Facebook",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                             width: 50,
//                             height: 30,
//                             child: FittedBox(
//                               fit: BoxFit.fill,
//                               child: CupertinoSwitch(
//                                   trackColor: kSwitchColor,
//                                   activeColor: kBackgroundColor,
//                                   value: val1,
//                                   onChanged: (newValue) {
//                                     onChangeSwitch(newValue);
//                                   }),
//                             ))
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Instagram",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                             width: 50,
//                             height: 30,
//                             child: FittedBox(
//                               fit: BoxFit.fill,
//                               child: CupertinoSwitch(
//                                   trackColor: kSwitchColor,
//                                   activeColor: kBackgroundColor,
//                                   value: val2,
//                                   onChanged: (newValue) {
//                                     onChangeSwitch2(newValue);
//                                   }),
//                             ))
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   DefaultButton(title: "Đăng bài", press: () {})
//                 ],
//               ),
//             )