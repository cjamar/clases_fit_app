import 'package:clases_fit_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clases_fit_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        onPressed: () => context.read<AuthBloc>().add(LoginView()),
        child: Text(name),
      ),
    );
  }
}
