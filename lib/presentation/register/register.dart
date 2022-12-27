import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_udemy_mvvm/app/app_pref.dart';

import 'package:flutter_application_udemy_mvvm/app/di.dart';
import 'package:flutter_application_udemy_mvvm/data/mappper/mapper.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render_implementer.dart';
import 'package:flutter_application_udemy_mvvm/presentation/register/register_viewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/value_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  ImagePicker picker = instance<ImagePicker>();

  final _formKey = GlobalKey<FormState>();
  AppPreferences _appPreferences = instance<AppPreferences>();

  TextEditingController _userNameTextEditingController =
      TextEditingController();

  TextEditingController _mobileNumberTextEditingController =
      TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();
  TextEditingController _countryMobileCodeTextEditingController =
      TextEditingController();
  @override
  void initState() {
    _bind();
    // TODO: implement initState
    super.initState();
  }

  _bind() {
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });
    _emailTextEditingController.addListener(() {
      _viewModel.setEmail(_emailTextEditingController.text);
    });
    _mobileNumberTextEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberTextEditingController.text);
    });
    _countryMobileCodeTextEditingController.addListener(() {
      _viewModel.setCounntryCode(_countryMobileCodeTextEditingController.text);
    });
    _viewModel.isUserRegisteSucessFully.stream.listen((event) {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      // padding: EdgeInsets.only(top: AppPadding.p60),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(
                  image: AssetImage(ImageAssets.splashLogo),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameTextEditingController,
                        decoration: InputDecoration(
                            hintText: "Uername",
                            labelText: "UserName",
                            errorText: snapshot.data),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p20, bottom: AppPadding.p20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              onChanged: (country) {
                                _viewModel
                                    .setCounntryCode(country.dialCode ?? EMPTY);
                              },
                              initialSelection: "+977",
                              hideMainText: true,
                              showCountryOnly: true,
                              showOnlyCountryWhenClosed: true,
                              favorite: ["+977", "+33"],
                            )),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: AppPadding.p20, right: AppPadding.p20),
                            child: StreamBuilder<String?>(
                                stream: _viewModel.outputErrorMobileNumber,
                                builder: (context, snapshot) {
                                  return TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller:
                                        _mobileNumberTextEditingController,
                                    decoration: InputDecoration(
                                        hintText: "Mobile",
                                        labelText: "Mobile",
                                        errorText: snapshot.data),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: AppSize.s28,
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorEmail,
                      builder: (context, snapshot) {
                        return TextFormField(
                          controller: _emailTextEditingController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              labelText: "Email",
                              errorText: snapshot.data),
                        );
                      }),
                ),

                SizedBox(
                  height: AppSize.s12,
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorPassword,
                      builder: (context, snapshot) {
                        return TextFormField(
                          controller: _passwordTextEditingController,
                          decoration: InputDecoration(
                              hintText: "Password",
                              labelText: "Password",
                              errorText: snapshot.data),
                        );
                      }),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),

                Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p20, right: AppPadding.p20),
                    child: Container(
                      height: AppSize.s40,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.lightdrey),
                      ),
                      child: GestureDetector(
                        child: _getMediaWidget(),
                        onTap: () {
                          _showPicker(context);
                        },
                      ),
                    )),

                SizedBox(
                  height: AppSize.s12,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllInputsValid,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                          onPressed: (snapshot.data ?? true)
                              ? () {
                                  _viewModel.register();
                                }
                              : null,
                          child: Text("Register"));
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            AppStrings.alreadyHaveAccount,
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.end,
                          )),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: EdgeInsets.only(
        left: AppPadding.p8,
        right: AppPadding.p8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(AppStrings.profilePic)),
          Flexible(
            child: StreamBuilder<File?>(
              stream: _viewModel.outputIsProfilePictureValid,
              builder: (context, snapshot) {
                return _imagePickedByUser(snapshot.data);
              },
            ),
          ),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc))
        ],
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  leading: Icon(Icons.camera),
                  title: Text(AppStrings.photoGallery),
                  onTap: () {
                    _imageFormGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  leading: Icon(Icons.camera),
                  title: Text(AppStrings.photoCamera),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  _imageFormGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
