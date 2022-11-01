import 'dart:async';

import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/home/permission.dart';
import 'package:app_cham_cong_option_2/data/view_models/permission_view_model.dart';
import 'package:app_cham_cong_option_2/screen/home/components/permission_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PermissionDetailScreen extends StatefulWidget {
  final PermissonModel permissonModel;

  const PermissionDetailScreen({
    Key? key,
    required this.permissonModel,
  }) : super(key: key);

  @override
  State<PermissionDetailScreen> createState() => _PermissionDetailScreenState();
}

class _PermissionDetailScreenState extends State<PermissionDetailScreen> {
  DateTime now = DateTime.now();
  final TextEditingController _editTextContentController =
      TextEditingController();

  final ScrollController _scrollController = ScrollController();
  String date = "T" +
      (DateTime.now().weekday + 1).toString() +
      " - " +
      (DateFormat(' dd/MM/yyyy').format(DateTime.now()));
  String dropdownValue = 'One';
  List<String> mapFrom = ['One', 'Two', 'Free', 'Four'];
  bool click = false;
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  void initState() {
    _editTextContentController.text = widget.permissonModel.content!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PermissionViewModel permissionViewModel =
        context.watch<PermissionViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        elevation: 0.5,
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
              "Tạo phép",
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
            // Your widgets here
          ],
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              widget.permissonModel.userModel!.image == null
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
                                        widget.permissonModel.userModel!.image
                                            .toString(),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.fill,
                                      )),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                height: 40,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.permissonModel.userModel!.name,
                                        style: const TextStyle(fontSize: 15)),
                                    Text(
                                      "Đến: " +
                                          widget.permissonModel.toMail
                                              .toString(),
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          ])),
                  const Divider(
                    height: 1,
                    indent: 1,
                    endIndent: 2,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.permissonModel.time!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              widget.permissonModel.day!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("ĐƠN XIN PHÉP",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(widget.permissonModel.type!,
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(
                              height: 15,
                            ),
                            Scrollbar(
                                controller: _scrollController,
                                child: TextField(
                                  enabled: false,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: _editTextContentController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                )),
                          ])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
