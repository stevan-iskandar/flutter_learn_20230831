import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learn_20230831/src/api/api_auth.dart';
import 'package:flutter_learn_20230831/src/constants/storage.dart';
import 'package:flutter_learn_20230831/src/models/user.dart';
import 'package:flutter_learn_20230831/src/screens/grocery_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? token;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(Storage.token);
    if (token != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const GroceryListScreen()),
      );
    }
    print('initState $token');
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  final _formKey = GlobalKey<FormState>();

  var _username = '';
  var _password = '';

  _login() async {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();

    try {
      final response = await const ApiAuth().login(User(
        username: _username,
        password: _password,
      ));

      if (response.statusCode == 200) {
        final Map body = json.decode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(Storage.token, body['data']['token']);
      }

      throw Exception(response.body);
    } on Exception catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(24),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Username'),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Must be filled';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _username = value!;
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(label: Text('Password')),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Must be filled';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          onPressed: _login,
                          child: const Text('Add Item'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
