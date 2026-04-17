import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class AuthGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Size size;
  const AuthGoogleButton({
    super.key,
    required this.onPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(size.width * 0.07),
      ),
      height: size.height * 0.05,
      width: size.width * 0.8,
      child: SignInButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(size.width * 0.07),
        ),
        Buttons.google,
        text: "Continuar con Google",
        onPressed: onPressed,
      ),
    );
  }
}
