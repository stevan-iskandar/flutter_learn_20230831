import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_learn_20230831/src/app.dart';

void main() async {
  await dotenv.load();

  runApp(const MyApp());
}
