import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application/contact_cubit/contact_cubit.dart';
import '../../application/user_bloc/user_bloc.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';
import '../../domain/entities/contact/contact.dart';
import '../../domain/entities/user/user.dart';
import '../presentation.dart';

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
    context.read<ContactCubit>().getContacts();
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
    return Padding(
      padding: Space.all(1, 1),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// gap
                Space.yf(1.3),

                /// header
                Text(
                  'personal_cabinet'.tr(),
                  style: AppText.h1b,
                ),

                Space.y!,

                /// user card
                _buildUserCard(context, user),

                ///gap
                Space.yf(2),

                /// settings card
                _buildSettingsCard(context),

                ///gap
                Space.yf(2),

                /// contacts list
                BlocBuilder<ContactCubit, ContactState>(
                  builder: (context, state) {
                    if (state is ContactLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ContactLoaded) {
                      return state.contacts.isEmpty ? const SizedBox.shrink() : _buildContactsList(state.contacts);
                    } else if (state is ContactError) {
                      return RetryWidget(
                        onRetry: () {
                          context.read<ContactCubit>().getContacts();
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),

          /// logout at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                context.read<UserBloc>().add(SignOutUser());
              },
              child: Text(
                'logout'.tr(),
                style: AppText.b1!.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, User user) {
    return SizedBox(
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

              /// phone
              if (user.phone.isNotEmpty)
                Column(
                  children: [
                    /// gap
                    Space.yf(1),

                    /// phone
                    RowWidget(
                      text: user.phone,
                      leadingIcon: Icons.phone_android_outlined,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    return SizedBox(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactsList(List<ContactEntity> contacts) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'contact_support'.tr(),
            style: AppText.h3b,
          ),
          Space.yf(0.8),
          ...contacts.map(
            (contact) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone_iphone),
                      const SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${contact.number} ',
                              style: const TextStyle(
                                color: Colors.black, // Use appropriate color
                                fontWeight: FontWeight.bold, // You can choose different font styles
                                fontSize: 16, // Set font size
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri phoneUri = Uri(scheme: 'tel', path: contact.number);
                                  launchUrl(phoneUri);
                                },
                            ),
                            TextSpan(
                              text: contact.name,
                              style: TextStyle(
                                color: Colors.grey[700], // A different color for the name
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Space.yf(0.6)
                ],
              );
            },
          ),
        ],
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
