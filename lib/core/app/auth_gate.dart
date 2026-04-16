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
      if (state is AuthLoading || state is AuthInitialState) {
        return _loader();
      }

      if (state is AuthenticatedState) {
        return _homePage();
      }

      if (state is UnauthenticatedState) {
        return LoginPage();
      }
      if (state is AuthError) {
        return _errorScreen(state.message);
      }

      return LoginPage();
    },
  );

  _errorScreen(String message) => Scaffold(
    body: Center(
      child: Column(
        children: [
          Icon(Icons.error),
          SizedBox(height: 12),
          Text('AuthError, $message'),
        ],
      ),
    ),
  );

  _loader() => Scaffold(body: Center(child: CircularProgressIndicator()));

  _homePage() => Scaffold(
    backgroundColor: Colors.greenAccent,
    body: Center(child: Text('HomePage')),
  );
}
