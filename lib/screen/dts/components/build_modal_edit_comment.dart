import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/comments.dart';
import 'package:app_cham_cong_option_2/data/view_models/comments_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BuildModalEditComment extends StatefulWidget {
  final Comments comment;
  final int index;
  const BuildModalEditComment({
    Key? key,
    required this.comment,
    required this.index,
  }) : super(key: key);

  @override
  State<BuildModalEditComment> createState() => _BuildModalEditCommentState();
}

class _BuildModalEditCommentState extends State<BuildModalEditComment>
    with TickerProviderStateMixin {
  final _editTextController = TextEditingController();
  late FocusNode _focusNode;
  bool isButtonEnabled = false;
  late AnimationController controller2;

  final ScrollController _scrollController = ScrollController();
  String? value;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    controller2 = BottomSheet.createAnimationController(this);
    controller2.duration = const Duration(milliseconds: 500);
    _editTextController.text = widget.comment.content;
  }

  @override
  void dispose() {
    super.dispose();
    _editTextController.dispose();
    controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var commentsProvider =
        Provider.of<CommentsViewModel>(context, listen: true);

    return DraggableScrollableSheet(
      initialChildSize: 0.96,
      builder: ((context, scrollController) => StatefulBuilder(
          builder: (context, setState) => Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              child: Scaffold(
                appBar: AppBar(
                    toolbarHeight: 45,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    leading: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pop(true);
                        },
                        child: const Icon(Icons.arrow_back_ios,
                            color: Colors.black)),
                    centerTitle: true,
                    title: const Text(
                      "Chỉnh sửa",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    )),
                body: Container(
                    child: Column(
                  children: [
                    const Divider(
                      height: 0,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              widget.comment.userModel.image == null
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
                                        widget.comment.userModel.image!,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.fill,
                                      )),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: kBackgroundComment,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Scrollbar(
                                        controller: _scrollController,
                                        thumbVisibility: true,
                                        child: TextField(
                                          onChanged: (newValue) {
                                            setState(
                                              () {
                                                value = newValue;
                                              },
                                            );
                                          },
                                          autocorrect: false,
                                          enableSuggestions: false,
                                          maxLines: null,
                                          scrollController: _scrollController,
                                          keyboardType: TextInputType.multiline,
                                          controller: _editTextController,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10)),
                                        ),
                                      )))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: kBackgroundComment,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(50, 30)),
                                  child: const Text(
                                    "Hủy",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).pop(true);
                                  }),
                              const SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          _editTextController.text !=
                                                  widget.comment.content
                                              ? kBackgroundColor
                                              : kBackgroundComment,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: const Size(50, 30)),
                                  child: Text(
                                    "Cập nhật",
                                    style: TextStyle(
                                        color: _editTextController.text !=
                                                widget.comment.content
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  onPressed: _editTextController.text !=
                                          widget.comment.content
                                      ? () {
                                          widget.comment.content =
                                              _editTextController.text;

                                          commentsProvider.updateStateComment(
                                              widget.index,
                                              _editTextController.text);
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          commentsProvider.updateComment(
                                              context, widget.comment);
                                        }
                                      : null)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )),
              )))),
    );
  }
}
