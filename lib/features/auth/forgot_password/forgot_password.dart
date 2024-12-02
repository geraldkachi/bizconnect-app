import 'package:flutter/material.dart';
import 'package:bizconnect/features/auth/forgot_password/forgot_password_view_model.dart';
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


class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
   @override
  Widget build(BuildContext context) {
    final forgotWatch = ref.watch(forgotPasswordViewModelProvider);
    final forgotRead = ref.read(forgotPasswordViewModelProvider.notifier);
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
                key: forgotWatch.formKey,
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
                            "Reset Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            controller: forgotWatch.emailController,
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
                          
                         
                          const SizedBox(height: 20),
                          Button(
                            text: "Verify Email",
                            isLoading: forgotWatch.isLoading,
                            onPressed: () async {
                              forgotRead.forgotPassword(context);
                            },
                          ),
                          const SizedBox(height: 20),
                          
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