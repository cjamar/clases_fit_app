import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class SignUp {
  final AuthRepository repository;
  SignUp(this.repository);

  Future<AuthSession> call({
    required String email,
    required String password,
    required String name,
  }) {
    return repository.signUp(email: email, password: password, name: name);
  }
}
