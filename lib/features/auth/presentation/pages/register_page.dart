import 'package:clases_fit_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clases_fit_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:clases_fit_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_email_field.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_name_field.dart';
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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final ValueNotifier<bool> _isValid = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validate);
    _emailController.addListener(_validate);
    _passwordController.addListener(_validate);
    _confirmPasswordController.addListener(_validate);
    _nameController.addListener(() => setState(() {}));
    _emailFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
    _confirmPasswordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _validate() {
    final userName = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    final userNameValid = userName.isNotEmpty && userName.length >= 3;
    final emailValid =
        email.isNotEmpty && RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);

    final passwordValid = password.isNotEmpty && password.length >= 6;
    final confirmPasswordValid = confirmPassword == password;

    _isValid.value =
        userNameValid && emailValid && passwordValid && confirmPasswordValid;
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      RegisterRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _capitalizer(_nameController.text.trim()),
      ),
    );
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  String _capitalizer(String text) => text.isNotEmpty
      ? text[0].toUpperCase() + text.substring(1).toLowerCase()
      : text;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              _showSnackbar('Cuenta creada!!!', Colors.green);
              context.read<AuthBloc>().add(LoginView());
            }
            if (state is AuthError) {
              _showSnackbar('Error, ${state.message}', Colors.red);
            }
          },
          child: _registerBody(size),
        ),
      ),
    );
  }

  _registerBody(Size size) => SingleChildScrollView(
    child: Column(children: [_imageRegisterArea(size), _formArea(size)]),
  );

  _imageRegisterArea(Size size) => SizedBox(
    width: size.width * 0.8,
    height: size.height * 0.35,
    child: Center(child: Icon(Icons.key, size: size.width * 0.15)),
  );

  _formArea(Size size) => Container(
    height: size.height * 0.65,
    width: size.width,
    color: Colors.white,
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          AuthForm(
            fields: [
              AuthNameField(
                controller: _nameController,
                focusNode: _nameFocus,
                size: size,
              ),
              SizedBox(height: size.height * 0.025),
              AuthEmailField(
                controller: _emailController,
                focusNode: _emailFocus,
                size: size,
              ),
              SizedBox(height: size.height * 0.025),
              AuthPasswordField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                size: size,
              ),
              SizedBox(height: size.height * 0.025),
              AuthPasswordField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocus,
                label: 'Confirmar contraseña',
                size: size,
              ),
              SizedBox(height: size.height * 0.045),
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

  _showSnackbar(String message, Color color) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
}
