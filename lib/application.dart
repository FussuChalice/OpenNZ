import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/providers/user_provider.dart';
import 'package:opennz_ua/screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    _checkUserAuthData();
  }

  Widget welcomeView = const SplashScreen();

  Future<void> _checkUserAuthData() async {
    var box = await Hive.openBox("auth_data");
    if (box.isEmpty) {
      setState(() {
        welcomeView = const LogInScreen();
      });
    } else {
      setState(() {
        welcomeView = const HomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MaterialApp(
        theme: ThemeData(colorSchemeSeed: ApplicationColors.black),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: welcomeView,
      ),
    );
  }
}
