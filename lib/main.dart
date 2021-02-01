import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mich/configuration/configuration.dart';
import 'package:flutter_mich/translations/translations_delegate.dart';
import 'package:flutter_mich/view/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/issues_list_screen_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool value = false;
  if(prefs.containsKey(Preferences.pref_theme))
    value = prefs.getBool(Preferences.pref_theme);

  CatcherOptions debugOptions = CatcherOptions(DialogReportMode(), [ConsoleHandler()]);

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<IssuesListScreenController>(
      create: (_) =>IssuesListScreenController(),
    ),
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(value ? appThemeDark : appTheme),
    )
  ];

  Catcher(
    rootWidget: MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
    debugConfig: debugOptions,
  );
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'Flutter Issues',
      navigatorKey: Catcher.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
        ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales){
        if(locale != null){
          for (Locale supported in supportedLocales){
            if(supported.languageCode == locale.languageCode)
              return locale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: [
        const Locale('en'),
        const Locale('es')
      ],
      home: LoginScreen(),
    );
  }
}

