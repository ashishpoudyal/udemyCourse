import 'dart:async';

import 'package:flutter_application_udemy_mvvm/domain/usecase/login_usecase.dart';
import 'package:flutter_application_udemy_mvvm/presentation/base/baseviewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render_implementer.dart';

import '../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginVIewModelOutputs, LoginVIewModelOutputs {
  StreamController _userNamStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _isALlInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();
  var loginObject = LoginObject("", "");

  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);
  @override
  void dispose() {
    _isALlInputsValidStreamController.close();
    _userNamStreamController.close();
    _passwordStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;
  Sink get inputUserName => _userNamStreamController.sink;
  Sink get inputIsAllInputValid => _isALlInputsValidStreamController.sink;
  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid => _userNamStreamController.stream
      .map((userName) => _isUserNameValid(userName));
  @override
  // TODO: implement outputIsAllInputValid
  Stream<bool> get outputIsAllInputValid =>
      _isALlInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  _validate() {
    inputIsAllInputValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  @override
  setPassword(String password) {
    inputUserName.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  login() async {
    inputState.add(
        LoadingState(stateRenderType: StateRenderType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
      LoginUseCaseInput(loginObject.userName, loginObject.password),
    ))
        .fold(
      (failure) => {
        inputState.add(
            ErrorState(StateRenderType.POPUP_ERROR_STATE, failure.message)),
        // print(failure.message),
      },
      (data) {
        // print(data.customer?.name),
        inputState.add(ContentState());
        isUserLoggedInSuccessfullyStreamController.add(true);
      },
    );
  }

  _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }
}

abstract class LoginViewModelInputs {
  //three function

  setUserName(String userName);
  setPassword(String password);
  login();

  //two sinks

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputValid;
}

abstract class LoginVIewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputValid;
}
