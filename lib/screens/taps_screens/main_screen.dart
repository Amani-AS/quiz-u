import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/data/providers/provider_list/providers_export.dart';
import 'package:quiz_u/my_flutter_app_icons.dart';
import 'package:quiz_u/rout/rout_names_constant.dart';
import 'package:quiz_u/screens/taps_screens/taps/home_tap.dart';
import 'package:quiz_u/screens/taps_screens/taps/leaderboard_tap.dart';
import 'package:quiz_u/screens/taps_screens/taps/profile_tap.dart';
import 'package:quiz_u/ui/widgets/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quiz_u/data/data_constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    TapsProvider provider = Provider.of<TapsProvider>(context);
    LogInProvider logProvider=Provider.of<LogInProvider>(context);
    List menu = [
      {"icon": Icons.home, "label": "Home"},
      {"icon": MyFlutterApp.images, "label": "Leaders"},
      {"icon": Icons.person_sharp, "label": "Profile"},
    ];
    double height = MediaQuery.of(context).size.height;

    List pages = [
      const Home(),
      const Leaderboard(),
      const Profile(),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        actions: [
          provider.page == 2
              ? IconButton(
                  icon: const Icon(Icons.logout_outlined, color: Colors.white),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(AppConstants.keyAccessToken, "");
                    logProvider.reSetControllers();
                    if (!mounted) return;
                    Navigator.pushReplacementNamed(context, logIn);
                  },
                )
              : const SizedBox(),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Colors.white70,
        centerTitle: true,
        title: const Logo(),
      ),
      body: Builder(
        builder: (context) => pages[provider.page],

        // pages[widget.pageNo!]
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.white70, blurRadius: 2, spreadRadius: 2)
        ]),
        child: BottomNavigationBar(
            elevation: 10,
            selectedLabelStyle: const TextStyle(color: Colors.orange),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).primaryColor,
            onTap: (int i) {
              provider.setPage(i);
            },
            items: <BottomNavigationBarItem>[
              for (var i = 0; i < pages.length; i++)
                BottomNavigationBarItem(
                    label: "",
                    icon: Column(
                      children: [
                        Icon(
                          menu[i]["icon"],
                          color:
                              i == provider.page ? Colors.orange : Colors.grey,
                          size: 0.03 * height,
                        ),
                        Text(
                          menu[i]["label"],
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w400,
                            fontSize: 0.013 * height,
                            color: i == provider.page
                                ? Colors.orange
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ))
            ]),
      ),
    );
  }
}
