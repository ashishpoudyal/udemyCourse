import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_udemy_mvvm/domain/model/model.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      name = build.brand + "" + build.model;
      identifier = build.id;
      version = build.version.codename;

      //return android
    } else if (Platform.isIOS) {
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name.toString() + "" + build.model.toString();
      identifier = build.identifierForVendor.toString();
      version = build.systemVersion.toString();
    }
  } on PlatformException {
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
