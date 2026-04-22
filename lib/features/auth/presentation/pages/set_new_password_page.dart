import 'package:clases_fit_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:flutter/material.dart';

class SetNewPasswordPage extends StatelessWidget {
  const SetNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Set New Password Page'),
            SizedBox(height: size.height * 0.05),
            AuthBackButton(size: size, name: 'Volver a Login -->'),
          ],
        ),
      ),
    );
  }
}
