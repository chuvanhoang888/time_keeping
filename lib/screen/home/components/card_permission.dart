import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/home/permission.dart';
import 'package:app_cham_cong_option_2/data/view_models/permission_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CardPermission extends StatelessWidget {
  final PermissonModel permission;
  final VoidCallback onPress;
  const CardPermission({
    Key? key,
    required this.onPress,
    required this.permission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PermissionViewModel permissionViewModel =
        context.watch<PermissionViewModel>();
    return InkWell(
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
        onTap: onPress,
        child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Slidable(
              secondaryActions: [
                InkWell(
                  onTap: () {
                    permissionViewModel.deletePermission(
                        context, permission.id!);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 5,
                              color: kSwitchColor)
                        ]),
                    child: Center(
                        child: SvgPicture.asset("assets/icons/trash.svg")),
                  ),
                ),
              ],
              actionExtentRatio: .30,
              actionPane: const SlidableDrawerActionPane(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 5,
                          color: kSwitchColor)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          permission.day!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Spacer(),
                        Text(
                          permission.time!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "ĐƠN XIN PHÉP",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      permission.type!,
                      style: const TextStyle(
                          fontSize: 10, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            )));
  }
}
