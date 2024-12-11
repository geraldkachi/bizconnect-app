// ignore_for_file: prefer_const_constructors

import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/features/auth/login/login_view_modal.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:bizconnect/widget/button.dart';
import 'package:bizconnect/widget/input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:bizconnect/app/theme/colors.dart';
import 'package:bizconnect/utils/string_utils.dart';
import 'package:bizconnect/utils/validator.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

 final SecureStorageService _secureStorageService = getIt<SecureStorageService>();
  

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginWatch = ref.watch(loginViewModelProvider);
    final loginRead = ref.read(loginViewModelProvider.notifier);
    final currentYear = DateTime.now().year;

    return Scaffold(
        body: SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Form(
                key: loginWatch.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 26),
                    const SizedBox(height: 26),
                    Center(
                      child: SvgPicture.asset('assets/svg/logo.svg'),
                    ),
                    const SizedBox(height: 26),
                    // start from here with  24px top and bottom, 12px left and right, radius of 8px backgroundColor: white
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Log In",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            controller: loginWatch.emailController,
                            labelText: "Email Address",
                            hintText: "Enter Email Address",
                            validator: (value) =>
                                Validator.validateEmail(value),
                            suffixIcon: IconButton(
                              icon: SvgPicture.asset(
                                'assets/svg/mail.svg',
                                width: 8.0,
                                height: 20.03,
                              ),
                              onPressed: () {
                                // signupRead.togglePassword();
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          InputField(
                            controller: loginWatch.passController,
                            obscureText: loginWatch.obscureText,
                            labelText: "Password",
                            hintText: "Enter Password",
                            validator: (value) =>
                                Validator.validatePassword(value),
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your password';
                            //   }
                            //   if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$')
                            //       .hasMatch(value)) {
                            //     return 'Password must include letters and numbers';
                            //   }
                            //   return null;
                            // },
                            
                            suffixIcon: IconButton(
                              icon: SvgPicture.asset(
                                loginWatch.obscureText
                                    ? 'assets/svg/password-eye-close.svg'
                                    : 'assets/svg/password-eye-open.svg',
                                width: 8.0,
                                height: 25.03,
                              ),
                              onPressed: () {
                                loginRead.togglePassword();
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: InkWell(
                              onTap: () {
                                context.go('/login/forgot_password');
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: black500,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Button(
                            text: "Submit",
                            isLoading: loginWatch.isLoading,
                            onPressed: () async {
                              //  _secureStorageService.deleteAccessToken();
                              loginRead.login(context);
                            },
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don’t have an account? ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign up",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color:
                                          red, // Highlight the clickable text
                                      fontWeight: FontWeight.w400,
                                      // decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // context.go('/signup');
                                        context.go('/main_screen');
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    // end here
                  ],
                ),
              ),
              // this shoule be at the botton of the screen 
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Center(
                  child: Text(
                    '$currentYear Bizconnect24. All rights reserved',
                    style: const TextStyle(
                        fontSize: 12.0,
                        color: grey500,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ])),
      ),
    ));
  }
}
