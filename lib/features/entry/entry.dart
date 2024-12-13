import 'package:bizconnect/app/theme/colors.dart';
import 'package:bizconnect/widget/button.dart';
import 'package:flutter/gestures.dart';
// import 'package:bizconnect/widget/static_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Scaffold(
        body: SizedBox.expand(
            child: Container(
      color: white200,
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                child: Row(
                  children: [
                    const SizedBox(height: 100),
                    SvgPicture.asset(
                      'assets/svg/logo.svg',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Center(
                child: SvgPicture.asset('assets/svg/entry.svg'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 26),
                    const SizedBox(height: 26),
                    const Text(
                      "Seamlessly Do Business",
                      style: TextStyle(
                          color: cyan100,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Connecting Immigrant & local Business Owners with their Customers",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        letterSpacing: -.5,
                      ),
                    ),
                    const SizedBox(height: 26),
                    Button(
                      isLoading: false,
                      text: "Business owner? Get started",
                      onPressed: () {
                        context.go('/signup');
                      },
                    ),
                    const SizedBox(height: 16),
                    Button(
                      text: "Sign up as a customer",
                      isLoading: false,
                      backgroundColor: white200,
                      borderColor: red,
                      borderWidth: 1.0,
                      textColor: red,
                      onPressed: () {
                        context.go('/signup');
                      },
                    ),
                    const SizedBox(height: 26),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Have an account? ",
                          style: const TextStyle(
                            color: grey600,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: "Log In",
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: cyan100,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go(
                                      '/login'); // Navigate to the login page
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(height: 26),
                    // const SizedBox(height: 26),
                    // // enure that this stays at the button of the screen
                    // Padding(
                    //   padding: const EdgeInsets.all(36.0),
                    //   child: Center(
                    //     child: Text(
                    //       '$currentYear Bizconnect24. All rights reserved',
                    //       style: const TextStyle(
                    //           fontSize: 12.0,
                    //           color: grey500,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //   ),
                    // )
                  ],
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
            ]),
      ),
    )));
  }
}
