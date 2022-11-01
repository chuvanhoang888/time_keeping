import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthViewModel authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: _ui(authViewModel, size, context),
    );
  }

  _ui(
    AuthViewModel authViewModel,
    Size size,
    BuildContext context,
  ) {
    if (authViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: kBackgroundColor,
        ),
      );
    } else {
      return Stack(
        children: [
          Container(
            width: double.infinity,
            height: size.height,
            decoration: const BoxDecoration(color: kCheckinColor),
            child: Column(
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    padding: const EdgeInsets.only(left: 30),
                    width: double.infinity,
                    height: size.height / 4,
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                              splashColor: kBackgroundColor,
                              onTap: () => Navigator.pop(context),
                              child: SvgPicture.asset(
                                "assets/icons/Group 5356.svg",
                                width: 10,
                              ))),
                      Expanded(child: Image.asset("assets/icons/Logo 2@3x.png"))
                    ],
                  ),
                  authViewModel.userModel.image == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(
                            "assets/images/doraemon.png",
                            width: 140,
                            height: 140,
                            fit: BoxFit.fill,
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.network(
                            authViewModel.userModel.image!,
                            width: 140,
                            height: 140,
                            fit: BoxFit.fill,
                          )),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    authViewModel.userModel.name,
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    authViewModel.userModel.position!,
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  Text(
                    "ID:" + authViewModel.userModel.id.toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  QrImage(
                    backgroundColor: Colors.white,
                    data: authViewModel.userModel.id.toString(),
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ]),
          ),
          Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                "assets/images/Group 5355.png",
                width: 170,
                height: 100,
              ))
        ],
      );
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var w = size.width;
    var h = size.height;
    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 100, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
