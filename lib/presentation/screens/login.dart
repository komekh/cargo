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

  void _nextScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRouter.root,
      (route) => false,
    );
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
                            AppAssets.Logo,
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
                            AppAssets.TrucksPng,
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
                              const Text(
                                'Şahsy otaga giriş',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const Text(
                                'özüňize berlen logini we açar sözi giriziň',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),

                              /// gap
                              Space.yf(),

                              /// username field
                              const Text('Login'),
                              Space.y!,
                              TextFormField(
                                controller: _userNameController,
                                decoration: const InputDecoration(
                                  hintText: 'Öz loginiňizi ýazyň',
                                  prefixIcon: Icon(Icons.person_outline),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) => FormValidator.validateField(val),
                              ),

                              /// gap
                              Space.yf(),

                              /// password field
                              const Text('Açar sözi'),
                              Space.y!,
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Öz açar sözüňi ýazyň',
                                  prefixIcon: Icon(Icons.lock_outline),
                                  suffixIcon: Icon(Icons.visibility_off),
                                  border: OutlineInputBorder(),
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
                                      showCredentialErrorDialog(context);
                                    } else {
                                      showAuthErrorDialog(context);
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: AppButton(
                                      textColor: Colors.white,
                                      btnColor: AppColors.primary,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
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
                                      text: 'Yzarlap başlaň',
                                    ),
                                  );
                                },
                              )
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
