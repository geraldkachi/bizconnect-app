// ignore_for_file: prefer_const_constructors
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/service/auth_service.dart';
import 'package:bizconnect/utils/validator.dart';
import 'package:bizconnect/widget/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:bizconnect/app/theme/colors.dart';
import 'package:bizconnect/widget/input.dart';


class VerifyPage extends ConsumerStatefulWidget {
  const VerifyPage({super.key});

  @override
  ConsumerState<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends ConsumerState<VerifyPage> {
  final AuthService _authService = getIt<AuthService>();
  TextEditingController otp = TextEditingController();

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
                    if (_authService.userVerified)
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
                                  'assets/svg/success-mail.svg'),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Email Verification Successful',
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
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 0, left: 30, right: 30),
                              child: Button(
                                text: "Okay, awesome!",
                                isLoading: false,
                                onPressed: () {
                                  setState(() {
                                     context.go('/login');
                                    //  context.go('/setup-business-profile');
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    else
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
                              'Check Your Email',
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
                              // 'tan*****@gmail.com',
                               _authService?.userData?.email != null && _authService.userData!.email!.contains('@')
                                ? '${_authService.userData!.email?.substring(0, 3)}*****@${_authService.userData!.email?.split('@').last}'
                                : 'Invalid email',
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  color: red,
                                  fontWeight: FontWeight.w500),
                            ),

                           const SizedBox(height: 10),
                            InputField(
                            controller: otp,
                            labelText: "OTP",
                            hintText: "000-000",
                            validator: (value) =>
                                Validator.validate6Otp(value),
                            suffixIcon: InkWell(
                                onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text("Resend: 04:32", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),),
                              ),
                            ),
                          ),
                           const SizedBox(height: 20),
                          Button(
                            text: "Verify",
                            isLoading: false,
                            onPressed: () async {
                              // if (otp.text.isEmpty) {
                              //   showToast("Please enter OTP");
                              //   return;
                              // }
                              //  _secureStorageService.deleteAccessToken();
                              // loginRead.login(context);
                            },
                          ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 26),
                    if(!_authService.userVerified) 
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
                                color: red,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/login');
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
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
          ],
        ),
      ),
    );
  }
}
