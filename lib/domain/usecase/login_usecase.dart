import 'package:flutter_application_udemy_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_udemy_mvvm/data/request/request.dart';
import 'package:flutter_application_udemy_mvvm/domain/model/model.dart';
import 'package:flutter_application_udemy_mvvm/domain/repository/repository.dart';
import 'package:flutter_application_udemy_mvvm/domain/usecase/base_usecase.dart';

import '../../app/functions.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(
        input.email, input.password, deviceInfo.name, deviceInfo.identifier));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
