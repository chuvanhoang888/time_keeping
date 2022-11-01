import 'dart:async';

import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/view_models/permission_view_model.dart';
import 'package:app_cham_cong_option_2/screen/home/components/permission_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PermissionFormScreen extends StatefulWidget {
  final String type;
  final DateTime startDay;
  final DateTime endDay;

  const PermissionFormScreen(
      {Key? key,
      required this.startDay,
      required this.endDay,
      required this.type})
      : super(key: key);

  @override
  State<PermissionFormScreen> createState() => _PermissionFormScreenState();
}

class _PermissionFormScreenState extends State<PermissionFormScreen> {
  Timer? _timer;
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
    _editTextContentController.text =
        "Dear Toàn Nguyễn ,\n\nTôi tên Thanh Lê bộ phận thiết kế. Tôi làm đơn này xin phép anh (chị)  được nghỉ ngày " +
            DateFormat(' dd/MM/yyyy').format(widget.startDay) +
            " đến ngày " +
            DateFormat(' dd/MM/yyyy').format(widget.endDay) +
            ". Vì lý do …….. nên tôi làm đơn này. Mong anh (chị) duyệt qua." +
            "\n\nSau khi đi làm lại. Tôi sẽ đảm bảo yêu cầu và tiến độ công việc." +
            "\n\n\n Họ và Tên " +
            "\n\n Chức vụ";
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
                              const Text(
                                "Đến:",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              // Expanded(
                              //   child: Container(
                              //     padding:
                              //         const EdgeInsets.only(left: 16, right: 16),
                              //     decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         borderRadius: BorderRadius.circular(12),
                              //         boxShadow: [
                              //           BoxShadow(
                              //               offset: const Offset(0, 2),
                              //               blurRadius: 5,
                              //               color: kShadowColor)
                              //         ]),
                              //     child: DropdownButtonFormField<String>(
                              //       decoration: const InputDecoration(
                              //           border: InputBorder.none),
                              //       //value: dropdownValue,
                              //       isExpanded: true,
                              //       icon: SvgPicture.asset(
                              //           "assets/icons/Group 5339.svg"),
                              //       elevation: 16,

                              //       style: const TextStyle(color: Colors.black),

                              //       onChanged: (String? newValue) {
                              //         setState(() {
                              //           dropdownValue = newValue!;
                              //         });
                              //       },
                              //       alignment: Alignment.bottomCenter,

                              //       items: mapFrom.map<DropdownMenuItem<String>>(
                              //           (String value) {
                              //         return DropdownMenuItem<String>(
                              //           value: value,
                              //           child: Text(
                              //             value,
                              //           ),
                              //         );
                              //       }).toList(),
                              //     ),
                              //   ),
                              //   //
                              // )
                              Expanded(
                                  child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: const [
                                      // Icon(
                                      //   Icons.list,
                                      //   size: 16,
                                      //   color: Colors.yellow,
                                      // ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: items.map((item) {
                                    var index = items.indexOf(item);
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Row(
                                        children: [
                                          Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          // index == 0
                                          //     ? const Spacer()
                                          //     : Container(),
                                          // index == 0
                                          //     ? const Icon(
                                          //         Icons
                                          //             .keyboard_arrow_up_outlined,
                                          //         color: kSwitchColor,
                                          //       )
                                          //     : Container()
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as String;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                  ),
                                  iconOnClick: const Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                  ),

                                  iconSize: 25,

                                  iconEnabledColor: kSwitchColor,
                                  iconDisabledColor: Colors.grey,
                                  buttonHeight: 50,
                                  buttonWidth: 160,
                                  dropdownOverButton: true,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  buttonElevation: 1,
                                  itemHeight: 40,
                                  itemPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  // dropdownMaxHeight: 200,
                                  // dropdownWidth: 200,
                                  dropdownPadding: null,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),

                                  isDense: false,
                                  dropdownElevation: 1,

                                  scrollbarRadius: const Radius.circular(40),
                                  scrollbarThickness: 3,
                                  scrollbarAlwaysShow: true,
                                  //offset: const Offset(-20, 0),
                                ),
                              )),
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Loại phép: ',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: widget.type,
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            )
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
                              DateFormat('hh:mm a').format(now),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              date,
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
                              height: 15,
                            ),
                            Scrollbar(
                                controller: _scrollController,
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: _editTextContentController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                )),
                          ])),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: DefaultButton(
                      title: "Tạo phép",
                      press: () async {
                        _timer?.cancel();
                        await EasyLoading.show(
                          status: 'Loading...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        permissionViewModel
                            .createPermission(
                                context,
                                DateFormat('hh:mm a').format(now),
                                date,
                                _editTextContentController.text,
                                widget.type,
                                "toan@dtsmart.vn")
                            .whenComplete(() {
                          EasyLoading.dismiss();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PermissionScreen()),
                              (route) => false);
                        });
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
