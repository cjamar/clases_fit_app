import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;
  SignIn(this.repository);

  Future<AuthSession> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    return repository.signIn(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
