import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/screen/home/home_screen.dart';
import 'package:app_cham_cong_option_2/screen/home_page.dart';
import 'package:app_cham_cong_option_2/screen/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc = LoginBloc();
  bool isHiddenPassword = true;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 0,
        //Phải có cái này mới dùng được SystemUiOverlayStyle
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Đăng nhập",
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(fontFamily: "Kufam", fontSize: 22),
                    ),
                    SizedBox(
                        height: 31,
                        child: StreamBuilder(
                            stream: loginBloc.userStream,
                            builder: (context, snapshot) {
                              return TextField(
                                controller: _userController,
                                style: const TextStyle(
                                    color: kTextLightColor,
                                    fontSize: 16,
                                    decoration: TextDecoration.none),
                                decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                ),
                              );
                            }))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mật khẩu",
                      style: TextStyle(fontFamily: "Kufam", fontSize: 22),
                    ),
                    SizedBox(
                      height: 31,
                      child: StreamBuilder(
                          stream: loginBloc.passStream,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: _passController,
                              obscureText: isHiddenPassword,
                              style: const TextStyle(
                                  color: kTextLightColor,
                                  fontSize: 16,
                                  decoration: TextDecoration.none),
                              decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  //contentPadding: EdgeInsets.all(20),
                                  suffixIcon: InkWell(
                                    onTap: () => _togglePasswordView(),
                                    child: const Icon(Icons.visibility),
                                  )),
                            );
                          }),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Quên mật khẩu",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width - 100,
                      child: DefaultButton(
                        title: "Đăng nhập",
                        press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage())),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "Đăng kí tài khoản ",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }
}
