import 'package:clases_fit_app/features/auth/domain/usecases/reset_password.dart';
import 'package:clases_fit_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clases_fit_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:clases_fit_app/features/auth/presentation/pages/register_page.dart';
import 'package:clases_fit_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_email_field.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_footer.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/auth_google_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final ValueNotifier<bool> _isValid = ValueNotifier(false);
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validate);
    _passwordController.addListener(_validate);
    _emailFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _isValid.dispose();
    super.dispose();
  }

  void _validate() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final isValid =
        email.isNotEmpty &&
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email) &&
        password.isNotEmpty;

    _isValid.value = isValid;
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      LoginRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        rememberMe: _rememberMe,
      ),
    );
  }

  void _goToRegister() => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const RegisterPage()),
  );

  void _goToResetPassword() => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
  );

  _googleSignIn() => context.read<AuthBloc>().add(GoogleLoginRequested());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.yellow,
        body: _loginBody(context, size),
      ),
    );
  }

  _loginBody(BuildContext context, size) => SizedBox(
    height: size.height,
    width: size.width,
    child: Column(children: [_logoArea(size), _formArea(context, size)]),
  );

  _logoArea(Size size) => SizedBox(
    height: size.height * 0.35,
    child: Center(child: Icon(Icons.logo_dev, size: size.width * 0.15)),
  );

  _formArea(BuildContext context, Size size) => Container(
    height: size.height * 0.65,
    width: size.width,
    color: Colors.white,
    child: Form(
      key: _formKey,
      child: AuthForm(
        fields: [
          AuthEmailField(
            controller: _emailController,
            focusNode: _emailFocus,
            size: size,
          ),
          SizedBox(height: size.height * 0.04),
          AuthPasswordField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            size: size,
          ),
          SizedBox(height: size.height * 0.04),
          AuthFooter(
            onRegisterTap: _goToRegister,
            onForgotPasswordTap: _goToResetPassword,
            rememberMe: _rememberMe,
            onRememberChanged: (value) => setState(() {
              _rememberMe = value;
            }),
            size: size,
          ),
          SizedBox(height: size.height * 0.04),
          AuthGoogleButton(onPressed: _googleSignIn, size: size),
        ],
        submitButton: ValueListenableBuilder<bool>(
          valueListenable: _isValid,
          builder: (context, isValid, child) => AuthSubmitButton(
            text: 'Iniciar Sesión',
            onPressed: isValid ? _onSubmit : null,
            size: size,
          ),
        ),
      ),
    ),
  );
}
