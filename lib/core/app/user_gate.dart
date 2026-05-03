import 'package:clases_fit_app/core/theme/styles_app.dart';
import 'package:clases_fit_app/features/home/presentation/pages/home_page.dart';
import 'package:clases_fit_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:clases_fit_app/features/user/presentation/bloc/user_event.dart';
import 'package:clases_fit_app/features/user/presentation/pages/complete_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/user/presentation/bloc/user_state.dart';

class UserGate extends StatefulWidget {
  const UserGate({super.key});

  @override
  State<UserGate> createState() => _UserGateState();
}

class _UserGateState extends State<UserGate> {
  @override
  void initState() {
    super.initState();
    final userId = Supabase.instance.client.auth.currentUser!.id;
    context.read<UserBloc>().add(CheckUserExistEvent(userId));
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      if (state is UserLoadingState || state is UserInitialState) {
        return _loader();
      }
      if (state is UserNotFoundState) {
        return const CompleteProfilePage();
      }
      if (state is UserExistState) {
        return const HomePage();
      }
      if (state is UserErrorState) {
        return _errorContainer(state.message);
      }
      return _loader();
    },
  );

  _loader() => Scaffold(body: Center(child: CircularProgressIndicator()));

  _errorContainer(String message) => Scaffold(
    body: Center(
      child: Column(
        children: [
          Icon(Icons.error, color: StylesApp.alertColor, size: 40),
          SizedBox(height: 10),
          Text('Error, $message', textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
