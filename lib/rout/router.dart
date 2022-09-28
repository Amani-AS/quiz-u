import 'package:flutter/material.dart';
import 'package:quiz_u/screens/auth_screen.dart';
import 'package:quiz_u/screens/login_screen.dart';
import 'package:quiz_u/rout/rout_names_constant.dart';
import 'package:quiz_u/screens/export/screens_export.dart';
import 'package:quiz_u/screens/questions_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /*ase splash:
        return MaterialPageRoute(builder: (_) => const NavScreen());*/

      case logIn:
        return MaterialPageRoute(builder: (_) => LogInScreen());
      case otp:
        return MaterialPageRoute(builder: (_) => OTPScreen());
      case addName:
        return MaterialPageRoute(builder: (_) => AddNameScreen());
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case questions:
        return MaterialPageRoute(builder: (_) => const QuestionsScreen());
      case fail:
        return MaterialPageRoute(builder: (_) => const FailScreen());
      case getScore:
        return MaterialPageRoute(builder: (_) => const GetScoreScreen());
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case onBoard:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
