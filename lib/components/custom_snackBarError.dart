import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSnackBarError extends StatelessWidget {
  const CustomSnackBarError({Key? key, required this.error}) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(offset: Offset(1, 1), blurRadius: 15, color: kButtonColor),
        BoxShadow(offset: Offset(-1, -1), blurRadius: 15, color: kButtonColor)
      ], borderRadius: BorderRadius.circular(10), color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          SvgPicture.asset(
              "assets/icons/5803959_attention_exclamation_notice_warning_icon.svg",
              width: 40,
              color: Colors.black),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              error.toString(),
              style: const TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
