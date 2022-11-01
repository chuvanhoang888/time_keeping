// import 'package:app_cham_cong_option_2/constant.dart';
// import 'package:app_cham_cong_option_2/data/models/dts_feed/comments.dart';
// import 'package:app_cham_cong_option_2/data/view_models/comment_reply_view_model.dart';
// import 'package:app_cham_cong_option_2/screen/dts/components/animated_list_comment_reply.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CommentReply extends StatefulWidget {
//   final Comments comment;
//   const CommentReply({Key? key, required this.comment}) : super(key: key);

//   @override
//   State<CommentReply> createState() => _CommentReplyState();
// }

// class _CommentReplyState extends State<CommentReply> {
//   bool isClick = true;
//   @override
//   Widget build(BuildContext context) {
//     var commentReplyViewModel =
//         Provider.of<CommentReplyViewModel>(context, listen: true);
//     return widget.comment.commentReplyCount == 0
//         ? Container()
//         : Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _ui(commentReplyViewModel),
//               Visibility(
//                 visible: isClick,
//                 child: InkWell(
//                   onTap: () {
//                     commentReplyViewModel.getComments(
//                         context, widget.comment.commentId);
//                     isClick = false;
//                   },
//                   child: Text(
//                     "Xem " +
//                         widget.comment.commentReplyCount.toString() +
//                         " phản hồi",
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               )
//             ],
//           );
//   }

//   _ui(CommentReplyViewModel commentReplyViewModel) {
//     if (commentReplyViewModel.loading) {
//       return const Center(
//           child: CircularProgressIndicator(
//         color: kBackgroundComment,
//       ));
//     } else {
//       return ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: ((context, index) {
//             return AnimatedListCommentReply(
//                 comments: commentReplyViewModel.commentReplyListModel[index],
//                 index: index,
//                 key: ValueKey<int>(index));
//           }),
//           separatorBuilder: (context, index) => const SizedBox(
//                 height: 15,
//               ),
//           itemCount: commentReplyViewModel.commentReplyListModel.length);
//     }
//   }
// }
