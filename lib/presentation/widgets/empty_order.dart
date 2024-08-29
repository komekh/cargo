import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../configs/space.dart';
import '../../core/constants/constants.dart';

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kToolbarHeight * 3,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAssets.search),
            Space.yf(),
            Text('order_not_available'.tr()),
          ],
        ),
      ),
    );
  }
}
