import 'dart:developer';

import 'package:bizconnect/models/my_business_list.dart';
import 'package:bizconnect/service/my_business_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/app/router.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/models/error_model.dart';
import 'package:bizconnect/service/auth_service.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:bizconnect/service/toast_service.dart';

final myBusinessViewModelProvider =
    ChangeNotifierProvider.autoDispose<MyBusinessViewModel>(
        (ref) => MyBusinessViewModel());

class MyBusinessViewModel extends ChangeNotifier {
    final MyBusinessService _myBusinessService = getIt<MyBusinessService>();

  // final AuthService _authService = getIt<AuthService>();
  final ToastService _toastService = getIt<ToastService>();
  // String jsonString = // Your JSON string here
  // MyBusinessList businessList = myBusinessListFromJson(jsonString);  
  MyBusinessListModel businessList = MyBusinessListModel();
  List<Map<String, dynamic>> businessListData = [];
 
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  Future allBusinessList(context) async {
    try {
        isLoading = true;
        notifyListeners();
         businessList = await _myBusinessService.allBusinessList();
            businessListData = businessList.data!.businessProfiles.map((e) => {
              'uuid': e.uuid, 
              'name': e.name,
              'description': e.description
              }).toList(); 

        log('business list $businessList');
         notifyListeners();
          
        isLoading = false;
        notifyListeners();
    
    } on BizException catch (e) {
      isLoading = false;
      notifyListeners();
      _toastService.showToast(context,
          title: 'Error', subTitle: e.message ?? '');
    } catch (e) {
      isLoading = false;
      notifyListeners();
      _toastService.showToast(context,
          title: 'Error business', subTitle: '$e.message Something went wrong.');
    }
  }

}
