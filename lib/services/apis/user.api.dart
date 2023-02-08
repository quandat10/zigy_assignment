import 'package:flutter/foundation.dart';
import 'package:zigy_assignment/services/dio_client.dart';

import '../endpoints.dart';
import '../models/user.model.dart';

class UserApi {
  final DioClient _dioClient;

  UserApi(this._dioClient);

  Future<ListUserModel> getListUser() async {
    try {
      final res = await _dioClient.get(Endpoints.listUsersUrl);

      return ListUserModel.fromJson(res);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future<UserCreateModel> newUserApi(Map<String, dynamic> data) async {
    try {
      final res = await _dioClient.post(Endpoints.newUserApi, data: data);
      return UserCreateModel.fromJson(res);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }
}
