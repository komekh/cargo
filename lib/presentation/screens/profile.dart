import 'package:cargo/presentation/presentation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/core.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: Space.all(1, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// gap
              Space.yf(1),

              /// header
              Text(
                'Şahsy otagym',
                style: AppText.h1b,
              ),

              Space.y!,

              /// card
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        /// identity
                        const RowWidget(
                          text: 'ABC1234567890!@#',
                          leadingIcon: Icons.verified_user_outlined,
                        ),

                        /// gap
                        Space.yf(1),

                        /// name surname
                        const RowWidget(
                          text: 'Maksat Üstünlikow',
                          leadingIcon: Icons.person_2_outlined,
                          trailingIcon: Icons.mode_edit_outlined,
                        ),

                        /// gap
                        Space.yf(1),

                        /// phone
                        const RowWidget(
                          text: '+993 (XX) XX-XX-XX',
                          leadingIcon: Icons.phone_android_outlined,
                          trailingIcon: Icons.mode_edit_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///gap
              Space.yf(2),

              /// card
              const SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: RowWidget(
                      text: 'Tehniki goldaw bilen habarlaşmak',
                      leadingIcon: Icons.contact_support_outlined,
                      trailingIcon: Icons.arrow_forward_ios,
                    ),
                  ),
                ),
              ),

              ///gap
              Space.yf(2),

              /// card
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        /// language
                        GestureDetector(
                          onTap: () => onSelectLang(context),
                          child: Container(
                            color: Colors.transparent,
                            child: RowWidget(
                              text: 'profile_select_lang'.tr(),
                              leadingIcon: Icons.language_outlined,
                              trailingIcon: Icons.arrow_forward_ios,
                            ),
                          ),
                        ),

                        /// name surname
                        const RowWidget(
                          text: 'Gizlinlik syýasaty',
                          leadingIcon: Icons.gpp_maybe_outlined,
                          trailingIcon: Icons.arrow_forward_ios,
                        ),

                        /// phone
                        const RowWidget(
                          text: 'Ulanyş şertleri',
                          leadingIcon: Icons.file_copy_outlined,
                          trailingIcon: Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///gap
              Space.yf(2),

              /// logout
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Şahsy otagdan çykmak',
                    style: AppText.b1!.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              ///gap
              Space.yf(2),
            ],
          ),
        ),
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  final String text;
  final IconData leadingIcon;
  final IconData? trailingIcon;
  const RowWidget({
    super.key,
    required this.text,
    required this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Space.vf(0.5),
      child: Row(
        children: [
          Icon(
            leadingIcon,
            color: AppColors.darkGrey,
          ),
          Space.x!,
          Text(
            text,
            style: AppText.b1!.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
          if (trailingIcon != null) ...[
            const Spacer(),
            Icon(
              trailingIcon,
              color: AppColors.darkGrey,
              size: AppDimensions.normalize(7),
            ),
          ]
        ],
      ),
    );
  }
}
