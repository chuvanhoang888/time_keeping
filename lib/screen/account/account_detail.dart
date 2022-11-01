import 'package:app_cham_cong_option_2/components/appbar.dart';
import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:app_cham_cong_option_2/screen/account/components/build_phone_textfield.dart';
import 'package:app_cham_cong_option_2/screen/account/components/text_field_widget.dart';
import 'package:flutter/material.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({Key? key}) : super(key: key);

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppbar(
        tittle: "Tài khoản cá nhân",
        elevate: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          //padding: const EdgeInsets.only(bottom: 100),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        label: "Tên",
                        text: "Thanh ",
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const Spacer(),
                      TextFieldWidget(
                        label: "Họ",
                        text: "Le",
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const Spacer(),
                      TextFieldWidget(
                        label: "Giới tính",
                        text: "Nữ",
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const Spacer(),
                      TextFieldWidget(
                        label: "Email*",
                        text: "tuyenlt@dtsmart.vn",
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const Spacer(),
                      PhoneTextFieldWidget(
                        label: "Số điện thoại",
                        text: "0377374066",
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const Spacer(),
                      TextFieldWidget(
                        label: "Địa chỉ tạm trú",
                        maxLines: 3,
                        text:
                            "137 Cộng Hòa, P13, Tân Phú, TP.HCM  TP.HCM 137 Cộng Hòa, P13, Tân Phú, TP.HCM",
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const Spacer(),
                        DefaultButton(title: "Xác nhận", press: () {}),
                        const Spacer(),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
