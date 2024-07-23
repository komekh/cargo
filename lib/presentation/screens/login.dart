import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/app.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';
import '../widgets/button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// image part
            Container(
              height: AppDimensions.normalize(155),
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 60, bottom: 20),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.Logo,
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
                          Image.asset(
                            AppAssets.TrucksPng,
                            height: AppDimensions.normalize(52),
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// form part
            SizedBox(
              height: AppDimensions.normalize(145),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -20,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: Space.hf().copyWith(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Şahsy otaga giriş',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text(
                              'özüňize berlen logini we açar sözi giriziň',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),

                            /// gap
                            Space.yf(),

                            /// username field
                            const Text('Login'),
                            Space.yf(0.30),
                            const TextField(
                              decoration: InputDecoration(
                                hintText: 'Öz loginiňizi ýazyň',
                                prefixIcon: Icon(Icons.person_outline),
                                // suffixIcon: Icon(Icons.visibility_off),
                                border: OutlineInputBorder(),
                              ),
                            ),

                            /// gap
                            Space.yf(),

                            /// password field
                            const Text('Açar sözi'),
                            Space.yf(0.30),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Öz açar sözüňi ýazyň',
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: Icon(Icons.visibility_off),
                                border: OutlineInputBorder(),
                              ),
                            ),

                            /// gap
                            Space.yf(),

                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                textColor: AppColors.primary,
                                btnColor: AppColors.yellow,
                                onPressed: () {},
                                text: 'Yzarlap başlaň',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
