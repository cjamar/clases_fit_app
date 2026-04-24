import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class AuthSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Size size;
  const AuthSubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.05,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              disabledForegroundColor: Colors.white,
              backgroundColor: Color(0xffFF725E),
            ),
            child: isLoading ? const CircularProgressIndicator() : Text(text),
          ),
        );
      },
    );
  }
}
