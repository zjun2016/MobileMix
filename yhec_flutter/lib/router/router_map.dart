import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:yhec_flutter/login/login.dart';
import '../dialog/dialog_page.dart';
import '../lifecycle/lifecycle_test_page.dart';
import '../main_page/main_page.dart';


Map<String, FlutterBoostRouteFactory> routerMap = {
  'mainPage': (settings, uniqueId) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          Map<String, dynamic> map = (settings.arguments ?? {}) as Map<String, dynamic>;
          String data = map['data'] ?? '';
          return MainPage(
            data: data
          );
        });
  },
  'loginPage': (settings, uniqueId) {
    Map<String, dynamic> map = (settings.arguments ?? {}) as Map<String, dynamic>;
    // String data = map['data'] ?? '';
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const LoginPage(),
    );
  },
  ///生命周期例子页面
  'lifecyclePage': (settings, uniqueId) {
    return MaterialPageRoute(
        settings: settings,
        builder: (ctx) {
          return const LifecycleTestPage();
        });
  },
  ///透明弹窗页面
  'dialogPage': (settings, uniqueId) {
    return PageRouteBuilder<dynamic>(
      ///透明弹窗页面这个需要是false
        opaque: false,
        ///背景蒙版颜色
        barrierColor: Colors.black12,
        settings: settings,
        pageBuilder: (_, __, ___) => const DialogPage());
  },
};