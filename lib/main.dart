import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'core/core.dart';
import 'di/di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // await GetStorage.init();

  await di.init();

  Bloc.observer = MyBlocObserver();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('tr', 'TR'),
        Locale('ru', 'RU'),
      ],
      path: 'assets/locale',
      fallbackLocale: const Locale('tr', 'TR'),
      startLocale: const Locale('tr', 'TR'),
      child: Phoenix(child: const MyApp()),
    ),
  );
}

/// ADDING PROGRESS
// 1 create bloc
// 2 create use_case under domain folder
// 3 create repository
// 4 create repository implementation
// 5 create data source
// 6 add di register

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
