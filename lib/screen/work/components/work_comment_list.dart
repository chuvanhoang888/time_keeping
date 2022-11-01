import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/work/work_comment.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_comment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkCommentList extends StatefulWidget {
  final int idWork;
  const WorkCommentList({
    Key? key,
    required this.idWork,
  }) : super(key: key);

  @override
  State<WorkCommentList> createState() => _WorkCommentListState();
}

class _WorkCommentListState extends State<WorkCommentList> {
  bool boolCkeckBox = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WorkCommentsViewModel>(context, listen: false)
          .getWorkComments(context, widget.idWork);
    });
  }

  @override
  Widget build(BuildContext context) {
    final workCommentViewModel =
        Provider.of<WorkCommentsViewModel>(context, listen: true);
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
        decoration: const BoxDecoration(color: kBackgroundComment),
        child: Row(
          children: [
            const Icon(Icons.history),
            const SizedBox(
              width: 15,
            ),
            const Text(
              "HOẠT ĐỘNG",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const Spacer(),
            SizedBox(
              child: PopupMenuButton<int>(
                splashRadius: 25,
                elevation: 0.2,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                itemBuilder: (context) {
                  return <PopupMenuEntry<int>>[
                    PopupMenuItem(
                        height: 15,
                        child: StatefulBuilder(
                            builder: (context, setState) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      boolCkeckBox = !boolCkeckBox;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("Hiện chi tiết"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Checkbox(
                                          //remove padding check box
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          value: boolCkeckBox,
                                          onChanged: (value) {
                                            setState(() {
                                              boolCkeckBox = !boolCkeckBox;
                                            });
                                          })
                                    ],
                                  ),
                                )),
                        value: 0),
                  ];
                },
              ),
            ),
          ],
        ),
      ),
      const Divider(
        height: 0,
        color: Colors.white,
        indent: 1,
        endIndent: 10,
      ),
      // const SizedBox(
      //   height: 15,
      // ),
      _ui(workCommentViewModel)
    ]);
  }

  _ui(WorkCommentsViewModel workCommentsViewModel) {
    if (workCommentsViewModel.loading) {
      return Container();
    } else {
      return Container(
        decoration: const BoxDecoration(color: kBackgroundComment),
        padding: workCommentsViewModel.workCommentListModel.isNotEmpty
            ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
            : EdgeInsets.zero,
        child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              WorkComment workComment =
                  workCommentsViewModel.workCommentListModel[index];
              return SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    workComment.userModel.image == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/doraemon.png",
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                            ))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              workComment.userModel.image!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                            )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                workComment.userModel.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(workComment.content)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Thích",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kBorderColor),
                            ),
                            // SizedBox(
                            //   width: 15,
                            // ),
                            // Text(
                            //   "Phản hồi",
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       color: kBorderColor),
                            // )
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              );
            }),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: workCommentsViewModel.workCommentListModel.length),
      );
    }
  }
}
