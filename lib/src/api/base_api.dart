import 'package:flutter_learn_20230831/src/api/api.dart';

class BaseApi extends Api {
  const BaseApi({this.url}) : super();

  final String? url;
}
