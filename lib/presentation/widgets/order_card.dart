import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/core.dart';
import '../../domain/domain.dart';
import 'vertical_line.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;

  const OrderCard({required this.order, super.key});

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
                  '№${order.no}',
                  style: AppText.b1b,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRouter.orderDetails,
                      arguments: order,
                    );
                  },
                  child: Text(
                    '${'order_details'.tr()} >',
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
                  order.state,
                  style: AppText.b2b!.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                const Spacer(),
                Text(
                  '${'order_sent'.tr()}: ${order.departedAt}',
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
                          bottomColor: order.state == GoodsState.Delivered.name ? AppColors.green : AppColors.grey,
                        ),
                      ),

                      /// info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${'order_from_card'.tr()}:',
                              style: AppText.b2b!.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                            Text(
                              order.from,
                              style: AppText.b2b!.copyWith(
                                color: const Color(0xFF57575C),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${'order_to_card'.tr()}:',
                              style: AppText.b2b!.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                            Text(
                              order.to,
                              style: AppText.b2b!.copyWith(
                                color: const Color(0xFF57575C),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(flex: 1),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'order_placement_count'.tr()}:',
                        style: AppText.b2b!.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        order.placesCount.toString(),
                        style: AppText.b2b!.copyWith(
                          color: const Color(0xFF57575C),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${'order_dimensions'.tr()}:',
                        style: AppText.b2b!.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        order.volume.toString(),
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
                        '${'order_carrier'.tr()}:',
                        style: AppText.b2b!.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        order.carrier,
                        style: AppText.b2b!.copyWith(
                          color: const Color(0xFF57575C),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${'order_shop'.tr()}:',
                        style: AppText.b2b!.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        order.shopNo,
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
