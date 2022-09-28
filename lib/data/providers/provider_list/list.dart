import 'package:provider/provider.dart';

import 'package:quiz_u/data/providers/provider_list/providers_export.dart';


class Providers {
  static List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<SharedPreferenceProvider>(create: (_) => SharedPreferenceProvider()),
    ChangeNotifierProvider<LogInProvider>(create: (_) => LogInProvider()),
    ChangeNotifierProvider<TapsProvider>(create: (_) => TapsProvider()),
    ChangeNotifierProvider<QuestionsProvider>(create: (_) => QuestionsProvider()),


  ];
}