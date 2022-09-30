import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz_u/data/providers/login_provider.dart';
import 'package:quiz_u/screens/export/screens_export.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogInProvider provider = Provider.of(context);

    return FutureBuilder(
        future: provider.checkToken(),
        builder: (constant, snapShot) {
          if (snapShot.hasError) {
            return LogInScreen();
          } else {

            return const MainScreen();
          }
        });
  }
}




