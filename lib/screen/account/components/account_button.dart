import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountButton extends StatelessWidget {
  final String icon;
  final String title;
  final String iconRight;
  final VoidCallback onPress;
  const AccountButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.iconRight,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(title),
            const Spacer(),
            SvgPicture.asset(
              iconRight,
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
