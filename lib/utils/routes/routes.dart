import 'package:flutter/material.dart';
import 'package:social_media_app/utils/routes/route_name.dart';
import 'package:social_media_app/view/dashboard/dashboard_screen.dart';
import 'package:social_media_app/view/forgot_password/forgot_password.dart';
import 'package:social_media_app/view/login/login_screen.dart';
import 'package:social_media_app/view/signup/sign_up_screen.dart';
import 'package:social_media_app/view/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginView:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.signupView:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.dashBooardScreen:
        return MaterialPageRoute(builder: (_) => const DashBoardScreen());
      case RouteName.forgotScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
