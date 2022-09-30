import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_u/data/apis/login_api.dart';
import 'package:quiz_u/data/apis/token_api.dart';
import 'package:quiz_u/data/data_constants.dart';

import 'package:quiz_u/rout/rout_names_constant.dart';
import 'package:quiz_u/ui/widgets/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {


      if (!mounted) return;
      Navigator.pushReplacementNamed(context, auth);
    } else {
      prefs.setBool('seen', true);
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1500),
              pageBuilder: (_, __, ___) => const OnBoardingScreen()));
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () => checkFirstSeen());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: const Center(
          child: Logo(),
        ),
      ),
    );
  }
}
