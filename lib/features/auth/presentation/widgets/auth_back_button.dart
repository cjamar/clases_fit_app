import 'package:flutter/material.dart';

class AuthBackButton extends StatelessWidget {
  final Size size;
  final String name;
  const AuthBackButton({super.key, required this.size, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.05,
      width: size.width,

      child: TextButton(
        style: TextButton.styleFrom(shape: RoundedRectangleBorder()),
        onPressed: () => Navigator.pop(context),
        child: Text(name),
      ),
    );
  }
}
