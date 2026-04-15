import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class GetCurrentSession {
  final AuthRepository repository;
  GetCurrentSession(this.repository);

  Future<AuthSession?> call() => repository.getCurrentSession();
}
