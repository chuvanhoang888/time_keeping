import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  final String tittle;
  final double elevate;
  final bool centerTitle;
  const CustomAppbar(
      {Key? key,
      required this.tittle,
      required this.elevate,
      required this.centerTitle})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent),
      elevation: elevate,
      centerTitle: centerTitle,
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

          Text(
            tittle,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          )
          // Your widgets here
        ],
      ),
      titleSpacing: 0,
    );
  }
}
