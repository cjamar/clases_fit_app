import '../../../user/domain/entities/user.dart';

class AuthSession {
  final User user;
  final bool rememberMe;

  const AuthSession({required this.user, required this.rememberMe});
}
