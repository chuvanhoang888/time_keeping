import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/components/work_request.dart';
import 'package:app_cham_cong_option_2/screen/work/work_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WorkListButton extends StatefulWidget {
  const WorkListButton({
    Key? key,
  }) : super(key: key);

  @override
  State<WorkListButton> createState() => _WorkListButtonState();
}

class _WorkListButtonState extends State<WorkListButton> {
  OverlayEntry? entry;
  final layerLink = LayerLink();
  bool click = false;

  void showOverlay() {
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    //final offset = renderBox.localToGlobal(Offset.zero);
    entry = OverlayEntry(
      builder: (context) => Positioned(
          width: size.width - 30,
          // left: offset.dx,
          // top: offset.dy + size.height,
          child: CompositedTransformFollower(
              link: layerLink,
              offset: Offset(0, size.height + 8),
              showWhenUnlinked: false,
              child: WorkListOverlayClass(
                entry: entry,
                click: click,
              ))),
    );
    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Row(
        children: [
          SvgPicture.asset("assets/icons/domain_verification-24px.svg"),
          const SizedBox(
            width: 15,
          ),
          CompositedTransformTarget(
            link: layerLink,
            child: InkWell(
              onTap: () {
                //click = !click;
                if (click == false) {
                  click = true;
                  showOverlay();
                } else {
                  click = false;
                  hideOverlay();
                }
                setState(() {});
              },
              child: const Text(
                "Danh sách công việc...",
                style: TextStyle(color: kBorderColor, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class WorkListOverlayClass extends StatefulWidget {
  OverlayEntry? entry;
  bool click;

  WorkListOverlayClass({
    Key? key,
    required this.entry,
    required this.click,
  }) : super(key: key);

  @override
  State<WorkListOverlayClass> createState() => _WorkListOverlayClassState();
}

class _WorkListOverlayClassState extends State<WorkListOverlayClass>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  late FocusNode _focusNode;
  late String contentWork;
  late double keyboardSize;

  void hideOverlay() {
    if (widget.entry != null && widget.entry!.mounted) {
      widget.entry?.remove();
      widget.entry = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _animation = Tween(begin: 0.0, end: 500.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    //WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => showOverlay());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();

    //scrollController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      keyboardSize = MediaQuery.of(context).viewInsets.bottom;
      print(keyboardSize.toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
            borderRadius: BorderRadius.circular(15),
            elevation: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(10),
                        height: 150,
                        child: TextField(
                          focusNode: _focusNode,
                          autocorrect: false,
                          enableSuggestions: false,
                          autofocus: false,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (s) {
                            contentWork = s;
                          },
                          scrollPadding: EdgeInsets.only(
                            bottom: keyboardSize,
                          ),
                          onTap: (() {
                            //FocusScope.of(context).unfocus();
                          }),
                          style:
                              const TextStyle(decoration: TextDecoration.none),
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(fontSize: 12),
                            hintText: "Nội dung bài viết...",
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        )),
                    const Divider(
                      height: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                backgroundColor: kBackgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                final workTask =
                                    Provider.of<WorkListTodoProvider>(context,
                                        listen: false);

                                workTask.addTask(contentWork);

                                setState(() {
                                  widget.click = !widget.click;
                                });

                                hideOverlay();
                              },
                              child: const Text(
                                "Tạo",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    )
                  ]),
            )),
        // Container(
        //   height: _animation.value,
        //   color: Colors.blueAccent,
        // ),
      ],
    );
  }
}
