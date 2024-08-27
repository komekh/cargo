import 'package:flutter/material.dart';

import '../../configs/app_dimensions.dart';
import '../../core/constants/api.dart';
import '../screens/image_full.dart';

class ImagesWidget extends StatelessWidget {
  final List<String> imageStrings;

  const ImagesWidget({super.key, required this.imageStrings});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: imageStrings.map((imageString) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImageScreen(imageUrl: '$imageUrl/$imageString'),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ), // Adding a border
              ),
              child: Image.network(
                '$imageUrl/$imageString',
                width: AppDimensions.normalize(60),
                height: AppDimensions.normalize(60),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 100);
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
