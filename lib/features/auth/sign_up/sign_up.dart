import 'package:bizconnect/features/auth/sign_up/sign_up_view_modal.dart';
import 'package:bizconnect/widget/button.dart';
import 'package:bizconnect/widget/input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:bizconnect/app/theme/colors.dart';
// import 'package:bizconnect/utils/string_utils.dart';
import 'package:bizconnect/utils/validator.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final signupWatch = ref.watch(signUpViewModelProvider);
    final signupRead = ref.read(signUpViewModelProvider.notifier);

    final currentYear = DateTime.now().year;

    return Scaffold(
        body: Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: signupWatch.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 26),
                      const SizedBox(height: 26),
                      Center(
                        child: SvgPicture.asset('assets/svg/logo.svg'),
                      ),
                      const SizedBox(height: 26),
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
                              "Create An Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: red),
                            ),

                            const SizedBox(height: 30),
                            // First name
                            InputField(
                              controller: signupWatch.firstNameController,
                              labelText: "First name",
                              hintText: "Enter First Name",
                              validator: (value) =>
                                  Validator.validateName(value),
                              suffixIcon: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/svg/person.svg',
                                  width: 14.0,
                                  height: 20.03,
                                ),
                                onPressed: () {
                                  // signupRead.togglePassword();
                                },
                              ),
                            ),

                            const SizedBox(height: 5),
                            // Last Name
                            InputField(
                              controller: signupWatch.lastNameController,
                              labelText: "Last name",
                              hintText: "Enter Last Name",
                              validator: (value) =>
                                  Validator.validateName(value),
                              suffixIcon: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/svg/person.svg',
                                  width: 14.0,
                                  height: 20.03,
                                ),
                                onPressed: () {
                                  // signupRead.togglePassword();
                                },
                              ),
                            ),

                            const SizedBox(height: 5),
                            InputField(
                              controller: signupWatch.emailController,
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
                              controller: signupWatch.passController,
                              obscureText: signupWatch.obscureText,
                              labelText: "Password",
                              hintText: "Enter Password",
                              validator: (value) =>
                                  Validator.validatePassword(value),
                              suffixIcon: IconButton(
                                icon: SvgPicture.asset(
                                  signupWatch.obscureText
                                      ? 'assets/svg/password-eye-close.svg'
                                      : 'assets/svg/password-eye-open.svg',
                                  width: 8.0,
                                  height: 25.03,
                                ),
                                onPressed: () {
                                  signupRead.togglePassword();
                                },
                              ),
                            ),
                            const SizedBox(height: 5),
                            InputField(
                              controller: signupWatch.confirmPassController,
                              obscureText: signupWatch.obscureText1,
                              labelText: "Confirm Password",
                              hintText: "Enter Confirm Password",
                              validator: (value) =>
                                  Validator.validateConfirmPassword(
                                      signupWatch.passController.text, value),
                              suffixIcon: IconButton(
                                icon: SvgPicture.asset(
                                  signupWatch.obscureText1
                                      ? 'assets/svg/password-eye-close.svg'
                                      : 'assets/svg/password-eye-open.svg',
                                  width: 8.0,
                                  height: 25.03,
                                ),
                                onPressed: () {
                                  signupRead.togglePasswordConfirm();
                                },
                              ),
                            ),

                            const SizedBox(height: 30),
                            // checkbox
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: signupWatch.isChecked,
                                  activeColor: cyan100,
                                  onChanged: (value) {
                                    setState(() {
                                      signupWatch.isChecked = value ?? false;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text:
                                              "By clicking Sign Up you agree to our ",
                                        ),
                                        TextSpan(
                                          text: "Terms and Conditions",
                                          style: const TextStyle(
                                            color: cyan100,
                                            // decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // Navigate to Terms and Conditions page
                                              },
                                        ),
                                        const TextSpan(
                                          text: " and that you have read our ",
                                        ),
                                        TextSpan(
                                          text: "Privacy Policy",
                                          style: const TextStyle(
                                            color: cyan100,
                                            // decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // Navigate to Privacy Policy page
                                            },
                                        ),
                                        const TextSpan(text: "."),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // end of checkbox
                            const SizedBox(height: 20),
                            Button(
                              text: "Submit",
                              isLoading: signupWatch.isLoading,
                              onPressed: () async {
                                signupRead.signUp(context);
                              },
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  text: "Have an account? ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Login",
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            red, // Highlight the clickable text
                                        fontWeight: FontWeight.w400,
                                        // decoration: TextDecoration.underline,
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

                           
                          ],
                        ),
                      ),
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
      ),
    ));
  }
}
