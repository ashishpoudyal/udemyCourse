import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_udemy_mvvm/data/mappper/mapper.dart';
import 'package:flutter_application_udemy_mvvm/data/network/failure.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/font_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/style_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/value_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRenderType {
// POPUP STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

//FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,

  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE, //EMPTY VIEW WHEN WE RECIEVE NO DATA FROM API SIDE FOR LIST SCREEN
}

class StateRenderer extends StatelessWidget {
  StateRenderType stateRenderType;

  String message, title;

  Function retryActionFunction;

  StateRenderer(
      {Key? key,
      required this.stateRenderType,
      String? message,
      String? title,
      required this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRenderType) {
      case StateRenderType.POPUP_LOADING_STATE:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRenderType.POPUP_ERROR_STATE:
        return _getPopUpDialog(
          context,
          [
            _getAnimatedImage(JsonAssets.error),
            _getMessage(message),
            _getRetryButton(AppStrings.ok, context),
          ],
        );
      case StateRenderType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);

      case StateRenderType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain, context)
        ]);

      case StateRenderType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRenderType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);

      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: AppSize.s12,
                offset: Offset(0, AppSize.s12))
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style:
              getmediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s100,
          child: ElevatedButton(
            onPressed: () {
              if (stateRenderType == StateRenderType.FULL_SCREEN_ERROR_STATE) {
                retryActionFunction.call();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(buttonTitle),
          ),
        ),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
