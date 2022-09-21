import 'package:flutter/material.dart';

class UnderlineTextBox extends StatelessWidget {
  UnderlineTextBox({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChange,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.grey[800]),
      onChanged: onChange,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
      ),
    );
  }
} //ec