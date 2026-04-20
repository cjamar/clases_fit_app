import 'package:clases_fit_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clases_fit_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:clases_fit_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:clases_fit_app/features/auth/presentation/pages/sent_reset_password_email.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_email_field.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();
  final ValueNotifier<bool> _isValid = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validate);
    _emailFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    _isValid.dispose();
    super.dispose();
  }

  void _validate() {
    final email = _emailController.text.trim();
    final isValid =
        email.isNotEmpty && RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);

    _isValid.value = isValid;
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      ResetPasswordRequested(email: _emailController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.redAccent,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              _snackbar(state.message);
            }
            if (state is PasswordResetEmailSentState) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SentResetPasswordEmail()),
              );
            }
          },
          builder: (context, state) {
            return _resetPasswordBody(context, size);
          },
        ),
      ),
    );
  }

  _resetPasswordBody(BuildContext context, Size size) => SizedBox(
    height: size.height,
    width: size.width,
    child: Column(
      children: [
        _imageResetArea(size),
        _textResetArea(size),
        _formArea(context, size),
      ],
    ),
  );

  _imageResetArea(Size size) => SizedBox(
    width: size.width * 0.8,
    height: size.height * 0.4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.build, size: size.width * 0.15),
        SizedBox(height: size.height * 0.025),
        Text(
          'Restablecer contraseña se encuentra actualmente en construcción',
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  _textResetArea(size) => Container(
    width: size.width,
    height: size.height * 0.15,
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
    color: Colors.white,
    child: Center(
      child: Text(
        'Escribe tu email y te enviaremos las instrucciones para reestablecer tu contraseña',
        textAlign: TextAlign.center,
      ),
    ),
  );

  _formArea(BuildContext context, Size size) => Container(
    width: size.width,
    height: size.height * 0.45,
    color: Colors.white,
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          AuthForm(
            fields: [
              AuthEmailField(
                controller: _emailController,
                focusNode: _emailFocus,
                size: size,
              ),
              SizedBox(height: size.height * 0.12),
            ],
            submitButton: ValueListenableBuilder<bool>(
              valueListenable: _isValid,
              builder: (context, isValid, child) => AuthSubmitButton(
                text: 'Enviar email',
                onPressed: isValid ? _onSubmit : null,
                size: size,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          AuthBackButton(size: size, name: 'Volver a Login'),
        ],
      ),
    ),
  );

  _snackbar(String message) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text('Error, $message')));
}
