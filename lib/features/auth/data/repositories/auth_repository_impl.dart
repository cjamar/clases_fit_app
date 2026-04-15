import 'package:clases_fit_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:clases_fit_app/features/auth/domain/entities/auth_session.dart';
import 'package:clases_fit_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource datasource;
  AuthRepositoryImpl(this.datasource);

  @override
  Future<AuthSession> signUp({
    required String email,
    required String password,
    required String name,
  }) async => await datasource.signUp(email, password, name);

  @override
  Future<AuthSession> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final session = await datasource.signIn(email, password);
    return AuthSession(user: session.user, rememberMe: rememberMe);
  }

  @override
  Future<AuthSession> signInWithGoogle() async =>
      await datasource.signInWithGoogle();

  @override
  Future<void> signOut() async => datasource.signOut();

  @override
  Future<void> resetPassword(String email) async =>
      datasource.resetPassword(email);

  @override
  Future<AuthSession?> getCurrentSession() async =>
      datasource.getCurrentSession();
}
