//===> class: LoginScreen
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_management_application/components/LongButton.dart';
import 'package:task_management_application/screens/HomeScreen.dart';
import 'package:task_management_application/styles/AppStyle.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                controller: usernameController,
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
                controller: passwordController,
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
              press: () async {
                String verification = await LoginHttp();
                if (verification == "yes") {
                  //move to new creen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(verification),
                      );
                    },
                  );
                }
              },
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
      var dict1 = json.encode({
        "username": usernameController.text,
        "password": passwordController.text,
      });

      final response = await http.post(
          Uri.parse("http://192.168.183.221:1880/taskmanagementlogin"),
          headers: {"Content-Type": 'application/json'},
          body: dict1);
      print(response.statusCode);
      print(response.body);
      var result = json.decode(response.body);
      if (result["status"] == "valid") {
        return "yes";
      } else {
        return "no";
      }
    } catch (ex) {
      print(ex);
      return "bad";
    }
  } //ef
} //ec
