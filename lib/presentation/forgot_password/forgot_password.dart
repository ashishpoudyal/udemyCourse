import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_udemy_mvvm/app/di.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render_implementer.dart';
import 'package:flutter_application_udemy_mvvm/presentation/forgot_password/forgot_viewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/routes_manager.dart';

import '../resources/value_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  ForgotViewModel _forgotViewModel = instance<ForgotViewModel>();
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _forgotViewModel.start();
    _emailController.addListener(() {
      _forgotViewModel.setEmail(_emailController.text);
    });
  }

  @override
  void initState() {
    _bind();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _forgotViewModel.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _forgotViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _forgotViewModel.forgotPassword();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Image(image: AssetImage(ImageAssets.splashLogo)),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p20, right: AppPadding.p20),
                child: StreamBuilder<bool>(
                    stream: _forgotViewModel.outputIsEmailValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          labelText: "Email",
                          errorText:
                              (snapshot.data ?? true) ? null : "Email is wrong",
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p20, right: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _forgotViewModel.outputIsAllInputEmailValid,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                        onPressed: (snapshot.data ?? true)
                            ? () {
                                _forgotViewModel.forgotPassword();
                              }
                            : null,
                        child: Text("Reset Password"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
