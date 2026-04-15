import '../repositories/auth_repository.dart';

class ResetPassword {
  final AuthRepository repository;
  ResetPassword(this.repository);

  Future<void> call(String email) => repository.resetPassword(email);
}
