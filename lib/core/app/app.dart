import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../di/di.dart' as di;
import '../core.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<NavigationCubit>()),
        BlocProvider(
          create: (context) => di.sl<LanguageBloc>()..add(LanguageInitial()),
        ),
        BlocProvider(
          create: (context) => di.sl<UserBloc>(), //..add(CheckUser()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        onGenerateRoute: AppRouter.onGenerateRoute,
        onGenerateInitialRoutes: (initialRoute) => AppRouter.generateInitialRoutes(initialRoute),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: AppRouter.root,
      ),
    );
  }
}
