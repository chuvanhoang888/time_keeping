// import 'dart:convert';

// import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
// import 'package:app_cham_cong_option_2/data/service/web_api/dio.dart';
// import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
// import 'package:dio/dio.dart' as Dio;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Auth extends ChangeNotifier {
//   bool _isLoggedIn = true;

//   UserModel? _userModel;
//   String? _token;

//   bool get authenticated => _isLoggedIn;
//   UserModel get user => _userModel!;

//   set setAuthenticated(bool val) {
//     _isLoggedIn = val;
//     notifyListeners();
//   }

//   Future<void> login(String email, password) async {
//     final data = {'email': email, 'password': password};

//     Dio.Response response;
//     //bool tokenExist = await getToken();
//     try {
//       response = await dio().post(
//         Config.loginURL,
//         data: data,
//       );
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.data);

//         saveToken(data['token']);
//         _userModel = UserModel.fromJson(data['user']);
//         //getUser(token: data['token']);
//         _isLoggedIn = true;
//       } else {
//         _isLoggedIn = false;
//       }
//       notifyListeners();
//     } catch (e) {
//       throw Exception('Failed to login');
//     }
//   }

//   Future<void> registerUser(String name, email, password) async {
//     final data = {
//       'name': name,
//       'email': email,
//       'password': password,
//       'password_confirmation': password
//     };

//     Dio.Response response;
//     //bool tokenExist = await getToken();
//     try {
//       response = await dio().post(
//         Config.registerURL,
//         data: data,
//       );
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.data);

//         saveToken(data['token']);
//         _userModel = UserModel.fromJson(data['user']);
//         //getUser(token: data['token']);
//         _isLoggedIn = true;
//       } else {
//         _isLoggedIn = false;
//       }
//       notifyListeners();
//     } catch (e) {
//       throw Exception('Failed to register User');
//     }
//   }

//   //get token
//   Future<String> getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token') ?? '';
//   }

//   //get user id
//   Future<int> getUserId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getInt('userId') ?? 0;
//   }

//   //get user detail
//   Future<UserModel> getUserDetail() async {
//     Dio.Response response;
//     //bool tokenExist = await getToken();
//     try {
//       String token = await getToken();

//       response = await dio().get(Config.userURL,
//           options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.data);

//         _userModel = UserModel.fromJson(data['user']);
//         //getUser(token: data['token']);
//         _isLoggedIn = true;
//       } else {
//         _isLoggedIn = false;
//       }
//       notifyListeners();
//     } catch (e) {
//       throw Exception('Failed to get User detail');
//     }
//     return _userModel!;
//   }

//   Future<void> saveToken(String token) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('token');
//     prefs.setString('token', token);
//   }

//   Future<bool> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return await prefs.remove('token');
//   }

//   // Future<void> getUser({required String token}) async {
//   //   if (token == null) {
//   //     return;
//   //   } else {
//   //     try {
//   //       Dio.Response reponse = await dio().get(Config.getUser,
//   //           options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
//   //       _isLoggedIn = true;
//   //       _token = token;
//   //       _userModel = UserModel.fromJson(reponse.data);
//   //       notifyListeners();
//   //     } catch (e) {
//   //       print(e);
//   //     }
//   //   }
//   //}

//   // Future<bool> getToken() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   var token = prefs.getString('access_token');
//   //   if (token != null) {
//   //     //_api.token = token;
//   //     return true;
//   //   } else {
//   //     return false;
//   //   }
//   // }

//   // Future<void> logOut() async {
//   //   try {
//   //     Dio.Response response = await dio().get(Config.userRevoke,
//   //         options: Dio.Options(headers: {'Authorization': 'Barrer $_token'}));
//   //     cleanUp();
//   //     notifyListeners();
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }

//   // void cleanUp() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   _isLoggedIn = false;
//   //   _userModel = null;
//   //   _token = null;
//   //   prefs.remove('access_token');
//   // }
// }
