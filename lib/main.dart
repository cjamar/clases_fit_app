import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/app/auth_gate.dart';
import 'features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/get_current_session.dart';
import 'features/auth/domain/usecases/google_sign_in.dart';
import 'features/auth/domain/usecases/reset_password.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://nnkzposckczjchppcbrm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ua3pwb3Nja2N6amNocHBjYnJtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY0NDIzMDksImV4cCI6MjA5MjAxODMwOX0.2znOWktXwRw3r4M7bWQcUl62jK9vX7L0nWHwzqBl4co',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late final supabase = Supabase.instance.client;

  // AUTH
  late final authRemoteDatasource = AuthRemoteDatasourceImpl(supabase);
  late final authRepository = AuthRepositoryImpl(authRemoteDatasource);

  late final signIn = SignIn(authRepository);
  late final signUp = SignUp(authRepository);
  late final googleSignIn = GoogleSignIn(authRepository);
  late final signOut = SignOut(authRepository);
  late final getCurrentSession = GetCurrentSession(authRepository);
  late final resetPassword = ResetPassword(authRepository);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            signIn: signIn,
            signUp: signUp,
            googleSignIn: googleSignIn,
            signOut: signOut,
            getCurrentSession: getCurrentSession,
            resetPassword: resetPassword,
          )..add(AppStarted()),
        ),
      ],
      child: MaterialApp(
        // theme: PENDIENTE DE DEFINIR Y COLOCAR EL THEME,
        debugShowCheckedModeBanner: false,
        home: const AuthGate(),
      ),
    );
  }
}
