import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_udemy_mvvm/presentation/main/home/home_page.dart';
import 'package:flutter_application_udemy_mvvm/presentation/main/notifications_page.dart';
import 'package:flutter_application_udemy_mvvm/presentation/main/search_page.dart';
import 'package:flutter_application_udemy_mvvm/presentation/main/settings_page.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/value_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage()
  ];
  List<String> title = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.settings,
  ];
  var _title = AppStrings.home;
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: Theme.of(context).textTheme.headline2),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: ColorManager.black,
            blurRadius: AppSize.s1_5,
          )
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: AppStrings.home),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: AppStrings.search),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                ),
                label: AppStrings.notification),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: AppStrings.settings)
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = title[index];
    });
  }
}
