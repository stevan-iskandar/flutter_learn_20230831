import 'package:flutter_learn_20230831/src/api/base_api.dart';

class ApiGrocery extends BaseApi {
  const ApiGrocery() : super(url: 'grocery');

  dataTable() async {
    return super.get('$url/');
  }
}
