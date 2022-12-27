import 'dart:async';
import 'dart:ffi';

import 'package:flutter_application_udemy_mvvm/domain/model/model.dart';
import 'package:flutter_application_udemy_mvvm/domain/usecase/home_usecase.dart';
import 'package:flutter_application_udemy_mvvm/presentation/base/baseviewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render_implementer.dart';
import 'package:rxdart/subjects.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;

  StreamController _bannerStreamController = BehaviorSubject<List<BannerAd>>();
  StreamController _serviceStreamController = BehaviorSubject<List<Service>>();
  StreamController _storeStreamController = BehaviorSubject<List<Store>>();

  HomeViewModel(this._homeUseCase);
  @override
  void start() {
    _getHome();
    super.start();
  }

  _getHome() async {
    inputState.add(LoadingState(
        stateRenderType: StateRenderType.FULL_SCREEN_LOADING_STATE));

    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(
          ErrorState(StateRenderType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputBanners.add(homeObject.data.banners);
      inputServices.add(homeObject.data.services);
      inputStores.add(homeObject.data.stores);
    });
  }

  @override
  void dispose() {
    _bannerStreamController.close();
    _serviceStreamController.close();
    _storeStreamController.close();

    super.dispose();
  }

  @override
  Sink get inputBanners => _bannerStreamController.sink;

  @override
  Sink get inputServices => _serviceStreamController.sink;

  @override
  Sink get inputStores => _storeStreamController.sink;

  //outputs

  @override
  Stream<List<BannerAd>> get outputBanners =>
      _bannerStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>
      _serviceStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      _storeStreamController.stream.map((stores) => stores);
}

abstract class HomeViewModelInputs {
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract class HomeViewModelOutputs {
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<BannerAd>> get outputBanners;
}
