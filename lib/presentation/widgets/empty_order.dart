import 'package:flutter/material.dart';

import '../../configs/space.dart';
import '../../core/constants/constants.dart';

class EmptyOrder extends StatelessWidget {
  final String text;
  const EmptyOrder({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kToolbarHeight * 3,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(
                AppColors.surface,
                BlendMode.multiply,
              ),
              child: Image.asset(
                AppAssets.searchGif,
                height: 120,
                width: 120,
              ),
            ),
            Space.yf(),
            Text(text),
          ],
        ),
      ),
    );
  }
}
