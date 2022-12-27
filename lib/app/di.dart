import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_udemy_mvvm/app/app_pref.dart';
import 'package:flutter_application_udemy_mvvm/data/data_source/remote_data_source.dart';
import 'package:flutter_application_udemy_mvvm/data/network/app_api.dart';
import 'package:flutter_application_udemy_mvvm/data/network/dio_factory.dart';
import 'package:flutter_application_udemy_mvvm/data/network/network_info.dart';
import 'package:flutter_application_udemy_mvvm/data/repository/repository_implementer.dart';
import 'package:flutter_application_udemy_mvvm/domain/repository/repository.dart';
import 'package:flutter_application_udemy_mvvm/domain/usecase/forgot_usecase.dart';
import 'package:flutter_application_udemy_mvvm/domain/usecase/home_usecase.dart';
import 'package:flutter_application_udemy_mvvm/domain/usecase/login_usecase.dart';
import 'package:flutter_application_udemy_mvvm/domain/usecase/register_usecase.dart';
import 'package:flutter_application_udemy_mvvm/presentation/forgot_password/forgot_viewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/login/login_viewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/main/home/home_viewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/register/register_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreference = await SharedPreferences.getInstance();

  //shared pred instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreference);

//app pref instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementer(DataConnectionChecker()));

  //dio factory

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

// repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImplementer(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance
        .registerFactory<ForgotViewModel>(() => ForgotViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
         instance.registerFactory<ImagePicker>(
        () => ImagePicker());
  }
}
initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance
        .registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(
        () => HomeViewModel(instance()));
       
  }
}
