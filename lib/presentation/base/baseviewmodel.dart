import 'dart:async';

import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render_implementer.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  StreamController _inputStateStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);
  @override
  void dispose() {
    _inputStateStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
