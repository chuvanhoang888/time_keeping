// import 'package:flutter/material.dart';
// Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 37, vertical: 20),
//                 child: Column(
//                   children: [
//                     Container(
//                       child: TabBar(
//                         onTap: (value) {
//                           setState(() {
//                             current = value;
//                           });
//                         },
//                         isScrollable: false,
//                         indicatorWeight: 0,
//                         indicator: const UnderlineTabIndicator(
//                           borderSide: BorderSide(width: 0, color: Colors.white),
//                         ),

//                         //labelPadding: EdgeInsets.only(right: 10),

//                         indicatorPadding: EdgeInsets.zero,

//                         //labelColor: Colors.black,
//                         tabs: [
//                           Container(
//                             width: 90,
//                             height: 32,
//                             decoration: BoxDecoration(
//                                 color: current == 0
//                                     ? kBackgroundColor
//                                     : Colors.white,
//                                 border: current == 0
//                                     ? Border.all(
//                                         width: 0, color: kBackgroundColor)
//                                     : Border.all(
//                                         width: 1, color: kTextLightColor),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Center(
//                               child: Text(
//                                 "Nhận việc",
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: current == 0
//                                         ? FontWeight.bold
//                                         : FontWeight.w300,
//                                     color: current == 0
//                                         ? Colors.white
//                                         : kTextLightColor),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 90,
//                             height: 32,
//                             decoration: BoxDecoration(
//                                 color: current == 1
//                                     ? kBackgroundColor
//                                     : Colors.white,
//                                 border: current == 1
//                                     ? Border.all(
//                                         width: 0, color: kBackgroundColor)
//                                     : Border.all(
//                                         width: 1, color: kUnselectedColor),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Center(
//                               child: Text("Đang làm",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: current == 1
//                                           ? FontWeight.bold
//                                           : FontWeight.w300,
//                                       color: current == 1
//                                           ? Colors.white
//                                           : kTextLightColor)),
//                             ),
//                           ),
//                           Container(
//                             width: 90,
//                             height: 32,
//                             decoration: BoxDecoration(
//                                 color: current == 2
//                                     ? kBackgroundColor
//                                     : Colors.white,
//                                 border: current == 2
//                                     ? Border.all(
//                                         width: 0, color: kBackgroundColor)
//                                     : Border.all(
//                                         width: 1, color: kUnselectedColor),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Center(
//                               child: Text("Hoàn thành",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: current == 2
//                                           ? FontWeight.bold
//                                           : FontWeight.w300,
//                                       color: current == 2
//                                           ? Colors.white
//                                           : kTextLightColor)),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                         height: 200,
//                         child: TabBarView(
//                             children: [Container(), Container(), Container()]))
//                   ],
//                 ),
//               )



// PopupMenuButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                           //padding: EdgeInsets.all(10),
//                           elevation: 5,
//                           color: Colors.white,
//                           child: const Text(
//                             "Danh sách công việc...",
//                             style: TextStyle(
//                               color: kBorderColor,
//                               fontSize: 12,
//                             ),
//                           ),

//                           offset: const Offset(0, 20),
//                           itemBuilder: (context) {
//                             return [
//                               PopupMenuItem(
//                                 padding: EdgeInsets.zero,
//                                 child: SizedBox(
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.all(10),
//                                         height: 100,
//                                         child: Scrollbar(
//                                           controller: _scrollController,
//                                           isAlwaysShown: true,
//                                           child: TextField(
//                                             autocorrect: false,
//                                             enableSuggestions: false,
//                                             scrollController: _scrollController,
//                                             autofocus: false,
//                                             keyboardType:
//                                                 TextInputType.multiline,
//                                             maxLines: null,
//                                             onChanged: (s) => {},
//                                             decoration: const InputDecoration(
//                                               hintStyle:
//                                                   TextStyle(fontSize: 12),
//                                               hintText: "Nội dung bài viết...",
//                                               border: InputBorder.none,
//                                               isDense: true,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const Divider(
//                                         height: 0.5,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             TextButton(
//                                                 style: TextButton.styleFrom(
//                                                   padding: EdgeInsets.zero,
//                                                   minimumSize: Size(50, 30),
//                                                   backgroundColor:
//                                                       kBackgroundColor,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                   ),
//                                                 ),
//                                                 onPressed: () {},
//                                                 child: const Text(
//                                                   "Tạo",
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ))
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ];
//                           },
//                         ),