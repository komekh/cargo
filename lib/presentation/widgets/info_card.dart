import 'package:flutter/material.dart';

import '../../configs/configs.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

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
              const RowTextWidget(title: 'Ýagdaýy:', info: 'Ýolda'),
              Space.y!,
              const RowTextWidget(title: 'Awtoulag №:', info: 'ABC456789'),
              Space.y!,
              const RowTextWidget(title: 'Dukan №:', info: 'ABC456789'),
              Space.y!,
              const RowTextWidget(title: 'Nireden ugradyldy:', info: 'Urumçy'),
              Space.y!,
              const RowTextWidget(title: 'Nirä barmaly:', info: 'Aşgabat'),
              Space.y!,
              const RowTextWidget(title: 'Ýer sany:', info: '36'),
              Space.y!,
              const RowTextWidget(title: 'Kub:', info: '12 m3'),
              Space.y!,
              const RowTextWidget(title: 'Göwrumi:', info: '60x57x38 (ini, uzynlygy, beýikligi)'),
              Space.y!,
              const RowTextWidget(title: 'Harydyň ady:', info: 'Köwüş'),
              Space.y!,
              const RowTextWidget(title: 'Sargydyň bahasy:', info: '300'),
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
        ),
        Space.x!,
        Text(
          info,
          style: AppText.b1!.copyWith(
            color: const Color(0xFF0C0C0D),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
