import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/core.dart';
import 'vertical_line.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: Space.all(.8, 0.5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Track number
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '№ABC456789',
                  style: AppText.b1b,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRouter.orderDetails);
                  },
                  child: Text(
                    'Ginişleýin >',
                    style: AppText.b1b?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),

            /// gap
            Space.yf(0.5),

            /// status bar
            Row(
              children: [
                const Icon(Icons.circle, color: AppColors.green, size: 12),
                const SizedBox(width: 4),
                Text(
                  'Ýolda',
                  style: AppText.b2b!.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                const Spacer(),
                Text(
                  'Ugradylan senesi: 16.07.2024',
                  style: AppText.b2b!.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),

            /// gap
            Space.y!,
            const Divider(),
            Space.y!,

            /// info bar
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      /// vertical status line
                      Container(
                        width: AppDimensions.normalize(15),
                        alignment: Alignment.topLeft,
                        child: VerticalLine(
                          width: AppDimensions.normalize(1),
                          height: AppDimensions.normalize(2.5),
                          topColor: AppColors.green,
                          bottomColor: AppColors.grey,
                        ),
                      ),

                      /// info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nireden:',
                            style: AppText.b2b!.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          Text(
                            'Urumçy',
                            style: AppText.b2b!.copyWith(
                              color: const Color(0xFF57575C),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Nirede:',
                            style: AppText.b2b!.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          Text(
                            'Aşgabat',
                            style: AppText.b2b!.copyWith(
                              color: const Color(0xFF57575C),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  /* */
                ),
                // const Spacer(flex: 1),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ýer sany:',
                        style: AppText.b2b!.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        '10',
                        style: AppText.b2b!.copyWith(
                          color: const Color(0xFF57575C),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Göwrümi:',
                        style: AppText.b2b!.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        '1472,31',
                        style: AppText.b2b!.copyWith(
                          color: const Color(0xFF57575C),
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(flex: 1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Maşyn №:',
                        style: AppText.b2b!.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        'AA1234AA',
                        style: AppText.b2b!.copyWith(
                          color: const Color(0xFF57575C),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Dukan №:',
                        style: AppText.b2b!.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        'A1043',
                        style: AppText.b2b!.copyWith(
                          color: const Color(0xFF57575C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
