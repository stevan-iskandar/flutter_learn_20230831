import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_learn_20230831/src/constants/env.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Api({this.url});

  final String? url;

  Uri _uri({Map<String, dynamic>? params}) {
    return Uri(
      scheme: dotenv.env[Env.apiScheme],
      host: dotenv.env[Env.apiHost],
      port: int.tryParse(dotenv.env[Env.apiPort] ?? '80'),
      path: 'api/$url',
      queryParameters: params,
    );
  }

  Future<Map<String, String>> _headers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers = {
        ...headers,
        'Authorization': 'Bearer $token',
      };
    }

    return headers;
  }

  Future<http.Response> get(
    String url, {
    Map<String, dynamic>? params,
  }) async {
    return http.get(
      _uri(
        params: params,
      ),
      headers: await _headers(),
    );
  }

  Future<http.Response> post(
    String url, {
    Map<String, dynamic>? params,
    Object? body,
  }) async {
    return http.post(
      _uri(
        params: params,
      ),
      headers: await _headers(),
      body: body,
    );
  }
}
