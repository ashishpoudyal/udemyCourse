import 'package:dartz/dartz.dart';

import 'package:flutter_application_udemy_mvvm/domain/model/model.dart';

import '../../data/network/failure.dart';
import '../../data/request/request.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
