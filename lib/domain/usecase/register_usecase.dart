import 'package:flutter_application_udemy_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_udemy_mvvm/data/request/request.dart';
import 'package:flutter_application_udemy_mvvm/domain/model/model.dart';
import 'package:flutter_application_udemy_mvvm/domain/repository/repository.dart';
import 'package:flutter_application_udemy_mvvm/domain/usecase/base_usecase.dart';

import '../../app/functions.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
      input.countryMobileCode,
      input.userName,
      input.email,
      input.password,
      input.mobileNumber,
      input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobileNumber;

  String profilePicture;
  RegisterUseCaseInput(
    this.countryMobileCode,
    this.userName,
    this.email,
    this.password,
    this.mobileNumber,
    this.profilePicture,
  );
}
