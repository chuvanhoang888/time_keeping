import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSwitch extends StatelessWidget {
  final bool sButton;
  final String title;
  final String details;

  final ValueChanged<bool> onChanged;
  const NotificationSwitch({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.sButton,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Spacer(),
            SizedBox(
                width: 50,
                height: 30,
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: CupertinoSwitch(
                        trackColor: kSwitchColor,
                        activeColor: kBackgroundColor,
                        value: sButton,
                        onChanged: onChanged)))
          ],
        ),
        details.isNotEmpty
            ? const SizedBox(
                height: 15,
              )
            : Container(),
        details.isNotEmpty ? Text(details) : Container(),
        const Divider(
          height: 40,
        )
      ],
    );
  }
}
