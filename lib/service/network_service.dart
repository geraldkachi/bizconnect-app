import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:bizconnect/exceptions/error_handling.dart';
import 'package:bizconnect/interceptors/app_interceptors.dart';

class NetworkService with ErrorHandling {
  late final Dio dio;

  late final Dio? altDio;

  final String url = "https://devbackend.bizconnect24.com";

  NetworkService() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(minutes: 2),
        sendTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
      ),
    );
    if (kDebugMode) {
      dio.interceptors.addAll([
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: false,
          requestBody: true,
        ),
        AppInterceptor(),
      ]);
    }
    dio.interceptors.add(AppInterceptor());

    altDio = Dio();
  }

  Future getAlt(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await altDio!.get(
        path,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      handleError(e);
    }
  }

  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.get(
        path,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      handleError(e);
    }
  }

  Future delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      handleError(e);
    }
  }

  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      handleError(e);
    }
  }

  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      handleError(e);
    }
  }
}


// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:bizconnect/exceptions/error_handling.dart';

// class NetworkService with ErrorHandling {
//   late final Dio dio;
//   late final Dio? altDio;
//   final String url = "https://devbackend.bizconnect24.com";
  
//   final storage = FlutterSecureStorage();  // Storage for token retrieval

//   NetworkService() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: url,
//         connectTimeout: const Duration(minutes: 1),
//       ),
//     );

//     // You can add logging and other configuration here if necessary
//     if (kDebugMode) {
//       dio.interceptors.add(LogInterceptor(
//         responseBody: true,
//         error: true,
//         requestHeader: true,
//         responseHeader: false,
//         request: false,
//         requestBody: true,
//       ));
//     }

//     altDio = Dio();
//   }

//   // Fetch the token from storage dynamically
//   Future<String?> getToken() async {
//     return await storage.read(key: 'biz_token');
//   }

//   // GET method with token-based authorization
//   Future get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       String? token = await getToken();  // Get the token dynamically
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//       }

//       Response response = await dio.get(
//         path,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       handleError(e);  // Handle error
//     }
//   }

//   // POST method with token-based authorization
//   Future post(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       String? token = await getToken();  // Get token dynamically
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//       }

//       Response response = await dio.post(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       handleError(e);  // Handle error
//     }
//   }

//   // Additional methods (DELETE, PATCH) follow a similar pattern
//   Future delete(
//     String path, {
//     Map<String, dynamic>? data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       String? token = await getToken();  // Fetch token dynamically
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//       }

//       Response response = await dio.delete(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       handleError(e);  // Handle error
//     }
//   }

//   Future patch(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       String? token = await getToken();  // Retrieve token
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//       }

//       Response response = await dio.patch(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       handleError(e);  // Handle error
//     }
//   }
// }

