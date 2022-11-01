import 'dart:async';

import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:app_cham_cong_option_2/data/view_models/login_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Timer? _timer;
  bool isHiddenPassword = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // void _saveAndRedirectToHome(UserModel user) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.setString("token", user.token ?? '');
  //   await pref.setInt('userId', user.id ?? 0);
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => const HomePage()),
  //       (route) => false);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = context.watch<LoginViewModel>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: _formKey,
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
                        child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailController,
                      validator: (value) {
                        // if (RegExp(emailRegex).hasMatch(value!)) {

                        // } else if (value == null || value.isEmpty) {
                        //   return "Vui lòng nhập email";
                        // } else {
                        //   return "Định dạng email không đúng !";
                        // }
                        if (value!.trim() == null || value.trim().isEmpty) {
                          return "Vui lòng nhập email";
                        } else if (value != null &&
                            !EmailValidator.validate(value)) {
                          return "Vui lòng nhập email hợp lệ !";
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          decoration: TextDecoration.none),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mật khẩu",
                      style: TextStyle(fontFamily: "Kufam", fontSize: 22),
                    ),
                    SizedBox(
                        child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passController,
                      obscureText: isHiddenPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập mật khẩu";
                        } else if (value.length < 6) {
                          return "Mật khẩu phải chứa tối thiểu 6 ký tự";
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          decoration: TextDecoration.none),
                      decoration: InputDecoration(
                          // contentPadding: const EdgeInsets.symmetric(
                          //   vertical: 0,
                          // ),
                          // border: new OutlineInputBorder(
                          //   borderRadius: new BorderRadius.circular(25.0),
                          //   borderSide: new BorderSide(),
                          // ),
                          suffixIcon: InkWell(
                        onTap: () => _togglePasswordView(),
                        child: const Icon(Icons.visibility),
                      )),
                    ))
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
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              // Provider.of<Auth>(context, listen: false).login(
                              //     _emailController.text,
                              //     _passController.text);
                              _timer?.cancel();
                              await EasyLoading.show(
                                status: 'loading...',
                                maskType: EasyLoadingMaskType.black,
                              );
                              loginViewModel
                                  .loginUser(
                                      context,
                                      _emailController.text.trim(),
                                      _passController.text.trim())
                                  .whenComplete(() {
                                EasyLoading.dismiss();
                              });
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const HomePage()));
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: ((context) =>
                //                     const RegisterScreen())));
                //       },
                //       child: const Text(
                //         "Đăng kí tài khoản ",
                //         style: TextStyle(fontSize: 12),
                //       ),
                //     ),
                //   ],
                // ),
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
