//===> class: LoginScreen
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_management_application/components/LongButton.dart';
import 'package:task_management_application/styles/AppStyle.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(
          AppStyle.defaultPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //username
            Padding(
              padding: EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.7),
              child: TextField(
                //controller: TextEditingController(text:'data'),
                style: TextStyle(color: Colors.grey[800]),
                onChanged: (String text) {},
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Username',
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            //password
            Padding(
              padding: EdgeInsets.only(bottom: AppStyle.defaultPadding),
              child: TextField(
                //controller: TextEditingController(text:'data'),
                style: TextStyle(color: Colors.grey[800]),
                onChanged: (String text) {},
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            //login button
            LongButton(
              press: () {},
              text: 'Login',
            ),
          ],
        ),
      ),
    );
  } //ef

  //Login function
  Future<String> LoginHttp() async {
    try {
      var dict1 =
          json.encode({"userName": "root@localhost.com", "password": "1234"});

      final response = await http.post(
          Uri.parse("http://192.168.1.2:1974/api/Account/Login"),
          headers: {"Content-Type": 'application/json'},
          body: dict1);
      print(response.statusCode);
      print(response.body);
      var result = json.decode(response.body);
      return "yes";
    } catch (ex) {
      print(ex);
      return "bad";
    }
  } //ef
} //ec
