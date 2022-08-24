import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'screens/HomeScreen.dart';

class Store extends ChangeNotifier {
  int _data1 = 0;
  int get data1 => _data1;
  void setData1(int data1) {
    _data1 = data1;
  } //ef

} //ec

main() {
  return runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => Store(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
} //ef