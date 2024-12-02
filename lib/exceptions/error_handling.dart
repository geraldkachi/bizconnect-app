import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:dio/dio.dart';

mixin ErrorHandling {
  void handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      throw BizException(
          message:
              "Opps, this is taking too long. Check your network and try again.");
    }

    if (e.type == DioExceptionType.connectionError) {
      throw BizException(
          message: "Please check your internet connection and try again.");
    }

    if (e.type == DioExceptionType.unknown) {
      throw BizException(
          message: "Something occured at this time. Please try again.");
    }

    if (e.response?.statusCode == 500) {
      throw BizException(message: "Service is unavailable at this time.");
    }

    if (e.response!.statusCode! >= 400) {
      throw BizException(message: e.response?.data['message']);
    }
  }
}
