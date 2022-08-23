import 'package:flutter/material.dart';

main() {
  return runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
} //ef

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(title: const Text("AppBar"), actions: []),
      //body
      body: Container(),
    );
  } //ef

}//ec