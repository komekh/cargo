import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../di/di.dart' as di;
import '../../domain/entities/order/filter_params_model.dart';
import '../core.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<NavigationCubit>()),
        BlocProvider(
          create: (context) => di.sl<SplashCubit>()..checkToken(),
        ),
        BlocProvider(
          create: (context) => di.sl<LanguageBloc>()..add(LanguageInitial()),
        ),
        BlocProvider(
          create: (context) => di.sl<UserBloc>(), //..add(CheckUser()),
        ),
        BlocProvider(
          create: (context) => di.sl<OrderBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<OrderDetailBloc>(),
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
        initialRoute: AppRouter.splash,
        theme: ThemeData(
          primarySwatch: CustomColors.primarySwatch,
          useMaterial3: false,
          primaryColor: AppColors.primary,
        ),
      ),
    );
  }
}
