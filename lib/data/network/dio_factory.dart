import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_udemy_mvvm/app/app_pref.dart';
import 'package:flutter_application_udemy_mvvm/app/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeOut = 60 * 1000; //1min
    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      AUTHORIATION: Constant.token,
      DEFAULT_LANGUAGE: language,
    };
    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: _timeOut,
        receiveTimeout: _timeOut,
        headers: headers);
    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
