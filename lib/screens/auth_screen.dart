import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/data/data_constants.dart';
import 'package:quiz_u/data/providers/login_provider.dart';
import 'package:quiz_u/screens/export/screens_export.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    LogInProvider provider = Provider.of(context);
    SharedPreferences.getInstance()
        .then((value) => value.getString(AppConstants.keyAccessToken));
    if (provider.state == LogInState.initial) {
      provider.checkToken();
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        ),
      );
    } else if (provider.state == LogInState.error) {
      return LogInScreen();
    } else {
      provider.setState(LogInState.initial);
      return const MainScreen();
    }
  }
}
