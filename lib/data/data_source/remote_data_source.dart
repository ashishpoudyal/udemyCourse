import 'package:flutter_application_udemy_mvvm/data/network/app_api.dart';
import 'package:flutter_application_udemy_mvvm/data/request/request.dart';
import 'package:flutter_application_udemy_mvvm/data/responses/responses.dart';
import 'package:flutter_application_udemy_mvvm/domain/model/model.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password, "", "");
  }
}
