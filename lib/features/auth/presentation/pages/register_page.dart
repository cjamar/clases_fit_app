import 'package:clases_fit_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clases_fit_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_email_field.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_footer.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final ValueNotifier<bool> _isValid = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validate);
    _passwordController.addListener(_validate);
    _confirmPasswordController.addListener(_validate);
    _emailFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
    _confirmPasswordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _validate() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    final emailValid =
        email.isNotEmpty && RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);

    final passwordValid = password.isNotEmpty && password.length >= 6;
    final confirmPasswordValid = confirmPassword == password;

    _isValid.value = emailValid && passwordValid && confirmPasswordValid;
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      RegisterRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: 'user-name',
      ),
    );
  }

  void _backToLogin() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.orangeAccent,
        body: _registerBody(size),
      ),
    );
  }

  _registerBody(Size size) => SizedBox(
    width: size.width,
    height: size.height,
    child: Column(children: [_imageRegisterArea(size), _formArea(size)]),
  );

  _imageRegisterArea(Size size) => SizedBox(
    width: size.width * 0.8,
    height: size.height * 0.4,
    child: Center(child: Icon(Icons.key, size: size.width * 0.15)),
  );

  _formArea(Size size) => Container(
    height: size.height * 0.6,
    width: size.width,
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
              SizedBox(height: size.height * 0.04),
              AuthPasswordField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                size: size,
              ),
              SizedBox(height: size.height * 0.045),
              AuthPasswordField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocus,
                label: 'Confirmar contraseña',
                size: size,
              ),
              SizedBox(height: size.height * 0.055),
            ],
            submitButton: ValueListenableBuilder<bool>(
              valueListenable: _isValid,
              builder: (context, isValid, child) => AuthSubmitButton(
                text: 'Registrarme',
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
}
