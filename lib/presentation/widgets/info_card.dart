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
              RowTextWidget(title: 'Ýagdaýy:', info: order.state),
              Space.y!,
              RowTextWidget(title: 'Awtoulag №:', info: order.carrier),
              Space.y!,
              RowTextWidget(title: 'Dukan №:', info: order.shopNo),
              Space.y!,
              RowTextWidget(title: 'Nireden ugradyldy:', info: order.from),
              Space.y!,
              RowTextWidget(title: 'Nirä barmaly:', info: order.to),
              Space.y!,
              RowTextWidget(title: 'Ýer sany:', info: order.placesCount.toString()),
              Space.y!,
              RowTextWidget(title: 'Kub:', info: order.volume.toString()),
              Space.y!,
              RowTextWidget(
                  title: 'Göwrumi:', info: '${order.width}x${order.depth}x${order.height} (ini, uzynlygy, beýikligi)'),
              Space.y!,
              RowTextWidget(title: 'Harydyň ady:', info: order.name),
              // Space.y!,
              // const RowTextWidget(title: 'Sargydyň bahasy:', info: '300'),
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
      children: [
        Text(
          title,
          style: AppText.b1!.copyWith(
            color: const Color(0xFF57575C),
          ),
          maxLines: 2,
        ),
        Space.x!,
        Expanded(
          child: Text(
            info,
            style: AppText.b1!.copyWith(
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
