import 'package:clases_fit_app/core/app/auth_gate.dart';
import 'package:clases_fit_app/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:clases_fit_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clases_fit_app/features/auth/domain/usecases/get_current_session.dart';
import 'package:clases_fit_app/features/auth/domain/usecases/google_sign_in.dart';
import 'package:clases_fit_app/features/auth/domain/usecases/sign_in.dart';
import 'package:clases_fit_app/features/auth/domain/usecases/sign_out.dart';
import 'package:clases_fit_app/features/auth/domain/usecases/sign_up.dart';
import 'package:clases_fit_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: 'MY_URL', anonKey: 'MY_KEY');
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
          ),
        ),
      ],
      child: MaterialApp(home: const AuthGate()),
    );
  }
}
