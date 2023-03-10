import 'dart:async';
import 'dart:io';

import 'package:flutter_application_udemy_mvvm/app/functions.dart';
import 'package:flutter_application_udemy_mvvm/domain/usecase/register_usecase.dart';
import 'package:flutter_application_udemy_mvvm/presentation/base/baseviewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render_implementer.dart';

import '../common/state_render/state_render.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();

  StreamController _emailStreamController =
      StreamController<String>.broadcast();

  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();

  StreamController _isAllInputValidStreamController =
      StreamController<bool>.broadcast();
  StreamController isUserRegisteSucessFully =
      StreamController<void>.broadcast();
  RegisterUseCase _registerUseCase;
  var registerViewObject = RegisterObject("", "", "", "", "", "");
  RegisterViewModel(this._registerUseCase);
//- inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _emailStreamController.close();
    _mobileNumberStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputValidStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;
  @override
  Sink get inpuAllInputValid => _isAllInputValidStreamController.sink;

//--outputs
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));
  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserNameValid) => isUserNameValid ? null : "Invalid username");

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "Invalid email format");

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : "Invalid Mobile Number");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid password ");

  @override
  Stream<File> get outputIsProfilePictureValid =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputValidStreamController.stream.map((_) => _validateAllInputs());

  @override
  register() async {
    inputState.add(
        LoadingState(stateRenderType: StateRenderType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
        registerViewObject.countryMobileCode,
        registerViewObject.userName,
        registerViewObject.email,
        registerViewObject.password,
        registerViewObject.mobileNumber,
        registerViewObject.profilePicture,
      ),
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
        isUserRegisteSucessFully.add(true);
      },
    );
  }

  //private method
  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isMobileValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _validateAllInputs() {
    return registerViewObject.profilePicture.isNotEmpty &&
        registerViewObject.mobileNumber.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.email.isNotEmpty &&
        registerViewObject.profilePicture.isNotEmpty &&
        registerViewObject.countryMobileCode.isNotEmpty;
  }

  _validate() {
    inpuAllInputValid.add(null);
  }

  @override
  setCounntryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerViewObject =
          registerViewObject.copyWith(countryMobileCode: countryCode);
    } else {
      registerViewObject = registerViewObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerViewObject = registerViewObject.copyWith(email: email);
    } else {
      registerViewObject = registerViewObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileValid(mobileNumber)) {
      registerViewObject =
          registerViewObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerViewObject = registerViewObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerViewObject = registerViewObject.copyWith(password: password);
    } else {
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputProfilePicture.add(file);
    if (file.path.isNotEmpty) {
      registerViewObject =
          registerViewObject.copyWith(profilePicture: file.path);
    } else {
      registerViewObject = registerViewObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registerViewObject = registerViewObject.copyWith(userName: userName);
    } else {
      registerViewObject = registerViewObject.copyWith(userName: "");
    }
    _validate();
  }
}

abstract class RegisterViewModelInput {
  register();
  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCounntryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File file);

  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inpuAllInputValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;
  Stream<bool> get outputIsAllInputsValid;
}
