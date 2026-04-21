import '../repositories/auth_repository.dart';

class GoogleSignIn {
  final AuthRepository repository;
  GoogleSignIn(this.repository);

  Future<void> call() => repository.signInWithGoogle();
}
