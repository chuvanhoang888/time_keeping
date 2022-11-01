import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/post_user_tag_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/posts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  final FocusNode _focusNodes = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostUserTagViewModel postUserTagViewModel =
        context.watch<PostUserTagViewModel>();
    return Scaffold(
        resizeToAvoidBottomInset:
            false, // Ngăn sliding up panel nhảy lên khi mở keyboard
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Navigator.of(context, rootNavigator: true).maybePop(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: const Text(
            "Gắn thẻ thành viên",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          titleSpacing: 0,
        ),
        body: _ui(postUserTagViewModel));
  }

  _ui(PostUserTagViewModel postUserTagViewModel) {
    if (postUserTagViewModel.loading) {
      return Container();
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: kBackgroundComment,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextField(
                    focusNode: _focusNodes,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: _focusNodes.hasFocus ? Colors.grey : Colors.grey,
                      ),
                      hintStyle:
                          const TextStyle(fontSize: 18, color: kBorderColor),
                      hintText: "Tìm kiếm",
                      //contentPadding: const EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                postUserTagViewModel.listMember.isNotEmpty
                    ? const Text("Đã chọn",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                    : Container(),
                postUserTagViewModel.listMember.isNotEmpty
                    ? const SizedBox(
                        height: 15,
                      )
                    : Container(),
                postUserTagViewModel.listMember.isNotEmpty
                    ? SizedBox(
                        //padding: const EdgeInsets.symmetric(vertical: 10),
                        height: 70,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: ((context, index) {
                                  if (postUserTagViewModel
                                          .userList[index].selected ==
                                      true) {
                                    return Stack(
                                      children: [
                                        postUserTagViewModel
                                                    .userList[index].image ==
                                                null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.asset(
                                                  "assets/images/doraemon.png",
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.fill,
                                                ))
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.network(
                                                  postUserTagViewModel
                                                      .userList[index].image!,
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.fill,
                                                )),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                postUserTagViewModel
                                                    .removeMember(
                                                  context,
                                                  index,
                                                );
                                              },
                                              child: const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 10,
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Colors.black,
                                                  size: 17,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                                itemCount: postUserTagViewModel.userList.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Tất cả thành viên",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  // UserModel userModel = postUserTagViewModel.userList[index];
                  return InkWell(
                      onTap: () {
                        if (postUserTagViewModel.userList[index].selected ==
                            false) {
                          // workUserViewModel.addMembder(
                          //     workUserViewModel.userListModel[index]);
                          postUserTagViewModel.addMembder(
                            context,
                            index,
                          );
                        } else {
                          postUserTagViewModel.removeMember(
                            context,
                            index,
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0.2, color: kSwitchColor)),
                            padding: const EdgeInsets.all(0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: postUserTagViewModel
                                          .userList[index].image ==
                                      null
                                  ? Image.asset(
                                      "assets/images/doraemon.png",
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.fill,
                                      gaplessPlayback: true,
                                    )
                                  : Image.network(
                                      postUserTagViewModel.userList[index].image
                                          .toString(),
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.fill,
                                      gaplessPlayback: true,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  postUserTagViewModel.userList[index].name,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Checkbox(
                              value:
                                  postUserTagViewModel.userList[index].selected,
                              onChanged: (bool? value) {})
                        ],
                      ));
                }),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                itemCount: postUserTagViewModel.userList.length),
          )
        ],
      );
    }
  }
}

class CardMember extends StatefulWidget {
  final UserModel userModel;
  const CardMember({Key? key, required this.userModel}) : super(key: key);

  @override
  State<CardMember> createState() => _CardMemberState();
}

class _CardMemberState extends State<CardMember> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 0.2, color: kSwitchColor)),
              padding: const EdgeInsets.all(0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: widget.userModel.image == null
                    ? Image.asset(
                        "assets/images/doraemon.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.fill,
                        gaplessPlayback: true,
                      )
                    : Image.network(
                        widget.userModel.image.toString(),
                        width: 40,
                        height: 40,
                        fit: BoxFit.fill,
                        gaplessPlayback: true,
                      ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userModel.name,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Checkbox(
                value: widget.userModel.selected, onChanged: (bool? value) {})
          ],
        ));
  }
}
