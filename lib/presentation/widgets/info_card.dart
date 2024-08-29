import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../domain/entities/order/order.dart';

class InfoCard extends StatelessWidget {
  final OrderEntity order;
  const InfoCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowTextWidget(title: '${'order_status'.tr()}:', info: order.state),
              Space.y!,
              RowTextWidget(title: '${'order_carrier'.tr()}:', info: order.carrier),
              Space.y!,
              RowTextWidget(title: '${'order_shop'.tr()}:', info: order.shopNo),
              Space.y!,
              RowTextWidget(title: '${'order_from'.tr()}:', info: order.from),
              Space.y!,
              RowTextWidget(title: '${'order_to'.tr()}:', info: order.to),
              Space.y!,
              RowTextWidget(title: '${'order_placement_count'.tr()}:', info: order.placesCount.toString()),
              Space.y!,
              RowTextWidget(title: '${'order_volume'.tr()}:', info: order.volume.toString()),
              Space.y!,
              RowTextWidget(
                  title: '${'order_dimensions'.tr()}:',
                  info: '${order.width}x${order.depth}x${order.height} ${'order_dimensions_desc'.tr()}'),
              Space.y!,
              RowTextWidget(title: '${'order_product_name'.tr()}:', info: order.name),
              // Space.y!,
              //  RowTextWidget(title: 'Sargydyň bahasy:', info: order.price),
            ],
          ),
        ),
      ),
    );
  }
}

class RowTextWidget extends StatelessWidget {
  final String title;
  final String info;
  const RowTextWidget({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppText.h3!.copyWith(
            color: const Color(0xFF57575C),
          ),
          maxLines: 2,
        ),
        Space.x!,
        Expanded(
          child: Text(
            info,
            style: AppText.h3!.copyWith(
              color: const Color(0xFF0C0C0D),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
