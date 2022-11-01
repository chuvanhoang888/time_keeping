// import 'package:app_cham_cong_option_2/constant.dart';
// import 'package:app_cham_cong_option_2/data/models/dts_feed/comments.dart';
// import 'package:app_cham_cong_option_2/data/models/dts_feed/post.dart';
// import 'package:app_cham_cong_option_2/data/service/local/local_service.dart';
// import 'package:app_cham_cong_option_2/screen/dts/components/animated_list_item.dart';
// import 'package:flutter/material.dart';

// class DtsAddComment extends StatefulWidget {
//   final Posts posts;
//   const DtsAddComment({
//     Key? key,
//     required this.posts,
//   }) : super(key: key);

//   @override
//   State<DtsAddComment> createState() => _DtsAddCommentState();
// }

// class _DtsAddCommentState extends State<DtsAddComment> {
//   final TextEditingController _addController = TextEditingController();
//   bool loadComment = false;
//   bool loadIndicator = false;
//   String? valueComment;
//   List<Comments> listComments = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           loadComment == false
//               ? Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           loadIndicator = true;
//                         });
//                         DBService().fetchComments().then((value) {
//                           listComments = value;
//                           setState(() {
//                             loadComment = true;
//                             loadIndicator = false;
//                           });
//                         });
//                       },
//                       child: Text(
//                         "Xem tất cả " +
//                             widget.posts.commentsAmount.toString() +
//                             " bình luận",
//                         style:
//                             const TextStyle(fontSize: 12, color: kBorderColor),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     loadIndicator == true
//                         ? const CircularProgressIndicator(
//                             color: kBackgroundComment,
//                             backgroundColor: Colors.transparent,
//                           )
//                         : Container()
//                   ],
//                 )
//               : Container(),
//           Visibility(
//             visible: loadComment,
//             child: ListView.separated(
//               shrinkWrap: true,
//               // reverse: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: listComments.length,
//               itemBuilder: (context, index) {
//                 return AnimatedListItem(
//                     comments: listComments[index],
//                     index: index,
//                     key: ValueKey<int>(index));
//               },
//               separatorBuilder: (context, index) => const SizedBox(
//                 height: 15,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             children: [
//               ClipOval(
//                   child: Image.asset(
//                 "assets/images/1ea476a704a8737745dc8cad1e5ace6c.png",
//                 width: 30,
//                 height: 30,
//               )),
//               const SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                   child: TextField(
//                 controller: _addController,
//                 onSubmitted: (value) async {
//                   if (value.isNotEmpty) {
//                     //valueComment = value;
//                     _addController.addListener(() {
//                       Comments com = Comments(
//                           commentId: "1",
//                           postId: "1",
//                           content: value,
//                           userId: "1",
//                           userPhoto:
//                               "assets/images/275553295_4800017800083917_3349616745445587766_n.jpg",
//                           userName: "Axie Infinity",
//                           //timeAgo: "1969-07-20 20:18:04Z",
//                           likes: ["1", "2"]);
//                       //widget.comments.add(com);

//                       setState(() {});
//                     });

//                     _addController.clear();
//                   } else {
//                     //
//                   }
//                   //await DBService().addComments(widget.lis)
//                 },
//                 decoration: const InputDecoration(
//                     hintStyle: TextStyle(
//                         color: kBorderColor,
//                         fontWeight: FontWeight.w300,
//                         fontSize: 13),
//                     hintText: "Thêm một bình luận...",
//                     border: InputBorder.none),
//               ))
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
