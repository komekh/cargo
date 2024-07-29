import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/core.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.normalize(80),
      child: Stack(
        children: [
          Image.asset(
            AppAssets.header,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: AppDimensions.normalize(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cargo goşundy',
                  style: AppText.h1b?.copyWith(
                    color: Colors.white,
                  ),
                ),
                Space.yf(0.30),
                Text(
                  'Öz sargydyňyzy yzarlaň',
                  style: AppText.b1?.copyWith(
                    color: AppColors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
