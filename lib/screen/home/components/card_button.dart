import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardButton extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPress;
  const CardButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
            color: kButtonColor,
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: IconButton(
              iconSize: 35,
              onPressed: onPress,
              highlightColor: kBackgroundColor,
              padding: const EdgeInsets.all(25),
              constraints: const BoxConstraints(),
              icon: SvgPicture.asset(
                icon,
                color: kBackgroundColor,
              ),
            )),
        // ElevatedButton(
        //     style: ButtonStyle(
        //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //             RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(40),
        //         )),
        //         minimumSize: MaterialStateProperty.all(const Size.square(80)),
        //         elevation: MaterialStateProperty.all(0),

        //         //foregroundColor: getColor(Colors.red, Colors.white),
        //         backgroundColor: getColor(kButtonColor, kBackgroundColor)),
        //     onPressed: onPress,
        //     child: SvgPicture.asset(
        //       icon,
        //       color: kBackgroundColor,
        //     )),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }

// Color getColor(Set<MaterialState> states) {
//   const Set<MaterialState> interactiveStates = <MaterialState>{
//     MaterialState.pressed,
//     MaterialState.hovered,
//     MaterialState.focused,
//   };
//   if (states.any(interactiveStates.contains)) {
//     return kBackgroundColor;
//   }
//   return kButtonColor;
// }
  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith((getColor));
  }
}
