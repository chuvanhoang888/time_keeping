import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/view_models/account_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/auth_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/comment_reply_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/comments_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/login_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/notification_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/permission_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/post_user_tag_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/posts_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_comment_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_image_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_todo_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_user_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_view_model.dart';
import 'package:app_cham_cong_option_2/provider/gallery_provider.dart';
import 'package:app_cham_cong_option_2/provider/images_new_dts_provide.dart';
import 'package:app_cham_cong_option_2/provider/theme_provider.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/post_detail_screen.dart';
import 'package:app_cham_cong_option_2/screen/home_page.dart';
import 'package:app_cham_cong_option_2/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  initializeDateFormatting().then((_) => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => GalleryProvider()),
        ChangeNotifierProvider(create: (context) => ImagesProviderDts()),
        ChangeNotifierProvider(create: (context) => PostsViewModel(context)),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => CommentsViewModel()),
        ChangeNotifierProvider(create: (context) => CommentReplyViewModel()),
        ChangeNotifierProvider(create: (context) => AuthViewModel(context)),
        ChangeNotifierProvider(
            create: (context) => NotificationViewModel(context)),
        ChangeNotifierProvider(
            create: (context) => PermissionViewModel(context)),
        ChangeNotifierProvider(create: (context) => WorkViewModel(context)),
        ChangeNotifierProvider(create: (context) => WorkTodoViewModel()),
        ChangeNotifierProvider(create: (context) => WorkUserViewModel(context)),
        ChangeNotifierProvider(create: (context) => WorkCommentsViewModel()),
        ChangeNotifierProvider(create: (context) => WorkImageViewModel()),
        ChangeNotifierProvider(
            create: (context) => PostUserTagViewModel(context)),
        ChangeNotifierProvider(create: (context) => AccountViewModel()),
      ], child: const MyApp())));
  // ignore: prefer_const_constructors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));

  // AssetPicker.registerObserve();
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = kBackgroundColor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = kBackgroundColor
    ..userInteractions = true
    //..loadingStyle = EasyLoadingStyle.custom
    ..dismissOnTap = false;

  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getCurrentAppTheme() async {
    final themeProvider = ThemeProvider();
    final mode = await themeProvider.themeSharePreferences.getTheme();
    themeProvider.themeMode = mode;
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
