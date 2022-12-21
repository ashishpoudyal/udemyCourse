import 'package:flutter/material.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/routes_manager.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key);
  MyApp._internal();
  static final MyApp instance = MyApp._internal();
  int appState = 0;
  factory MyApp() => instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
