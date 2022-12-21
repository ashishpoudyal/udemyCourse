import 'dart:async';

import 'package:flutter_application_udemy_mvvm/presentation/base/baseviewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/onboarding/onboarding.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController = StreamController();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSLiderData();

    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int prevoiusIndex = _currentIndex--;
    if (prevoiusIndex == -1) {
      _currentIndex = _list.length - 1;
    }

    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);
  List<SliderObject> _getSLiderData() => [
        SliderObject(AppStrings.onBoardingSubtitle1,
            AppStrings.onBoardingSubtitle1, ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingSubtitle2,
            AppStrings.onBoardingSubtitle2, ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingSubtitle3,
            AppStrings.onBoardingSubtitle3, ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingSubtitle4,
            AppStrings.onBoardingSubtitle4, ImageAssets.onBoardingLogo4)
      ];
  _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

abstract class OnBoardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
