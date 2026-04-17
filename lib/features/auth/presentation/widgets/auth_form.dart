import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final List<Widget> fields;
  final Widget submitButton;
  const AuthForm({super.key, required this.fields, required this.submitButton});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        ...fields,
        SizedBox(height: size.height * 0.025),
        submitButton,
      ],
    );
  }
}
