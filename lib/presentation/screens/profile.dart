import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/user_bloc/user_bloc.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';
import '../../domain/entities/user/user.dart';
import '../widgets/lang_selection.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUser());
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoggedOut || state is UserLoggedFail) {
            _navigateToLoginScreen(context);
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserFetched) {
            return _buildProfileContent(context, state.user);
          } else if (state is UserLoggedFail) {
            return ErrorUtil.buildErrorContent(
              context,
              state.failure,
              () {
                context.read<UserBloc>().add(GetRemoteUser());
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, User user) {
    return SingleChildScrollView(
      child: Padding(
        padding: Space.all(1, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// gap
            Space.yf(1.3),

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
                      /// name surname
                      RowWidget(
                        text: user.fullName,
                        leadingIcon: Icons.person_2_outlined,
                      ),

                      /// gap
                      Space.yf(1),

                      /// phone
                      RowWidget(
                        text: user.phone,
                        leadingIcon: Icons.phone_android_outlined,
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
                onPressed: () {
                  context.read<UserBloc>().add(SignOutUser());
                },
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
    );
  }

  void _navigateToLoginScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouter.login,
        (route) => false,
      );
    });
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
