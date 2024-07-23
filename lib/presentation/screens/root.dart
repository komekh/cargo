import 'package:cargo/core/core.dart';
import 'package:cargo/presentation/screens/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../configs/configs.dart';
import '../widgets/bottom_navbar.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  Future<bool> onPopInvoked(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Exit Application',
              style: TextStyle(color: AppColors.primary),
            ),
            content: const Text(
              'Are You Sure?',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              TextButton(
                child: const Text(
                  'No',
                  style: TextStyle(color: AppColors.primary),
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
                  case NavigationTab.homeTab:
                    return const OrdersScreen();
                  case NavigationTab.categoriesTab:
                    return const Text(' CategoriesScreen()');
                  case NavigationTab.productsTap:
                    return const Text('ProductsListScreen()');
                  default:
                    return const Text('HomeScreen()');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
