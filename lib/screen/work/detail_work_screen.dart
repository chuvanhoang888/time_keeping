import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/work/work.dart';
import 'package:app_cham_cong_option_2/data/view_models/auth_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_view_model.dart';
import 'package:app_cham_cong_option_2/screen/work/components/work_comment_input.dart';
import 'package:app_cham_cong_option_2/screen/work/components/work_comment_list.dart';
import 'package:app_cham_cong_option_2/screen/work/components/work_photo.dart';
import 'package:app_cham_cong_option_2/screen/work/components/work_todo_input.dart';
import 'package:app_cham_cong_option_2/screen/work/components/work_member.dart';
import 'package:app_cham_cong_option_2/screen/work/components/work_todo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DetailWorkScreen extends StatefulWidget {
  final int index;

  const DetailWorkScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailWorkScreen> createState() => _DetailWorkScreenState();
}

class _DetailWorkScreenState extends State<DetailWorkScreen> {
  late String selectedProgress;
  ScrollController scrollController = ScrollController();
  final TextEditingController _editTextController = TextEditingController();
  late double keyboardSize;

  @override
  void initState() {
    super.initState();
    final workViewModel = Provider.of<WorkViewModel>(context, listen: false);
    selectedProgress = workViewModel.selectedWork.status == 0
        ? "getJob"
        : workViewModel.selectedWork.status == 1
            ? "doing"
            : "complete";
    _editTextController.text = workViewModel.selectedWork.path ?? "";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    });
  }

  @override
  void dispose() {
    super.dispose();
    //scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workViewModel = Provider.of<WorkViewModel>(context, listen: true);

    //final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
              const Text(
                "Công việc",
                style: TextStyle(fontSize: 12, color: Colors.black),
              )
              // Your widgets here
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerTitle(workViewModel.selectedWork),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      child: Column(
                        children: [
                          filterProgress(workViewModel),

                          //const WorkDateButton(),
                          const SizedBox(
                            height: 10,
                          ),
                          WorkMember(idWork: workViewModel.selectedWork.id!),
                          WorkTodoInput(
                            idWork: workViewModel.selectedWork.id!,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          WorkTodoList(
                            idWork: workViewModel.selectedWork.id!,
                          ),
                          //_uiTodo(workTodoViewModel),

                          const SizedBox(
                            height: 10,
                          ),
                          workPathButton(workViewModel),
                        ],
                      ),
                    ),
                    const Divider(),
                    WorkPhoto(
                      idWork: workViewModel.selectedWork.id!,
                    ),
                    //const Divider(),
                    WorkCommentList(
                      idWork: workViewModel.selectedWork.id!,
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const Divider(),
                WorkCommentInput(
                  idWork: workViewModel.selectedWork.id!,
                )
              ],
            )
          ],
        ));
  }

  Container headerTitle(Work work) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 20),
        decoration: const BoxDecoration(color: kBackgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              work.dateTime!,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(work.name!,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(
              height: 15,
            ),
            Text(
                "Thời gian: " +
                    work.startDay!.toString() +
                    " - " +
                    work.endDay!.toString(),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
          ],
        ),
      );
  Row filterProgress(WorkViewModel workViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            changeProgress(workViewModel, "getJob");
            workViewModel.updateStateWorkList(
                widget.index, workViewModel.selectedWork);
            workViewModel.editWork(context, workViewModel.selectedWork);
          },
          child: Container(
            width: 90,
            height: 35,
            decoration: selectedProgress == "getJob"
                ? BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(10))
                : BoxDecoration(
                    border: Border.all(
                      color: kBorderColor.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Nhận việc",
                style: selectedProgress == "getJob"
                    ? const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)
                    : const TextStyle(color: kBorderColor, fontSize: 13),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            changeProgress(workViewModel, "doing");
            workViewModel.updateStateWorkList(
                widget.index, workViewModel.selectedWork);
            workViewModel.editWork(context, workViewModel.selectedWork);
          },
          child: Container(
            width: 90,
            height: 35,
            decoration: selectedProgress == "doing"
                ? BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(10))
                : BoxDecoration(
                    border: Border.all(
                      color: kBorderColor.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Đang làm",
                style: selectedProgress == "doing"
                    ? const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)
                    : const TextStyle(color: kBorderColor, fontSize: 13),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            changeProgress(workViewModel, "complete");
            workViewModel.updateStateWorkList(
                widget.index, workViewModel.selectedWork);
            workViewModel.editWork(context, workViewModel.selectedWork);
          },
          child: Container(
            width: 90,
            height: 35,
            decoration: selectedProgress == "complete"
                ? BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(10))
                : BoxDecoration(
                    border: Border.all(
                      color: kBorderColor.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Hoàn thành",
                style: selectedProgress == "complete"
                    ? const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)
                    : const TextStyle(color: kBorderColor, fontSize: 13),
              ),
            ),
          ),
        )
      ],
    );
  }

  void changeProgress(WorkViewModel workViewModel, String progress) {
    selectedProgress = progress;
    if (progress == "getJob") {
      workViewModel.selectedWork.status = 0;
    } else if (progress == "doing") {
      workViewModel.selectedWork.status = 1;
    } else {
      workViewModel.selectedWork.status = 2;
    }
    setState(() {});
  }

  Row workPathButton(WorkViewModel workViewModel) {
    return Row(
      children: [
        SvgPicture.asset("assets/icons/external-link.svg"),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              showDialog(
                  barrierColor: Colors.blueGrey.withOpacity(0.1),
                  context: context,
                  builder: (conttext) => Center(
                      child: AlertDialog(
                          insetPadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          backgroundColor: Colors.transparent,
                          content: Material(
                            borderRadius: BorderRadius.circular(15),
                            // elevation: 8,
                            child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                height: 155,
                                //padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          padding: const EdgeInsets.all(10),
                                          height: 100,
                                          child: TextField(
                                            controller: _editTextController,
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            autofocus: false,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            onChanged: (s) {},
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.none),
                                            decoration: const InputDecoration(
                                              hintStyle:
                                                  TextStyle(fontSize: 12),
                                              hintText: "Nội dung bài viết...",
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                          )),
                                      const Divider(
                                        height: 0.5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  minimumSize:
                                                      const Size(50, 30),
                                                  backgroundColor:
                                                      kBackgroundColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  if (_editTextController
                                                      .text.isEmpty) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Vui lòng nhập tệp tin đính kèm !",
                                                        textColor: Colors.black,
                                                        backgroundColor:
                                                            Colors.white);
                                                  } else {
                                                    // workViewModel
                                                    //     .updateSelectedWorkPath(
                                                    //         _editTextController
                                                    //             .text);

                                                    // workViewModel
                                                    //     .updateStateWorkList(
                                                    //         widget.index,
                                                    //         workViewModel
                                                    //             .selectedWork);
                                                    workViewModel
                                                            .selectedWork.path =
                                                        _editTextController
                                                            .text;
                                                    workViewModel
                                                        .editWork(
                                                            context,
                                                            workViewModel
                                                                .selectedWork)
                                                        .whenComplete(() {
                                                      Navigator.pop(context);
                                                    });
                                                  }
                                                },
                                                child: const Text(
                                                  "Tạo",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ),
                                      )
                                    ])),
                          ))));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _editTextController.text.isNotEmpty
                  ? Text(workViewModel.selectedWork.path!)
                  : const Text("Thêm tập tin đính kèm...",
                      style: TextStyle(color: kBorderColor, fontSize: 12)),
            ),
          ),
        ),
      ],
    );
  }

  workComments(AuthViewModel authViewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          _uiAuth(authViewModel),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: kInputColor, borderRadius: BorderRadius.circular(10)),
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                hintText: 'Bình luận...',
              ),
            ),
          )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send_rounded,
                color: kBackgroundColor,
              ))
        ],
      ),
    );
  }

  _uiAuth(AuthViewModel authViewModel) {
    if (authViewModel.loading) {
      return Container(
        width: 50,
        height: 50,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: kSwitchColor),
        child: const CircularProgressIndicator(color: kBackgroundColor),
      );
    } else {
      return authViewModel.userModel.image == null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                "assets/images/doraemon.png",
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ))
          : ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                authViewModel.userModel.image!,
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ));
    }
  }
}
