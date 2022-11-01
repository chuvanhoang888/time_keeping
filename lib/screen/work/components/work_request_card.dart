import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/work/todo.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class WorkRequestCard extends StatefulWidget {
  final int index;
  final Todo todo;
  const WorkRequestCard({
    Key? key,
    required this.todo,
    required this.index,
  }) : super(key: key);

  @override
  State<WorkRequestCard> createState() => _WorkRequestCardState();
}

class _WorkRequestCardState extends State<WorkRequestCard> {
  final TextEditingController _editTextController = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _editTextController.text = widget.todo.content!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final workTodoViewModel = Provider.of<WorkTodoViewModel>(context);
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ignore: prefer_const_constructors
          RoundCheckBox(
            isChecked: widget.todo.status == 0 ? false : true,
            onTap: (bool? value) {
              setState(() {
                if (value == false) {
                  widget.todo.status = 0;
                } else {
                  widget.todo.status = 1;
                }
              });
              //workTodoViewModel.updateStateTodoList(widget.index, widget.todo);
              workTodoViewModel.editTodo(context, widget.todo);
            },
            size: 20,
            border: Border.all(width: 0, color: Colors.transparent),
            disabledColor: kSwitchColor,
            checkedColor: kBackgroundColor,
            checkedWidget: const Center(
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 15,
              ),
            ),
            uncheckedWidget: const Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 15,
              ),
            ),
            uncheckedColor: kSwitchColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              widget.todo.content!,
              style: TextStyle(
                  decoration: widget.todo.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
            ),
          ),

          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
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
                                                hintText:
                                                    "Nội dung bài viết...",
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
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                              "Vui lòng nhập nội dung !",
                                                          textColor:
                                                              Colors.black,
                                                          backgroundColor:
                                                              Colors.white);
                                                    } else {
                                                      widget.todo.content =
                                                          _editTextController
                                                              .text;
                                                      workTodoViewModel
                                                          .editTodo(context,
                                                              widget.todo)
                                                          .whenComplete(() {
                                                        Navigator.pop(context);
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Cập nhật",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          ),
                                        )
                                      ])),
                            ))));
              },
              icon: const Icon(
                Icons.edit,
                size: 20,
              )),

          const SizedBox(
            width: 5,
          ),
          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
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

                                  //padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "Thông báo",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("Bạn có chắc muốn xóa ?",
                                                  style:
                                                      TextStyle(fontSize: 16))
                                            ],
                                          ),
                                        ),
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
                                                        kSwitchColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Hủy",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    minimumSize:
                                                        const Size(50, 30),
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    // Navigator.pop(context);
                                                    workTodoViewModel
                                                        .deleteTodoInList(
                                                            widget.todo);
                                                    workTodoViewModel
                                                        .deleteTodo(context,
                                                            widget.todo)
                                                        .whenComplete(() {});
                                                  },
                                                  child: const Text(
                                                    "Xóa",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          ),
                                        )
                                      ])),
                            ))));
              },
              icon: const Icon(
                Icons.delete,
                size: 20,
              ))
        ],
      ),
    );
  }
}
