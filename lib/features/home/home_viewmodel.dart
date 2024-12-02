import 'dart:developer';

// import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:bizconnect/models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/app/router.dart';
import 'package:bizconnect/features/main_screen/main_screen_view_model.dart';
import 'package:bizconnect/service/auth_service.dart';
import 'package:bizconnect/service/navigator_service.dart';

import 'package:bizconnect/service/toast_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final homeViemodelProvider =
    ChangeNotifierProvider.autoDispose<HomeViemodel>((ref) => HomeViemodel());

class HomeViemodel extends ChangeNotifier {
  // final DashboardService _dashboardService = getIt<DashboardService>();
  final AuthService _authService = getIt<AuthService>();
  final ToastService _toastService = getIt<ToastService>();
  final NavigatorService _navigatorService = getIt<NavigatorService>();
  
  TextEditingController searchController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  RefreshController transactionRefreshController =
      RefreshController(initialRefresh: false);

  // List<Transaction>? filteredTransactions = [];
  // Transaction? selectedTransaction;
  List<String> states = [];
  // TransactionList get transactionList => _dashboardService.transactionList!;

  List<String> stateLga = [];
  AuthModel get userData => _authService.userData ?? AuthModel();


  double? incomePercentageIncrease;
  double? expensePercentageDecrease;

  String? selectedState;
  String? selectedLga;
  String? fromDate;
  String? toDate;

  String? selectedIncomeChartType = 'Line';
  String? selectedExpenseChartType = 'Line';
  String? statusValue = '';

  bool isStatusWidget = false;
  bool isResolved = false;
  bool isStatusDropdown = false;
  double bottomSheetHeight = 0.82;

  bool isLoadingBooking = false;
  bool isLoadingTransaction = false;
  bool isLoadingIncomeAnalysis = false;
  bool isLoadingExpenseAnalysis = false;
  bool isLoadingExpenseCategory = false;
  bool isLoadingSummary = false;
  bool isLoadingFacilities = false;

  bool isShareLoading = false;
  bool isDeleted = false;
  bool isShowDeleted = false;
  bool isStatus = false;

  bool onInit = false;
  bool hideAmounts = false;
  bool isReasonVisible = false;

  int? screenIndex;

  void navToAdmin() {
    screenIndex = 2;
    _navigatorService.currentIndex = screenIndex!;
    notifyListeners();
    screenIndex = null;
  }

  void navToFacilities() {
    screenIndex = 1;
    _navigatorService.currentIndex = screenIndex!;
    notifyListeners();
    screenIndex = null;
  }

  void onRefresh(context) {
    isShowDeleted = false;
    // fetchWalletData(context);
    refreshController.refreshCompleted();
    transactionRefreshController.refreshCompleted();
  }

  void logout() => _authService.logout();
}