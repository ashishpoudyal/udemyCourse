import 'package:flutter/material.dart';
import 'package:flutter_application_udemy_mvvm/data/mappper/mapper.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRenderType getStateRenderType();
  String getMessage();
}

//Loading State(POPUP,FULL SCREEN)
class LoadingState extends FlowState {
  StateRenderType stateRenderType;
  String message;
  LoadingState({required this.stateRenderType, String? message})
      : message = message ?? AppStrings.loading;
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRenderType getStateRenderType() {
    return stateRenderType;
  }
}

//error state(POPUP ,FULL LOADING)

class ErrorState extends FlowState {
  StateRenderType stateRenderType;
  String message;
  ErrorState(this.stateRenderType, this.message);

  @override
  String getMessage() {
    return message;
  }

  @override
  StateRenderType getStateRenderType() {
    return stateRenderType;
  }
}

//content state(POPUP ,FULL LOADING)

class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() {
    return EMPTY;
  }

  @override
  StateRenderType getStateRenderType() {
    return StateRenderType.CONTENT_SCREEN_STATE;
  }
}
//empty state(POPUP ,FULL LOADING)

class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRenderType getStateRenderType() {
    return StateRenderType.EMPTY_SCREEN_STATE;
  }
}

//Sucess State
class SucessState extends FlowState {
  String message;
  SucessState(this.message);
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRenderType getStateRenderType() {
    return StateRenderType.POPUP_SUCESS_STATE;
  }
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRenderType() == StateRenderType.POPUP_LOADING_STATE) {
            //showing popup dialog
            showPopUp(context, getStateRenderType(), getMessage(), "");
            //return the content ui of the screen

            return contentScreenWidget;
          } else //StateRenderType.FULL_SCREEN_LOADING_STATE

          {
            return StateRenderer(
              stateRenderType: getStateRenderType(),
              retryActionFunction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRenderType() == StateRenderType.POPUP_ERROR_STATE) {
            //showing popup dialog
            showPopUp(context, getStateRenderType(), getMessage(), "");
            //return the content ui of the screen

            return contentScreenWidget;
          } else // StateRenderType.FULL_SCREEN_ERROR_STATE

          {
            return StateRenderer(
              stateRenderType: getStateRenderType(),
              retryActionFunction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRenderType: getStateRenderType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      case SucessState:
        {
          dismissDialog(context);

          showPopUp(context, StateRenderType.POPUP_SUCESS_STATE, getMessage(),
              AppStrings.title);
          return contentScreenWidget;
        }
      default:
        {
          return Container();
        }
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
  showPopUp(BuildContext context, StateRenderType stateRenderType,
      String message, String? title) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
              stateRenderType: stateRenderType,
              message: message,
              title: title,
              retryActionFunction: () {},
            )));
  }
}
