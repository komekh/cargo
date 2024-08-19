// bottom_navigation.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationTab>(
      builder: (context, activeTab) {
        return SizedBox(
          height: AppDimensions.normalize(35),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: activeTab.index,
            onTap: (index) {
              final newTab = NavigationTab.values[index];
              context.read<NavigationCubit>().updateTab(newTab);
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.list_alt_outlined),
                label: 'my_orders'.tr(context: context),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.history_rounded),
                label: 'order_history'.tr(context: context),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline_rounded),
                label: 'personal_cabinet'.tr(context: context),
              ),
            ],
            selectedItemColor: AppColors.primary,
            // unselectedItemColor: Colors.white,
            iconSize: AppDimensions.normalize(12),
            selectedLabelStyle: AppText.b2b,
            unselectedLabelStyle: AppText.b2!.copyWith(
              color: AppColors.grey,
            ),
            backgroundColor: AppColors.surface,
          ),
        );
      },
    );
  }
}
