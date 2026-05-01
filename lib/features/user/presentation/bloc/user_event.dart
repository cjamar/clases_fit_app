import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class CheckUserExistEvent extends UserEvent {
  final String userId;
  const CheckUserExistEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class CreateUserEvent extends UserEvent {
  final User user;
  const CreateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}
