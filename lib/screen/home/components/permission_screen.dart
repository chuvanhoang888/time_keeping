import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/view_models/permission_view_model.dart';
import 'package:app_cham_cong_option_2/screen/home/components/card_permission.dart';
import 'package:app_cham_cong_option_2/screen/home/components/date_range_screen.dart';
import 'package:app_cham_cong_option_2/screen/home/components/permission_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  List<String> listFunction = [
    "Phép không lương",
    "Phép nghỉ thai sản",
    "Phép làm tại nhà",
    "Phép đi công tác",
    "Phép nghỉ hằng năm"
  ];
  bool click = true;
  FunctionManager fun = FunctionManager();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PermissionViewModel permissionViewModel =
        context.watch<PermissionViewModel>();
    return Scaffold(
        backgroundColor: (click == false) ? kBackgroundColor : Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent),
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
                "Quản lý phép",
                style: TextStyle(fontSize: 12, color: Colors.black),
              )
              // Your widgets here
            ],
          ),
          titleSpacing: 0,
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          spaceBetweenChildren: 10,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          activeBackgroundColor: Colors.red,
          activeForegroundColor: Colors.green,
          //closeManually: true,
          //animatedIcon: AnimatedIcons.add_event,
          children: [
            // SpeedDialChild(
            //   child: const Icon(Icons.photo_camera),
            //   label: 'Activate/Deactivate: Take Photo',
            //   backgroundColor: fun.switchSendPhoto == true
            //       ? const Color.fromARGB(255, 109, 255, 64)
            //       : const Color.fromARGB(255, 255, 64, 64),
            //   onTap: () {
            //     fun = fun.copyWith(switchTakePhoto: !fun.switchSendPhoto);
            //     setState(() {});
            //   },
            // ),
            // SpeedDialChild(
            //   label: "Phép nghỉ hằng năm",
            // ),
            ...List.generate(
              listFunction.length,
              (counter) => SpeedDialChild(
                  backgroundColor: kBackgroundColor,
                  onTap: () {
                    fun = fun.copyWith(switchTakePhoto: !fun.switchSendPhoto);
                    setState(() {});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TableDateRange(
                                  type: listFunction[counter],
                                )));
                  },
                  labelWidget: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    child: Text(
                      listFunction[counter].toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
            )
            // SpeedDialChild(
            //     labelBackgroundColor: kBackgroundColor,
            //     onTap: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => TableDateRange()));
            //     },
            //     labelWidget: Container(
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(10)),
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            //       child: Text(
            //         "Phép nghỉ hằng năm",
            //         style: TextStyle(color: Colors.black),
            //       ),
            //     )),
            // SpeedDialChild(
            //     labelBackgroundColor: kBackgroundColor,
            //     onTap: () {
            //       setState(() {});
            //     },
            //     labelWidget: Container(
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(10)),
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            //       child: Text("Phép đi công tác"),
            //     )),
            // SpeedDialChild(
            //     onTap: () {},
            //     labelWidget: Container(
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(10)),
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            //       child: Text("Phép làm tại nhà"),
            //     )),
            // SpeedDialChild(
            //     onTap: () {},
            //     labelWidget: Container(
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(10)),
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            //       child: Text("Phép nghỉ thai sản"),
            //     )),
            // SpeedDialChild(
            //     onTap: () {},
            //     labelWidget: Container(
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(10)),
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            //       child: Text("Phép không lương"),
            //     ))
          ],
        ),
        body: _ui(permissionViewModel));
  }
}

_ui(PermissionViewModel permissionViewModel) {
  if (permissionViewModel.loading) {
    return const Center(
      child: CircularProgressIndicator(
        color: kBackgroundColor,
      ),
    );
  } else {
    if (permissionViewModel.permissionListModel.isNotEmpty) {
      return SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var permission = permissionViewModel.permissionListModel[index];

                return CardPermission(
                  permission: permission,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PermissionDetailScreen(
                                permissonModel: permission))));
                  },
                );
              },
              itemCount: permissionViewModel.permissionListModel.length,
            ),
          ),
        ],
      ));
    } else {
      return const Center(
        child: Text("Chưa có phép nào được tạo"),
      );
    }
  }
}

class FunctionManager {
  final bool switchSendPhoto;
  FunctionManager({
    this.switchSendPhoto = false,
  });

  FunctionManager copyWith({
    bool? switchTakePhoto,
  }) {
    return FunctionManager(
      switchSendPhoto: switchTakePhoto ?? switchSendPhoto,
    );
  }
}
