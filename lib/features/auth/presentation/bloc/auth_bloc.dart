import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;
import '../../../user/data/models/user_model.dart';
import '../../domain/usecases/get_current_session.dart';
import '../../domain/usecases/google_sign_in.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  final SignUp signUp;
  final GoogleSignIn googleSignIn;
  final SignOut signOut;
  final GetCurrentSession getCurrentSession;
  final ResetPassword resetPassword;
  late final StreamSubscription _authSub;

  AuthBloc({
    required this.signIn,
    required this.signUp,
    required this.googleSignIn,
    required this.signOut,
    required this.getCurrentSession,
    required this.resetPassword,
  }) : super(AuthInitialState()) {
    _authSub = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final supaUser = data.session?.user;

      final user = supaUser != null
          ? UserModel.fromSupabaseUser(supaUser)
          : null;

      add(AuthStateChanged(user));
    });

    on<AppStarted>((event, emit) async {
      emit(AuthLoading());

      final session = await getCurrentSession();
      if (session != null) {
        emit(AuthenticatedState(session.user));
      } else {
        emit(UnauthenticatedState());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final session = await signIn(
          email: event.email,
          password: event.password,
          rememberMe: event.rememberMe,
        );
        print('SESSION --> ${Supabase.instance.client.auth.currentSession}');
        emit(AuthenticatedState(session.user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await signUp(
          email: event.email,
          password: event.password,
          name: event.name,
        );
        emit(RegisterSuccess());
        emit(UnauthenticatedState());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<GoogleLoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await googleSignIn();
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await resetPassword(email: event.email);
        emit(PasswordResetEmailSentState());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      await signOut();
      emit(UnauthenticatedState());
    });

    on<AuthStateChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthenticatedState(event.user!));
      } else {
        emit(UnauthenticatedState());
      }
    });
  }
  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }
}
