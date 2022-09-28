import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/rout/router.dart';
import 'package:quiz_u/screens/export/screens_export.dart';
import 'package:quiz_u/screens/splash_screen.dart';


import 'data/providers/provider_list/list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
    providers: Providers.providers,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4b4c50),
        backgroundColor: const Color(0xFF4b4c50),
      ),
      home:  SplashScreen(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
