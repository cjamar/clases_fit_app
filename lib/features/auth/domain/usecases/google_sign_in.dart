import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class GoogleSignIn {
  final AuthRepository repository;
  GoogleSignIn(this.repository);

  Future<AuthSession> call() => repository.signInWithGoogle();
}
