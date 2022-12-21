import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_udemy_mvvm/app/app.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);
  void updateAppState() {
    MyApp.instance.appState = 0;
  }

  void setAppState() {
    print(MyApp.instance.appState);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
