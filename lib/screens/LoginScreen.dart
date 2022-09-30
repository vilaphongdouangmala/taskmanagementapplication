//===> class: LoginScreen
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_management_application/components/LongButton.dart';
import 'package:task_management_application/main.dart';
import 'package:task_management_application/screens/HomeScreen.dart';
import 'package:task_management_application/styles/AppStyle.dart';
import 'package:http/http.dart' as http;

import '../styles/AppColor.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
            ),
            child: SizedBox(
              width: double.infinity,
              height: screenSize.height,
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: Icon(
                      Icons.blur_on,
                      color: Colors.white,
                      size: 90,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: screenSize.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 60, bottom: 50),
                      child: Text(
                        "Login",
                        style: AppStyle.loginHeader,
                      ),
                    ),
                    // =====================  username =====================
                    SizedBox(
                      width: screenSize.width * 0.75,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: usernameController,
                          style: AppStyle.loginText,
                          onChanged: (String text) {},
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColor.primaryColor,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            hintText: "username",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: AppColor.primaryColor,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // =====================  end username =====================
                    ),
                    // =====================  password =====================
                    SizedBox(
                      width: screenSize.width * 0.75,
                      child: TextField(
                        controller: passwordController,
                        style: AppStyle.loginText,
                        onChanged: (String text) {},
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                            color: AppColor.primaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          hintText: "password",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: AppColor.primaryColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // =====================  end password =====================
                    SizedBox(
                      width: screenSize.width * 0.75,
                      height: screenSize.height * 0.08,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColor.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            // await verifylogin(username, password, context);
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        "Don't have any account? Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

//login button
  // LongButton(
  //   press: () async {
  //     String verification = await LoginHttp();
  //     if (verification == "yes") {
  //       //move to new creen
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => HomeScreen(),
  //         ),
  //       );
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             content: Text(verification),
  //           );
  //         },
  //       );
  //     }
  //   },
  //   text: 'Login',
  // ),

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

Future<void> verifylogin(cusername, cpassword, context) async {
  //1. define url
  var url = "http://10.120.137.60:1880/login";

  //2. convert list of objects to list of dictionary

  var data = {
    "username": cusername.text,
    "password": cpassword.text,
  };
  //3. send request along with the data
  //headers is required
  //data need to be encoded to json text
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-type': 'application/json'},
    body: json.encode(data),
  );
  var result = response.body;

  print(result);

  var dict = json.decode(result);
  if (dict["message"] == "matched") {
    String firstName = dict["data"]["firstName"];
    String lastName = dict["data"]["lastName"];
    //move to the second screen

    //move to new screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppMain(
            // firstName: firstName,
            // lastName: lastName,
            ),
      ),
    );
  } else {
    print('try again');
    cusername.text = "";
    cpassword.text = "";
  }
} //ef
