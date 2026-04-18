import 'package:clases_fit_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      if (state is AuthenticatedState) {
        return _homePage(context);
      }
      if (state is UnauthenticatedState) {
        return LoginPage();
      }
      return LoginPage();
    },
  );

  _homePage(BuildContext context) => Scaffold(
    backgroundColor: Colors.greenAccent,
    body: Center(
      child: TextButton(
        onPressed: () => _logOut(context),
        style: TextButton.styleFrom(backgroundColor: Colors.white),
        child: Text('Pulsar para Logout ->'),
      ),
    ),
  );

  void _logOut(BuildContext context) =>
      context.read<AuthBloc>().add(LogoutRequested());
}
