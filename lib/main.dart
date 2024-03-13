// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/authentaction/login/login_screen.dart';
import 'package:untitled/authentaction/register/register_screen.dart';
import 'package:untitled/provider/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled/provider/authprovider.dart';
import 'home/home_screen.dart';
import 'home/task_list/add_task_list.dart';
import 'mytheme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 1));

  await Future.delayed(const Duration(seconds: 1));

  await Future.delayed(const Duration(seconds: 1));

  FlutterNativeSplash.remove();
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyB8PEh-bZMGC9RtyC8nBS4TsEwSZiGO6LU",
              appId: "1:784062052248:android:aee82a5870a1f05dc31ded",
              messagingSenderId: "784062052248",
              projectId: "test-c8dc2"))
      : await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => AppConfigProvider()..loadSettings()),
      ChangeNotifierProvider(create: (context) => AuthUsers()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: Login.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        Add_Task.routeName: (context) => Add_Task(),
        Register.routeName: (context) => Register(),
        Login.routeName: (context) => Login(),
      },
      theme: MyTheme.lightThem,
      darkTheme: MyTheme.darkThem,
      themeMode: provider.appTheme,
      locale: Locale(provider.appLanguage),
    );
  }
}
