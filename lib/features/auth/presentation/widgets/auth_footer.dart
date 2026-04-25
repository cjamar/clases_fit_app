import 'package:clases_fit_app/core/theme/styles_app.dart';
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
        activeColor: StylesApp.primaryColor,
      ),
      Text('Recordarme'),
    ],
  );

  _forgotPasswordButton(Size size) => TextButton(
    onPressed: onForgotPasswordTap,
    child: Text(
      '¿Olvidaste la contraseña?',
      style: TextStyle(color: StylesApp.primaryColor),
    ),
  );

  _registerNowButton(Size size) => TextButton(
    style: TextButton.styleFrom(
      backgroundColor: StylesApp.primaryColorLight,
      foregroundColor: StylesApp.primaryColor,
      padding: EdgeInsets.symmetric(
        vertical: size.width * 0.025,
        horizontal: size.width * 0.04,
      ),
    ),
    onPressed: onRegisterTap,
    child: Text('Crea una cuenta'),
  );
}
