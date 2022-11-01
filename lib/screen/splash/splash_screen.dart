import 'dart:async';

import 'package:app_cham_cong_option_2/components/custom_snackBarError.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/screen/home_page.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // getValidationData().whenComplete(() async {
    //var d = const Duration(seconds: 2);
    //delayed 3 seconds to next page
    // Timer(d, () {
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) => const LoginScreen()),
    //       (route) => false);
    // });

    _loadUserinfo();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    //final userProvider = Provider.of<Auth>(context,listen: false);
    super.didChangeDependencies();
  }

  void _loadUserinfo() async {
    // final userProvider = Provider.of<Auth>(context, listen: false);
    String token = await AuthService().getToken();
    if (token == '') {
      var d = const Duration(seconds: 1);
      //delayed 3 seconds to next page
      Timer(d, () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      });
    } else {
      // var response = await AuthService().getUserDetail();
      var d = const Duration(seconds: 1);
      // //delayed 3 seconds to next page
      // if (response.error == null) {
      //   Timer(d, () {
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => const HomePage()),
      //         (route) => false);
      //   });
      // } else if (response.error == Config.unauthorized) {
      //   Timer(d, () {
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => const LoginScreen()),
      //         (route) => false);
      //   });
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       duration: const Duration(seconds: 3),
      //       behavior: SnackBarBehavior.floating,
      //       backgroundColor: Colors.transparent,
      //       elevation: 0,
      //       content: CustomSnackBarError(
      //         error: response.error!,
      //       )));
      // }
      Timer(d, () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            "assets/images/logo_splash.png",
            width: 300,
          ),
        ),
      ),
    );
  }
}
