// import 'package:app_cham_cong_option_2/constant.dart';
// import 'package:app_cham_cong_option_2/data/models/components/work_request.dart';
// import 'package:app_cham_cong_option_2/screen/work/work_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_portal/flutter_portal.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class WorkLinkButton extends StatefulWidget {
//   const WorkLinkButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<WorkLinkButton> createState() => _WorkLinkButtonState();
// }

// class _WorkLinkButtonState extends State<WorkLinkButton> {
//   bool isMenuOpen = false;
//   String? linkProject;
//   @override
//   void initState() {
//     super.initState();

//     //WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => showOverlay());
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     //scrollController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final workLinkProvider = Provider.of<WorkLinkProvider>(context);
//     return Row(
//       children: [
//         SvgPicture.asset("assets/icons/external-link.svg"),
//         const SizedBox(
//           width: 15,
//         ),
//         Expanded(
//           child: InkWell(
//             onTap: () {
//               showDialog(
//                   barrierColor: Colors.blueGrey.withOpacity(0.1),
//                   context: context,
//                   builder: (conttext) => Center(
//                       child: AlertDialog(
//                           insetPadding: EdgeInsets.zero,
//                           contentPadding: EdgeInsets.zero,
//                           shape: const RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20.0))),
//                           backgroundColor: Colors.transparent,
//                           content: Material(
//                             borderRadius: BorderRadius.circular(15),
//                             // elevation: 8,
//                             child: Container(
//                                 width: MediaQuery.of(context).size.width - 30,
//                                 height: 155,
//                                 //padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                     color: Colors.white),
//                                 child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(20)),
//                                           padding: const EdgeInsets.all(10),
//                                           height: 100,
//                                           child: TextField(
//                                             autocorrect: false,
//                                             enableSuggestions: false,
//                                             autofocus: false,
//                                             keyboardType:
//                                                 TextInputType.multiline,
//                                             maxLines: null,
//                                             onChanged: (s) {
//                                               linkProject = s;
//                                             },
//                                             style: const TextStyle(
//                                                 decoration:
//                                                     TextDecoration.none),
//                                             decoration: const InputDecoration(
//                                               hintStyle:
//                                                   TextStyle(fontSize: 12),
//                                               hintText: "Nội dung bài viết...",
//                                               border: InputBorder.none,
//                                               isDense: true,
//                                             ),
//                                           )),
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
//                                                   minimumSize:
//                                                       const Size(50, 30),
//                                                   backgroundColor:
//                                                       kBackgroundColor,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                   ),
//                                                 ),
//                                                 onPressed: () {
//                                                   workLinkProvider.linkProject =
//                                                       linkProject!;
//                                                   setState(() {});
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: const Text(
//                                                   "Tạo",
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ))
//                                           ],
//                                         ),
//                                       )
//                                     ])),
//                           ))));
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: workLinkProvider.linkProject.isNotEmpty
//                   ? Text(workLinkProvider.linkProject)
//                   : const Text("Thêm tập tin đính kèm...",
//                       style: TextStyle(color: kBorderColor, fontSize: 12)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
