import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/core.dart';
import 'dashed_line.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  index % 2 == 0
                      ? const Icon(
                          Icons.radio_button_checked,
                          color: AppColors.grey,
                        )
                      : Container(
                          margin: Space.hf(0.35), //const EdgeInsets.only(left: 6),
                          height: AppDimensions.normalize(4.5),
                          width: AppDimensions.normalize(4.5),
                          decoration: const BoxDecoration(
                            color: AppColors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                  Space.x!,
                  Text(
                    routess[index].city,
                    style: AppText.b1b,
                  ),
                  const Spacer(),
                  Text(
                    routess[index].date,
                    style: AppText.b1!.copyWith(color: AppColors.grey),
                  ),
                ],
              );
            },
            itemCount: routess.length,
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: Space.vf(0.5),
                child: DashedLine(
                  height: 1,
                  width: AppDimensions.normalize(8),
                  color: AppColors.lightGrey,
                  strokeWidth: 1,
                  dashWidth: 5,
                  dashSpace: AppDimensions.normalize(2),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Path {
  final String city;
  final String date;

  Path(this.city, this.date);
}

List<Path> routess = [
  Path('Urumchi', '10.07.2024'),
  Path('Astana', '14.07.2024'),
  Path('Tashkent', '16.07.2024'),
  Path('Samarkant', '25.07.2024'),
  Path('Mary', '30.07.2024'),
];
