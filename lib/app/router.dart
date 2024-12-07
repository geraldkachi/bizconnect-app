// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bizconnect/features/auth/forgot_password/forgot_password.dart';
import 'package:bizconnect/features/auth/login/login.dart';
import 'package:bizconnect/features/auth/sign_up/sign_up.dart';
import 'package:bizconnect/features/auth/verify-account/verify-account.dart';
import 'package:bizconnect/features/business/business_detail.dart';
import 'package:bizconnect/features/entry/entry.dart';
import 'package:bizconnect/features/setup-business-profile/setup-business-profile.dart';
import 'package:bizconnect/features/splashscreen/splashscreen.dart';
import 'package:bizconnect/features/main_screen/main_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/', // Start with SplashScreen
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(), routes: [
         GoRoute(
                path: 'entry',
                builder: (context, state) => EntryPage(),
              ),
      ]
    ),
    GoRoute(
      path: '/verify-account',
      builder: (context, state) => const VerifyPage(),
    ),
    GoRoute(
      path: '/setup-business-profile',
      builder: (context, state) => const SetupBusinessProfilePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(), routes: [
         GoRoute(
      path: 'forgot_password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
      ]
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),


  
    GoRoute(
      path: '/main_screen',
      builder: (context, state) => MainScreen(),
      routes: [
        GoRoute(
            path: 'business_details',
            builder: (context, state) => BusinessDetailPage(), 
            routes: [
              // GoRoute(
              //   path: 'record_inflow_payment',
              //   builder: (context, state) => RecordInflowPayment(),
              // ),
              // GoRoute(
              //   path: 'record_expense_payment',
              //   builder: (context, state) => RecordExpensePayment(),
              // ),
            ]),
        // GoRoute(
        //   path: 'add_admin',
        //   builder: (context, state) => AddAdminPage(),
        // ),
        // GoRoute(
        //   path: 'preferences',
        //   builder: (context, state) => PreferencesPage(),
        // ),
        // GoRoute(
        //   path: 'change_password',
        //   builder: (context, state) => ChangePassword(),
        // ),
        // GoRoute(
        //   path: 'line_manager',
        //   builder: (context, state) => LineManager(),
        // ),
        // GoRoute(
        //   path: 'privacy_policy',
        //   builder: (context, state) => PrivacyPolicy(),
        // ),
      ]
      ),
  ],
);
