import 'dart:io';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/view_models/auth_view_model.dart';
import 'package:app_cham_cong_option_2/screen/account/account_detail.dart';
import 'package:app_cham_cong_option_2/screen/account/account_notification.dart';
import 'package:app_cham_cong_option_2/screen/account/components/account_button.dart';
import 'package:app_cham_cong_option_2/screen/account/settings_screen.dart';
import 'package:app_cham_cong_option_2/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // File? imageFile;
  // Future<void> goToSecondScreen() async {
  //   var result = await Navigator.push(
  //       context,
  //       CustompageRoute(
  //           child: const AlbumImages(
  //             maxSelection: 1,
  //           ),
  //           direction: AxisDirection.up));
  //   if (result != null) {
  //     setState(() {
  //       imageFile = result[0];
  //     });
  //   } else {
  //     //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = context.watch<AuthViewModel>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        body: _ui(authViewModel, context, size));
  }

  _ui(AuthViewModel authViewModel, BuildContext context, Size size) {
    if (authViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(color: kBackgroundColor),
      );
    } else {
      return Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 80),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: const BoxDecoration(color: kBackgroundColor),
                width: double.infinity,
                height: size.height * 0.15,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      authViewModel.pickerImage(context).whenComplete(() {
                        authViewModel.createImageUser(
                            context, authViewModel.fileImage!);
                      });
                    },
                    child: SvgPicture.asset("assets/icons/camera_alt-24px.svg"),
                  ),
                ),
              ),
              authViewModel.fileImage != null
                  ? Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.file(
                            File(authViewModel.fileImage!.path!),
                            width: 160,
                            height: 160,
                            fit: BoxFit.fill,
                            gaplessPlayback: true,
                          ),
                        ),
                        authViewModel.fileImage!.state == 0 ||
                                authViewModel.fileImage!.state == 1
                            ? Positioned(
                                right: 3,
                                bottom: 3,
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Lottie.asset(
                                        'assets/icons/async.json',
                                        animate:
                                            authViewModel.fileImage!.state == 1
                                                ? true
                                                : false)),
                              )
                            : Positioned(
                                right: 3,
                                bottom: 3,
                                child: Container(),
                              )
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: authViewModel.userModel.image == null
                          ? Image.asset(
                              "assets/images/doraemon.png",
                              width: 160,
                              height: 160,
                              fit: BoxFit.fill,
                              gaplessPlayback: true,
                            )
                          : Image.network(
                              authViewModel.userModel.image.toString(),
                              width: 160,
                              height: 160,
                              fit: BoxFit.fill,
                              gaplessPlayback: true,
                            ),
                    ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            authViewModel.userModel.name.toString(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            authViewModel.userModel.position.toString(),
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 50,
          ),
          AccountButton(
            icon: "assets/icons/Group 5373.svg",
            title: "Tài khoản cá nhân",
            iconRight: "assets/icons/Group 3665.svg",
            onPress: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AccountDetail())),
          ),
          AccountButton(
            icon: "assets/icons/Group 5374.svg",
            title: "Thông báo",
            iconRight: "assets/icons/Group 3665.svg",
            onPress: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccountNotification())),
          ),
          AccountButton(
            icon: "assets/icons/Group 5375.svg",
            title: "Cài đặt chung",
            iconRight: "assets/icons/Group 3665.svg",
            onPress: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            ),
          ),
          AccountButton(
            icon: "assets/icons/Group 5376.svg",
            title: "Điều khoản sử dụng",
            iconRight: "assets/icons/Group 3665.svg",
            onPress: () {},
          ),
          AccountButton(
            icon: "assets/icons/lock-24px.svg",
            title: "Chính sách bảo mật",
            iconRight: "assets/icons/Group 3665.svg",
            onPress: () {},
          ),
          AccountButton(
            icon: "assets/icons/info-24px.svg",
            title: "Hỗ trợ",
            iconRight: "assets/icons/Group 3665.svg",
            onPress: () {},
          ),
          AccountButton(
            icon: "assets/icons/Group 5377.svg",
            title: "Đăng xuất",
            iconRight: "assets/icons/Group 3665.svg",
            onPress: () {
              AuthService().logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                  (route) => false);
            },
          )
        ],
      );
    }
  }
}
