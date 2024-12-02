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

class MyBusinessPage extends ConsumerStatefulWidget {
  const MyBusinessPage({
    super.key,
  });

  @override
  ConsumerState<MyBusinessPage> createState() => _MyBusinessPageState();
}

class _MyBusinessPageState extends ConsumerState<MyBusinessPage> {
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
            child: Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Container(
                  color: cyan100,
                  child: Expanded(
                  child: 
                 Text('MyBusinessPage'),
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
              ]),
            )),
      ),
    ));
  }
}
