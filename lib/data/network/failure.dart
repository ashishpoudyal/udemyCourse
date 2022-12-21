import 'package:flutter_application_udemy_mvvm/data/network/erro_handler.dart';

class Failure {
  int code;
  String message;
  Failure(this.code, this.message);
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
  
}
