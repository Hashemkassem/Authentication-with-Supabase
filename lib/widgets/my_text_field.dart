// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController stringController;
  final String text;
  final bool obscure;
  const MyTextField({
    Key? key,
    required this.text,
    required this.stringController,
    required this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: stringController,
      decoration: InputDecoration(labelText: text.toString()),
      obscureText: obscure,
    );
  }
}
