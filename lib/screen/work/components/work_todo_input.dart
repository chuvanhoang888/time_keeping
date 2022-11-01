import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WorkTodoInput extends StatefulWidget {
  final int idWork;
  const WorkTodoInput({
    Key? key,
    required this.idWork,
  }) : super(key: key);

  @override
  State<WorkTodoInput> createState() => _WorkTodoInputState();
}

class _WorkTodoInputState extends State<WorkTodoInput> {
  bool isMenuOpen = false;
  String? listTodo;
  final TextEditingController _editTextController = TextEditingController();
  @override
  void initState() {
    super.initState();

    //WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => showOverlay());
  }

  @override
  void dispose() {
    super.dispose();

    //scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workTodo = Provider.of<WorkTodoViewModel>(context, listen: false);
    return Row(
      children: [
        SvgPicture.asset("assets/icons/domain_verification-24px.svg"),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              showDialog(
                  barrierColor: Colors.grey.withOpacity(0.1),
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
                                            onChanged: (s) {
                                              listTodo = s;
                                            },
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
                                                      .text.isNotEmpty) {
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                    Navigator.pop(context);
                                                    workTodo
                                                        .createTodo(
                                                            context,
                                                            widget.idWork,
                                                            _editTextController
                                                                .text)
                                                        .whenComplete(() {
                                                      _editTextController
                                                          .clear();
                                                    });
                                                    //setState(() {});

                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Vui lòng nhập nội dung !",
                                                        textColor: Colors.black,
                                                        backgroundColor:
                                                            Colors.white);
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
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("Danh sách công việc...",
                  style: TextStyle(color: kBorderColor, fontSize: 12)),
            ),
          ),
        ),
      ],
    );
  }
}
