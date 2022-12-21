import 'package:dio/dio.dart';
import 'package:flutter_application_udemy_mvvm/data/network/failure.dart';

enum DataSource {
  SUCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();

      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();

      case DioErrorType.receiveTimeout:
        return DataSource.RECIEVE_TIMEOUT.getFailure();

      case DioErrorType.response:
        switch (error.response!.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();

          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }

      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();

      case DioErrorType.other:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);

      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);

      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);

      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIEVE_TIMEOUT, ResponseMessage.RECEIEVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);

      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);

      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 403;
  static const int UNAUTHORIZED = 401;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;

  //local status code
  static const int DEFAULT = -1;

  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIEVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  static const String SUCESS = "Sucess";
  static const String NO_CONTENT = "sucess with no content";
  static const String BAD_REQUEST = "Bad request , try again later";
  static const String FORBIDDEN = "Forbidden request , try again later";
  static const String UNAUTHORIZED = "User is unauthorised try again later";
  static const String NOT_FOUND = "Url is not found , try again later";
  static const String INTERNAL_SERVER_ERROR =
      "some thing went wrong, try again later";

  //local status code
  static const String DEFAULT = "some thing went wrong, try again later";

  static const String CONNECT_TIMEOUT = "Time out error, try again later";
  static const String CANCEL = "request was cancelled ,try again later";
  static const String RECEIEVE_TIMEOUT = "Time out error, try again later";
  static const String SEND_TIMEOUT = "Time out error, try again later";
  static const String CACHE_ERROR = "Cache  error, try again later";
  static const String NO_INTERNET_CONNECTION =
      "please check your internet connection";
}

class ApiInternalStatus {
  static const int SUCESS = 0;
  static const int FAILURE = 1;
}
