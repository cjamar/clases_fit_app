import 'package:clases_fit_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clases_fit_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_form.dart';
import '../widgets/auth_password_field.dart';
import '../widgets/auth_submit_button.dart';

class SetNewPasswordPage extends StatefulWidget {
  const SetNewPasswordPage({super.key});

  @override
  State<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final ValueNotifier<bool> _isValid = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validate);
    _confirmPasswordController.addListener(_validate);
    _passwordFocus.addListener(() => setState(() {}));
    _confirmPasswordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _validate() {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    final passwordValid = password.isNotEmpty && password.length >= 6;
    final confirmPasswordValid = confirmPassword == password;

    _isValid.value = passwordValid && confirmPasswordValid;
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      UpdatePasswordRequested(_passwordController.text.trim()),
    );

    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.purpleAccent,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is PasswordUpdatedState) {
              _showSnackbar('Contraseña actualizada!!!', Colors.green);
              context.read<AuthBloc>().add(LoginView());
            }
            if (state is AuthError) {
              _showSnackbar('Error, ${state.message}', Colors.red);
            }
          },
          child: _setNewPasswordBody(size),
        ),
      ),
    );
  }

  _setNewPasswordBody(Size size) => SingleChildScrollView(
    child: Column(children: [_imageRegisterArea(size), _formArea(size)]),
  );

  _imageRegisterArea(Size size) => SizedBox(
    width: size.width * 0.8,
    height: size.height * 0.35,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.password, size: size.width * 0.15),
        Text('Cambia tu contraseña'),
      ],
    ),
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
              SizedBox(height: size.height * 0.23),
            ],
            submitButton: ValueListenableBuilder<bool>(
              valueListenable: _isValid,
              builder: (context, isValid, child) => AuthSubmitButton(
                text: 'Actualizar Contraseña',
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
