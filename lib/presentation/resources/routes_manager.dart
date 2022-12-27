import 'package:flutter/material.dart';
import 'package:flutter_application_udemy_mvvm/app/di.dart';
import 'package:flutter_application_udemy_mvvm/presentation/forgot_password/forgot_password.dart';
import 'package:flutter_application_udemy_mvvm/presentation/login/login.dart';
import 'package:flutter_application_udemy_mvvm/presentation/main/main_view.dart';
import 'package:flutter_application_udemy_mvvm/presentation/onboarding/onboarding.dart';
import 'package:flutter_application_udemy_mvvm/presentation/register/register.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/splash/splash.dart';
import 'package:flutter_application_udemy_mvvm/presentation/store_details/store_details.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => SplashView(),
        );

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
          builder: (_) => LoginView(),
        );

      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (_) => OnBoardingView(),
        );

      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(
          builder: (_) => RegisterView(),
        );

      case Routes.forgetPasswordRoute:
        initForgotModule();
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordView(),
        );

      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(
          builder: (_) => MainView(),
        );
      case Routes.storeDetailRoute:
        return MaterialPageRoute(
          builder: (_) => StoreDetailsView(),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
