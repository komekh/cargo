import 'package:flutter/material.dart';

import '../../configs/app.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';
import '../presentation.dart';

class Splash2Screen extends StatelessWidget {
  const Splash2Screen({super.key});

  void _onFollowTapped(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRouter.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color(0xFF5468FF), // Lighter blue in the center
              AppColors.primary, // Darker blue at the edges
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cargo goşundy',
                  style: AppText.h1b?.copyWith(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),

                /// gap
                Space.yf(0.60),

                /// text
                Text(
                  'Öz sargydyňyzy yzarlaň',
                  style: AppText.b1?.copyWith(
                    color: AppColors.yellow,
                    fontSize: 22,
                  ),
                ),

                /// gap
                Space.yf(3),

                /// images
                Image.asset(
                  AppAssets.BoxesPng,
                  height: AppDimensions.normalize(90),
                ),
                Space.yf(),
                Padding(
                  padding: Space.hf(),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      textColor: AppColors.primary,
                      btnColor: AppColors.yellow,
                      onPressed: () => _onFollowTapped(context),
                      text: 'Yzarlap başlaň',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
