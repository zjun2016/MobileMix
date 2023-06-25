import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:yhec_flutter/main_page/main_page.dart';
import 'package:yhec_flutter/router/router_map.dart';

void main(){
  ///这里的CustomFlutterBinding调用务必不可缺少，用于控制Boost状态的resume和pause
  CustomFlutterBinding();
  runApp(const MyApp());
}

///创建一个自定义的Binding，继承和with的关系如下，里面什么都不用写
class CustomFlutterBinding extends WidgetsFlutterBinding with BoostFlutterBinding {}

Route<dynamic>? routeFactory(RouteSettings settings, String? uniqueId) {
  debugPrint('【flutter】--------------------settings:$settings -------uniqueId:$uniqueId');
  FlutterBoostRouteFactory? func = routerMap[settings.name];
  if (func == null) {
    return null;
  }
  return func(settings, uniqueId);
}

Widget appBuilder(Widget home) {
  debugPrint('【flutter】--------------------home:$home');
  return MaterialApp(
    home: home,
    debugShowCheckedModeBanner: true,
    ///必须加上builder参数，否则showDialog等会出问题
    builder: (_, __) {
      return home;
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(routeFactory, appBuilder: appBuilder,);
  }
}
