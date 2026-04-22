import '../repositories/auth_repository.dart';

class UpdatePassword {
  final AuthRepository repository;
  UpdatePassword(this.repository);

  Future<void> call({required String newPassword}) =>
      repository.updatePassword(newPassword);
}
