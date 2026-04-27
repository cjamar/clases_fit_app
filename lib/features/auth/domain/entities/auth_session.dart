import 'package:equatable/equatable.dart';
import '../../../user/domain/entities/user.dart';

class AuthSession extends Equatable {
  final User user;
  final bool rememberMe;

  const AuthSession({required this.user, required this.rememberMe});

  @override
  List<Object?> get props => [user, rememberMe];
}
