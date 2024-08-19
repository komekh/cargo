import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../application/user_bloc/user_bloc.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  void _nextScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRouter.root,
      (route) => false,
    );
  }

  void _onEyeTapped() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// image part
            Container(
              height: AppDimensions.normalize(155),
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 60, bottom: 20),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.logo,
                            height: AppDimensions.normalize(30),
                          ),
                          Space.yf(0.80),
                          Text(
                            appTitle,
                            style: AppText.h1b?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Space.yf(0.30),
                          Text(
                            'Довезём всё!',
                            style: AppText.b1?.copyWith(
                              color: AppColors.yellow,
                            ),
                          ),
                          Image.asset(
                            AppAssets.trucksPng,
                            height: AppDimensions.normalize(52),
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// form part
            SizedBox(
              height: AppDimensions.normalize(165),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -20,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: Space.hf().copyWith(top: 30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'login_header'.tr(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                'login_desc'.tr(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),

                              /// gap
                              Space.yf(),

                              /// username field
                              Text('login'.tr()),
                              Space.y!,
                              TextFormField(
                                controller: _userNameController,
                                decoration: InputDecoration(
                                  hintText: 'login_hint'.tr(),
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (val) => FormValidator.validateField(val),
                              ),

                              /// gap
                              Space.yf(),

                              /// password field
                              Text('password'.tr()),
                              Space.y!,
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: 'password_hint'.tr(),
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: GestureDetector(
                                    onTap: _onEyeTapped,
                                    child: _obscureText
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(
                                            Icons.visibility,
                                          ),
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (val) => FormValidator.validateField(val),
                              ),

                              /// gap
                              Space.yf(),

                              BlocConsumer<UserBloc, UserState>(
                                listener: (context, state) {
                                  if (state is UserLogged) {
                                    _nextScreen();
                                  } else if (state is UserLoggedFail) {
                                    if (state.failure is CredentialFailure) {
                                      showErrorDialog(
                                        context: context,
                                        header: 'credentials_validation_header'.tr(),
                                        body: 'credentials_validation_body'.tr(),
                                      );
                                    } else {
                                      showAuthErrorDialog(context);
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  if (state is UserLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return SizedBox(
                                    width: double.infinity,
                                    child: AppButton(
                                      textColor: Colors.white,
                                      btnColor: AppColors.primary,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          Keyboard.hide(context);

                                          /// sign in
                                          context.read<UserBloc>().add(
                                                SignInUser(
                                                  SignInParams(
                                                    username: _userNameController.text,
                                                    password: _passwordController.text,
                                                  ),
                                                ),
                                              );
                                        }
                                      },
                                      text: 'start_tracking'.tr(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
