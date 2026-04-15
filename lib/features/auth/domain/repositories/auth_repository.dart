import '../entities/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<AuthSession> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  });
  Future<AuthSession> signInWithGoogle();
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<AuthSession?> getCurrentSession();
}
