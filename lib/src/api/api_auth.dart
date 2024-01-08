import 'dart:convert';

import 'package:flutter_learn_20230831/src/api/base_api.dart';
import 'package:flutter_learn_20230831/src/models/user.dart';
import 'package:http/http.dart' as http;

class ApiAuth extends BaseApi {
  const ApiAuth();

  Future<http.Response> login(User credentials) async {
    return super.post(
      'login',
      body: json.encode({
        'username': credentials.username,
        'password': credentials.password,
      }),
    );
  }
}
