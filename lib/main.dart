// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_application_udemy_mvvm/app/app.dart';
import 'package:flutter_application_udemy_mvvm/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
