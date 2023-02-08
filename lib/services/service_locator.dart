import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'apis/user.api.dart';
import 'dio_client.dart';
import 'network_module.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // singletons:----------------------------------------------------------------
  getIt.registerSingleton<Dio>(NetworkModule.provideDio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  //
  // // apis:---------------------------------------------------------------------
  getIt.registerSingleton(UserApi(getIt<DioClient>()));
}
