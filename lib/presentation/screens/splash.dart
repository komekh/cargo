import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../application/application.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        Keyboard.hide(context);
        if (state is NavigateToSplash2) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.splash2,
            (route) => false,
          );
        } else if (state is NavigateToRoot) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.root,
            (route) => false,
          );
        }
      },
      child: Scaffold(
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
                  SvgPicture.asset(
                    AppAssets.logo,
                    height: AppDimensions.normalize(30),
                  ),
                  Space.yf(0.80),
                  Text(
                    appTitle,
                    style: AppText.h1b?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Space.yf(0.30),
                  Text(
                    'Довезём всё!',
                    style: AppText.b1?.copyWith(
                      color: AppColors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   void _nextScreen() {
//     Future.delayed(const Duration(seconds: 1), () {
//       Navigator.of(context).pushNamedAndRemoveUntil(
//         AppRouter.splash2,
//         (route) => false,
//       );
//     });
//   }

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _nextScreen();
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     App.init(context);
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: RadialGradient(
//             center: Alignment.center,
//             radius: 1.0,
//             colors: [
//               Color(0xFF5468FF), // Lighter blue in the center
//               AppColors.primary, // Darker blue at the edges
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(
//                   AppAssets.logo,
//                   height: AppDimensions.normalize(30),
//                 ),
//                 Space.yf(0.80),
//                 Text(
//                   appTitle,
//                   style: AppText.h1b?.copyWith(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Space.yf(0.30),
//                 Text(
//                   'Довезём всё!',
//                   style: AppText.b1?.copyWith(
//                     color: AppColors.yellow,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
