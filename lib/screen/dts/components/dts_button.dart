import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DTSButton extends StatelessWidget {
  final String image;
  final String text;

  final Color textColor;
  final VoidCallback onPress;
  const DTSButton({
    Key? key,
    required this.image,
    required this.text,
    required this.onPress,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
      onPressed: onPress,
      child: Row(
        children: [
          Image.asset(
            image,
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
