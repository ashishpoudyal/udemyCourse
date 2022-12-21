import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_udemy_mvvm/app/app_pref.dart';
import 'package:flutter_application_udemy_mvvm/app/di.dart';
import 'package:flutter_application_udemy_mvvm/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/value_manager.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _pageController = PageController(initialPage: 0);
  OnBoardingViewModel _viewModel = OnBoardingViewModel();
  AppPreferences _appPreferences = instance<AppPreferences>();
  _bind() {
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
                _viewModel.goPrevious();
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowSvg),
              ),
            ),
          ),

//circle indicator
          Row(children: [
            for (int i = 0; i < sliderViewObject.numOfSlides; i++)
              Padding(
                  padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex)),
          ]),

          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _viewModel.goNext();
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowSvg),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s1_5,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject.numOfSlides,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(sliderViewObject.sliderObject);
          },
        ),
        backgroundColor: ColorManager.white,
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      child: Text(
                        AppStrings.skip,
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.end,
                      ))),
              _getBottomSheetWidget(sliderViewObject),
            ],
          ),
        ),
      );
  }

  _getProperCircle(int index, int _currentIndex) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircle);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircle);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;
  OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSize.s60,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1),
        ),
        SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}

class SliderObject {
  String title, subTitle, image;
  SliderObject(this.title, this.subTitle, this.image);
}
