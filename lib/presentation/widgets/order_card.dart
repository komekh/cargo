import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/core.dart';

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
                Text(
                  'Genişleýin >',
                  style: AppText.b1b?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),

            /// gap
            Space.yf(0.5),

            /// status bar
            Row(
              children: [
                const Icon(Icons.circle, color: Colors.green, size: 12),
                const SizedBox(width: 4),
                Text(
                  'Ýolda',
                  style: AppText.b2b!.copyWith(
                    color: const Color(0xFF96969C),
                  ),
                ),
                const Spacer(),
                Text(
                  'Ugradylan senesi: 16.07.2024',
                  style: AppText.b2b!.copyWith(
                    color: const Color(0xFF96969C),
                  ),
                ),
              ],
            ),

            /// gap
            Space.yf(0.75),

            /// info bar
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nireden:',
                        style: AppText.b2b!.copyWith(
                          color: const Color(0xFF96969C),
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
                          color: const Color(0xFF96969C),
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
                ),
                const Spacer(flex: 1),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ýer sany:'),
                      Text(
                        '10',
                        style: AppText.b2b!.copyWith(
                          color: const Color(0xFF96969C),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Göwrümi:'),
                      Text(
                        '1472,31',
                        style: AppText.b2b!.copyWith(
                          color: const Color(0xFF57575C),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Maşyn №:',
                        style: AppText.b2b!.copyWith(
                          color: const Color(0xFF96969C),
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
                          color: const Color(0xFF96969C),
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
