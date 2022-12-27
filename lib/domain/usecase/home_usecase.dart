import 'dart:ffi';

import 'package:flutter_application_udemy_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_udemy_mvvm/domain/repository/repository.dart';
import 'package:flutter_application_udemy_mvvm/domain/usecase/base_usecase.dart';

import '../model/model.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}
