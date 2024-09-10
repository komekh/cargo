import 'dart:developer';
import 'dart:io';

import 'package:cargo/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'core/core.dart';
import 'di/di.dart' as di;

Future<void> _initFBInitials() async {
  try {
    await initFCMFunctions();

    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    // await FirebaseMessaging.instance.setAutoInitEnabled(true);
    // log('FCMToken $fcmToken');
  } catch (e) {
    debugPrint('FCM error: $e');
  }
}

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();

  _initFBInitials();

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

