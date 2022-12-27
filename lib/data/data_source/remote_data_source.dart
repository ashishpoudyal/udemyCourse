import 'package:flutter_application_udemy_mvvm/data/network/app_api.dart';
import 'package:flutter_application_udemy_mvvm/data/request/request.dart';
import 'package:flutter_application_udemy_mvvm/data/responses/responses.dart';
import 'package:flutter_application_udemy_mvvm/domain/model/model.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHome();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password, "", "");
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      registerRequest.countryMobileCode,
      registerRequest.userName,
      registerRequest.email,
      registerRequest.password,
      registerRequest.profilePicture,
      registerRequest.mobileNumber,
    );
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _appServiceClient.getHome();
  }
}
