import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final VoidCallback? onRegisterTap;
  final VoidCallback? onForgotPasswordTap;
  final bool rememberMe;
  final ValueChanged<bool>? onRememberChanged;
  final Size size;
  const AuthFooter({
    super.key,
    this.onRegisterTap,
    this.onForgotPasswordTap,
    required this.rememberMe,
    this.onRememberChanged,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _registerArea(size),
        SizedBox(height: size.height * 0.02),
        _bottomArea(size),
      ],
    );
  }

  _registerArea(Size size) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      //  if (onForgotPasswordTap != null) _forgotPasswordButton(size),
      Text('¿Todavia no te has registrado?', style: TextStyle(fontSize: 13)),
      SizedBox(width: size.width * 0.03),
      if (onRegisterTap != null) _registerNowButton(size),
    ],
  );

  _bottomArea(Size size) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _rememberMeCheck(size),
      SizedBox(width: size.width * 0.05),
      _forgotPasswordButton(size),
    ],
  );

  _rememberMeCheck(Size size) => Row(
    children: [
      Checkbox(
        value: rememberMe,
        onChanged: (value) {
          if (value != null) onRememberChanged?.call(value);
        },
        shape: RoundedRectangleBorder(),
        activeColor: Color(0xffFF725E),
      ),
      Text('Recordarme'),
    ],
  );

  _forgotPasswordButton(Size size) => TextButton(
    onPressed: onForgotPasswordTap,
    child: Text(
      '¿Olvidaste la contraseña?',
      style: TextStyle(color: Color(0xffFF725E)),
    ),
  );

  _registerNowButton(Size size) => TextButton(
    style: TextButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 255, 235, 233),
      foregroundColor: Color.fromARGB(255, 197, 60, 42),
      padding: EdgeInsets.symmetric(
        vertical: size.width * 0.025,
        horizontal: size.width * 0.04,
      ),
    ),
    onPressed: onRegisterTap,
    child: Text('Crea una cuenta'),
  );
}
