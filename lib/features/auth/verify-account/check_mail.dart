// ignore_for_file: prefer_const_constructors

import 'package:bizconnect/features/auth/login/login_view_modal.dart';
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

class CheckMail extends ConsumerStatefulWidget {
  const CheckMail({
    super.key,
  });

  @override
  ConsumerState<CheckMail> createState() => _CheckMailState();
}

class _CheckMailState extends ConsumerState<CheckMail> {
  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 26),
                        const SizedBox(height: 26),
                        const SizedBox(height: 26),
                        const SizedBox(height: 26),
                        // start from here with  24px top and bottom, 12px left and right, radius of 8px backgroundColor: white
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 34, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                      'assets/svg/verify-mail.svg'),
                                ),
                                    const SizedBox(height: 8),
                                Text(
                                  'Check your email',
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: red,
                                      fontWeight: FontWeight.w700),
                                ),
                                    const SizedBox(height: 8),
                                Text(
                                  'A link to verify your email has been sent to your mail ',
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: grey500,
                                      fontWeight: FontWeight.w500),
                                ),
                                    const SizedBox(height: 8),
                                Text(
                                  'tan*****@gmail.com',
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: red,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                            
                               const SizedBox(height: 26),
                             Center(
                              child: RichText(
                                text: TextSpan(
                                  text: "Can’t find email? ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Resend",
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            red,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.go(
                                              '/login'); // Navigate to the signup page
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        // end here
                      ],
                    ),
                  ),
                ),
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
    );
  }
}
