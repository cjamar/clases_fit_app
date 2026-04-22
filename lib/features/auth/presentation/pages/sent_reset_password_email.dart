import 'package:clases_fit_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class SentResetPasswordEmail extends StatelessWidget {
  const SentResetPasswordEmail({super.key});

  _backToLogin(BuildContext context) =>
      context.read<AuthBloc>().add(LoginView());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [_imageSentEmail(size), _textSentEmail(size)]),
            _acceptAndBackButton(size, context),
          ],
        ),
      ),
    );
  }

  _imageSentEmail(Size size) => SizedBox(
    width: size.width * 0.8,
    height: size.height * 0.3,
    child: Center(child: Icon(Icons.mark_email_read, size: size.width * 0.15)),
  );

  _textSentEmail(Size size) => SizedBox(
    width: size.width * 0.8,
    height: size.height * 0.15,
    child: Center(
      child: Text(
        'Te hemos enviado instrucciones para reestablecer tu contraseña \n Comprueba tu correo.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    ),
  );

  _acceptAndBackButton(Size size, BuildContext context) => SizedBox(
    width: size.width * 0.8,
    height: size.height * 0.05,
    child: ElevatedButton(
      onPressed: () => _backToLogin(context),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: Text('Aceptar'),
    ),
  );
}
