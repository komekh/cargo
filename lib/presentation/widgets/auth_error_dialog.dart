import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/core.dart';

Future<void> showAuthErrorDialog(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: AppDimensions.normalize(50),
            padding: Space.all(1, .5),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Error',
                  //   style: AppText.b1b,
                  // ),
                  // Space.yf(.5),
                  Text(
                    'error_message'.tr(),
                    style: AppText.b1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: AppText.h3b?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
