import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/view_models/auth_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_comment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkCommentInput extends StatefulWidget {
  final int idWork;
  const WorkCommentInput({
    Key? key,
    required this.idWork,
  }) : super(key: key);

  @override
  State<WorkCommentInput> createState() => _WorkCommentInputState();
}

class _WorkCommentInputState extends State<WorkCommentInput> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _editTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: true);
    final workCommentViewModel =
        Provider.of<WorkCommentsViewModel>(context, listen: true);
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
                      color: kInputColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: TextField(
                      scrollController: _scrollController,
                      controller: _editTextController,
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Bình luận...',
                      ),
                    ),
                  ))),
          IconButton(
              onPressed: () {
                if (_editTextController.text.isNotEmpty) {
                  FocusScope.of(context).unfocus();
                  workCommentViewModel
                      .createWorkComment(
                          context, widget.idWork, _editTextController.text)
                      .whenComplete(() {
                    _editTextController.clear();
                  });
                }
              },
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
