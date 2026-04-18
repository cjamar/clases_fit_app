import 'package:clases_fit_app/features/auth/domain/entities/auth_session.dart';
import 'package:clases_fit_app/features/user/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabase;
  AuthRemoteDatasourceImpl(this.supabase);

  @override
  Future<AuthSession> signUp(String email, String password, String name) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );

    final user = response.user!;
    return AuthSession(
      user: UserModel.fromSupabaseUser(user),
      rememberMe: true,
    );
  }

  @override
  Future<AuthSession> signIn(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user!;
    return AuthSession(
      user: UserModel.fromSupabaseUser(user),
      rememberMe: true,
    );
  }

  @override
  Future<AuthSession> signInWithGoogle() async {
    await supabase.auth.signInWithOAuth(OAuthProvider.google);

    final user = supabase.auth.currentUser!;
    return AuthSession(
      user: UserModel.fromSupabaseUser(user),
      rememberMe: true,
    );
  }

  @override
  Future<void> signOut() async => await supabase.auth.signOut();

  @override
  Future<void> resetPassword(String email) async =>
      supabase.auth.resetPasswordForEmail(email);

  @override
  Future<AuthSession?> getCurrentSession() async {
    final user = supabase.auth.currentUser;

    if (user == null) return null;

    return AuthSession(
      user: UserModel.fromSupabaseUser(user),
      rememberMe: true,
    );
  }
}
