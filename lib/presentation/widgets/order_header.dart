import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/core.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppAssets.header,
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: AppDimensions.normalize(12),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'cargo_app'.tr(),
                  style: AppText.h1b?.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
                Space.yf(0.30),
                Text(
                  'follow_orders_banner'.tr(),
                  style: AppText.b1?.copyWith(
                    color: AppColors.yellow,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
