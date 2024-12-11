import 'dart:developer';

import 'package:bizconnect/models/business%20details_model.dart';
import 'package:bizconnect/models/my_business_list.dart';
import 'package:bizconnect/models/profile_business.dart';
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

  final ToastService _toastService = getIt<ToastService>();
  MyBusinessListModel businessList = MyBusinessListModel();
  List<Map<String, dynamic>> businessListData = [];
  BusinessProfileDetailModel? businessDetails;
  // String? businessDetails;

 
  bool isLoading = false;

  // final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> allBusinessList(BuildContext context) async {
    try {
        isLoading = true;
        notifyListeners();
         businessList = await _myBusinessService.allBusinessList();
            businessListData = businessList.data!.businessProfiles.map((e) => {
             'uuid': e.uuid, 
            'userUuid': e.userUuid,
            'name': e.name,
            'description': e.description,
            'businessCategoryUuid': e.businessCategoryUuid,
            'country': e.country,
            'stateAndProvince': e.stateAndProvince,
            'city': e.city,
            'street': e.street,
            'postalCode': e.postalCode,
            'logoUrl': e.logoUrl,
            'imageUrl': e.imageUrl,
            'croppedImageUrl': e.croppedImageUrl,
            'phoneNumber': e.phoneNumber,
            'businessEmail': e.businessEmail,
            'openTime': e.openTime,
            'closeTime': e.closeTime,
            'daysOfOperation': e.daysOfOperation,
            'websiteUrl': e.websiteUrl,
            'linkedinUrl': e.linkedinUrl,
            'instagramUrl': e.instagramUrl,
            'twitterUrl': e.twitterUrl,
            'facebookUrl': e.facebookUrl,
            'createdUtc': e.createdUtc,
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
  // getBusinessDetails

 Future<void> fetchBusinessDetails(BuildContext context, {required String id}) async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await _myBusinessService.getBusinessDetails(id);
   
        log('biz details ${result.toJson()}');
      businessDetails = BusinessProfileDetailModel.fromJson(result.toJson());
      notifyListeners();
        // print('result biz details $result');
      // businessDetails = result['data'];
    } on BizException catch (e) {
      isLoading = false;
      notifyListeners();
      log('err $e');
      _toastService.showToast(context,
          title: 'Error  new', subTitle: e.message ?? '');
    } catch (e) {
      isLoading = false;
      notifyListeners();
      _toastService.showToast(context,
          title: 'Error business', subTitle: '$e.message Something went wrong.');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
