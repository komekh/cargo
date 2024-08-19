import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';
import '../widgets/bottom_navbar.dart';
import 'screens.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  Future<bool> onPopInvoked(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'exit_app'.tr(),
              style: const TextStyle(color: AppColors.primary),
            ),
            content: Text(
              'are_you_sure'.tr(),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'yes'.tr(),
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              TextButton(
                child: Text(
                  'no'.tr(),
                  style: const TextStyle(color: AppColors.primary),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return PopScope(
      onPopInvoked: (didPop) => onPopInvoked(context),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        bottomNavigationBar: const BottomNavigation(),
        body: Container(
          color: AppColors.surface,
          child: Center(
            child: BlocBuilder<NavigationCubit, NavigationTab>(
              builder: (context, activeTab) {
                switch (activeTab) {
                  case NavigationTab.home:
                    return const OrdersScreen();
                  case NavigationTab.histories:
                    return const HistoriesScreen();
                  case NavigationTab.profile:
                    return const ProfileScreen();
                  default:
                    return const OrdersScreen();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
