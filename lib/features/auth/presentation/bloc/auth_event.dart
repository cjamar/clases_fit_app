import 'package:equatable/equatable.dart';
import '../../../user/domain/entities/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginRequested({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}

class LoginView extends AuthEvent {}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const RegisterRequested({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}

class RegisterView extends AuthEvent {}

class GoogleLoginRequested extends AuthEvent {}

class ResetPasswordRequested extends AuthEvent {
  final String email;
  const ResetPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordResetView extends AuthEvent {}

class PasswordRecoveryDetected extends AuthEvent {}

class PasswordResetCompleted extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class AuthStateChanged extends AuthEvent {
  final User? user;
  const AuthStateChanged(this.user);

  @override
  List<Object?> get props => [user];
}
