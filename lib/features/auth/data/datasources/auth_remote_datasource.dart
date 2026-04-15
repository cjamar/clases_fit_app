import '../../domain/entities/auth_session.dart';

abstract class AuthRemoteDatasource {
  Future<AuthSession> signUp(String email, String password, String name);
  Future<AuthSession> signIn(String email, String password);
  Future<AuthSession> signInWithGoogle();
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<AuthSession?> getCurrentSession();
}
