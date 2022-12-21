import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_udemy_mvvm/app/app_pref.dart';
import 'package:flutter_application_udemy_mvvm/app/di.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render_implementer.dart';
import 'package:flutter_application_udemy_mvvm/presentation/login/login_viewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/value_manager.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = instance<LoginViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  TextEditingController _userNameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isSucessLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
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
    _viewModel.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(ImageAssets.loginIc),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsUserNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: "Uername",
                            labelText: "UserName",
                            errorText: (snapshot.data ?? true)
                                ? null
                                : "UserName is wrong",
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            errorText: (snapshot.data ?? true)
                                ? null
                                : "Password is wrong",
                          ),
                        );
                      }),
                ),

SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllInputValid,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                          onPressed: (snapshot.data ?? true)
                              ? () {
                                  _viewModel.login();
                                }
                              : null,
                          child: Text("Login"));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p20,
                    right: AppPadding.p20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.forgetPasswordRoute);
                          },
                          child: Text(
                            AppStrings.forgot,
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.end,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.registerRoute);
                          },
                          child: Text(
                            AppStrings.registerText,
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.end,
                          ))
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
