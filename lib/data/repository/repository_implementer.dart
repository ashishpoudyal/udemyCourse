import 'package:flutter_application_udemy_mvvm/data/data_source/remote_data_source.dart';
import 'package:flutter_application_udemy_mvvm/data/mappper/mapper.dart';
import 'package:flutter_application_udemy_mvvm/data/network/erro_handler.dart';
import 'package:flutter_application_udemy_mvvm/data/network/network_info.dart';
import 'package:flutter_application_udemy_mvvm/domain/model/model.dart';
import 'package:flutter_application_udemy_mvvm/data/request/request.dart';
import 'package:flutter_application_udemy_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_udemy_mvvm/domain/repository/repository.dart';

class RepositoryImplementer extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;
  RepositoryImplementer(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
//its safe to call the api
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left((ErrorHandler.handle(error).failure));
      }
    } else {
//return connection error
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);
        if (response.status == ApiInternalStatus.SUCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
//its safe to call the api
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.SUCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left((ErrorHandler.handle(error).failure));
      }
    } else {
//return connection error
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }
  
  @override
  Future<Either<Failure, HomeObject>> getHome()async {
     
    if (await _networkInfo.isConnected) {
//its safe to call the api
      try {
        final response = await _remoteDataSource.getHome();
        if (response.status == ApiInternalStatus.SUCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left((ErrorHandler.handle(error).failure));
      }
    } else {
//return connection error
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }
}
