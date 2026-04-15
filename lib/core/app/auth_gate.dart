import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      if (state is AuthLoading || state is AuthInitialState) {
        return _loader();
      }

      if (state is AuthenticatedState) {
        return const HomePage();
      }

      if (state is UnauthenticatedState) {
        return const LoginPage();
      }
      if (state is AuthError) {
        return _errorScreen(state.message);
      }

      return const LoginPage();
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
}
