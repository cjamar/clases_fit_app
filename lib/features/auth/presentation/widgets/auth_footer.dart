import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final VoidCallback? onRegisterTap;
  final VoidCallback? onForgotPasswordTap;
  final Size size;
  const AuthFooter({
    super.key,
    this.onRegisterTap,
    this.onForgotPasswordTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  if (onForgotPasswordTap != null) _forgotPasswordButton(size),
            Text(
              '¿Todavia no te has registrado?',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(width: size.width * 0.03),
            if (onRegisterTap != null) _registerNowButton(size),
          ],
        ),
        _forgotPasswordButton(size),
      ],
    );
  }

  _forgotPasswordButton(Size size) => TextButton(
    onPressed: onForgotPasswordTap,
    child: Text(
      '¿Olvidaste la contraseña?',
      style: TextStyle(color: Colors.blue),
    ),
  );

  _registerNowButton(Size size) => TextButton(
    style: TextButton.styleFrom(
      backgroundColor: Colors.grey.shade200,
      padding: EdgeInsets.symmetric(
        vertical: size.width * 0.01,
        horizontal: size.width * 0.05,
      ),
    ),
    onPressed: onRegisterTap,
    child: Text('Crea una cuenta'),
  );
}
