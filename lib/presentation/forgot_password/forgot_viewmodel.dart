import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_udemy_mvvm/data/network/failure.dart';
import 'package:flutter_application_udemy_mvvm/presentation/base/baseviewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render_implementer.dart';

import '../../domain/usecase/forgot_usecase.dart';

class ForgotViewModel extends BaseViewModel
    with ForgotModelInputs, ForgotModelOutputs {
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();
  StreamController isResetPasswordSucessfullyStreamController =
      StreamController<bool>();
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotViewModel(this._forgotPasswordUseCase);
  var email = "";
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRenderType: StateRenderType.POPUP_LOADING_STATE));

    (await _forgotPasswordUseCase.execute(email)).fold(
        (failure) => inputState.add(
            ErrorState(StateRenderType.POPUP_ERROR_STATE, failure.message)),
        (supportMessage) => {
              inputState.add(SucessState(supportMessage)),
              isResetPasswordSucessfullyStreamController.add(true),
            });
  }

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Sink get inputEmail => _emailStreamController.sink;
  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }

  _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  _isAllinputValid() {
    return _isEmailValid(email);
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
    isResetPasswordSucessfullyStreamController.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  // TODO: implement outputIsAllInputEmailValid
  Stream<bool> get outputIsAllInputEmailValid =>
      _isAllInputValidStreamController.stream
          .map((isAllInputValid) => _isAllinputValid());
}

abstract class ForgotModelInputs {
  forgotPassword();
  setEmail(String email);
  Sink get inputEmail;
  Sink get inputIsAllInputValid;
}

abstract class ForgotModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputEmailValid;
}
