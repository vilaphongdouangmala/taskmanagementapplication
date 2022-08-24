import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/styles/AppColor.dart';

import '../main.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //store reference
    var store = Provider.of<Store>(context);
    return Scaffold(
      //appBar
      appBar: AppBar(
        title: const Text("AppBar"),
        backgroundColor: AppColor.primaryRed,
        actions: [],
      ),
      //body
      body: Container(),
    );
  } //ef
}//ec