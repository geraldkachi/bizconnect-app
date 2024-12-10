import 'package:bizconnect/service/my_business_service.dart';
import 'package:bizconnect/service/setup_profile_service.dart';
import 'package:get_it/get_it.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:bizconnect/service/auth_service.dart';
import 'package:bizconnect/service/navigator_service.dart';
import 'package:bizconnect/service/network_service.dart';
import 'package:bizconnect/service/toast_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());
  getIt.registerLazySingleton<ToastService>(() => ToastService());
  getIt.registerLazySingleton<MyBusinessService>(() => MyBusinessService());
  getIt.registerLazySingleton<ProfileBusinessService>(() => ProfileBusinessService());
  getIt.registerLazySingleton<NavigatorService>(() => NavigatorService());
  getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  print('get it setup successful');
}
