import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_user_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WorkMember extends StatefulWidget {
  final int idWork;
  const WorkMember({
    Key? key,
    required this.idWork,
  }) : super(key: key);

  @override
  State<WorkMember> createState() => _WorkMemberState();
}

class _WorkMemberState extends State<WorkMember> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WorkUserViewModel>(context, listen: false)
          .getWorkUser(context, widget.idWork);
    });
  }

  @override
  void dispose() {
    super.dispose();

    //scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workUserViewModel =
        Provider.of<WorkUserViewModel>(context, listen: true);

    return _ui(workUserViewModel);
  }

  _ui(WorkUserViewModel workUserViewModel) {
    if (workUserViewModel.loadingUser) {
      return Container();
    } else {
      return SizedBox(
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/person_add_alt_1-24px.svg",
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  showDialog(
                    barrierColor: Colors.blueGrey.withOpacity(0.1),
                    context: context,
                    builder: (conttext) =>
                        const Center(child: AlertDialogUser()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: workUserViewModel.listMember.isNotEmpty
                      ? SizedBox(
                          height: 50,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (index < 5) {
                                return workUserViewModel
                                            .listMember[index].image ==
                                        null
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
                                          workUserViewModel
                                              .listMember[index].image!,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.fill,
                                        ));
                              } else {
                                return Stack(
                                  children: [
                                    workUserViewModel.listMember[index].image ==
                                            null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Image.asset(
                                              "assets/images/doraemon.png",
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ))
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Image.network(
                                              workUserViewModel
                                                  .listMember[index].image!,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            )),
                                    workUserViewModel.listMember.length > 6
                                        ? Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blueAccent
                                                  .withOpacity(0.5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "+ " +
                                                    (workUserViewModel
                                                                .listMember
                                                                .length -
                                                            6)
                                                        .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ))
                                        : Container()
                                  ],
                                );
                              }
                            },
                            itemCount: workUserViewModel.listMember.length < 6
                                ? workUserViewModel.listMember.length
                                : 6,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 10,
                            ),
                          ),
                        )
                      : const Text("Thêm thành viên...",
                          style: TextStyle(color: kBorderColor, fontSize: 12)),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class AlertDialogUser extends StatefulWidget {
  const AlertDialogUser({Key? key}) : super(key: key);

  @override
  State<AlertDialogUser> createState() => _AlertDialogUserState();
}

class _AlertDialogUserState extends State<AlertDialogUser> {
  @override
  Widget build(BuildContext context) {
    final workUserViewModel =
        Provider.of<WorkUserViewModel>(context, listen: true);
    final workViewModel = Provider.of<WorkViewModel>(context, listen: true);
    return workUserViewModel.loading
        ? const Center()
        : AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor: Colors.transparent,
            content: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5,
                child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            height: 400,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      if (workUserViewModel
                                              .userListModel[index].selected ==
                                          false) {
                                        // workUserViewModel.addMembder(
                                        //     workUserViewModel.userListModel[index]);
                                        workUserViewModel.addMembder(
                                            context,
                                            index,
                                            workViewModel.selectedWork.id);
                                      } else {
                                        workUserViewModel.removeMember(
                                            context,
                                            index,
                                            workUserViewModel
                                                .userListModel[index]
                                                .idWorkUser);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Stack(
                                            children: [
                                              workUserViewModel
                                                          .userListModel[index]
                                                          .image ==
                                                      null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: Image.asset(
                                                        "assets/images/doraemon.png",
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.fill,
                                                      ))
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      child: Image.network(
                                                        workUserViewModel
                                                            .userListModel[
                                                                index]
                                                            .image!,
                                                        width: 80,
                                                        height: 80,
                                                        fit: BoxFit.fill,
                                                      )),
                                              workUserViewModel
                                                          .userListModel[index]
                                                          .selected ==
                                                      true
                                                  ? const Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Center(
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              kBackgroundColor,
                                                          radius: 10,
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                            size: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          height: 60,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(workUserViewModel
                                                  .userListModel[index].name),
                                              Text(
                                                workUserViewModel
                                                    .userListModel[index].email,
                                                style: const TextStyle(
                                                    color: kBorderColor),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                              },
                              itemCount: workUserViewModel.userListModel.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                        workUserViewModel.listMember.isNotEmpty
                            ? const Divider()
                            : Container(),
                        workUserViewModel.listMember.isNotEmpty
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                height: 80,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: ((context, index) {
                                          if (workUserViewModel
                                                  .userListModel[index]
                                                  .selected ==
                                              true) {
                                            return Stack(
                                              children: [
                                                workUserViewModel
                                                            .userListModel[
                                                                index]
                                                            .image ==
                                                        null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child: Image.asset(
                                                          "assets/images/doraemon.png",
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.fill,
                                                        ))
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child: Image.network(
                                                          workUserViewModel
                                                              .userListModel[
                                                                  index]
                                                              .image!,
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
                                                        workUserViewModel
                                                            .removeMember(
                                                                context,
                                                                index,
                                                                workUserViewModel
                                                                    .userListModel[
                                                                        index]
                                                                    .idWorkUser);
                                                      },
                                                      child: const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        radius: 10,
                                                        child: Icon(
                                                          Icons.clear,
                                                          color: Colors.white,
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
                                        itemCount: workUserViewModel
                                            .userListModel.length,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          width: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ))));
  }
}
