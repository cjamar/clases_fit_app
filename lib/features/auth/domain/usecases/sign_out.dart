import 'package:clases_fit_app/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository repository;
  SignOut(this.repository);
  Future<void> call() => repository.signOut();
}
