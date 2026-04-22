import 'package:equatable/equatable.dart';
import '../../../user/domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoading extends AuthState {}

class AuthenticatedState extends AuthState {
  final User user;
  const AuthenticatedState(this.user);
  @override
  List<Object?> get props => [user];
}

class LoginViewState extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterViewState extends AuthState {}

class UnauthenticatedState extends AuthState {}

class PasswordResetViewState extends AuthState {}

class PasswordResetEmailSentState extends AuthState {}

class PasswordRecoveryState extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}
