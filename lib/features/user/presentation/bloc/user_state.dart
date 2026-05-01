import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserExistState extends UserState {
  final User user;
  const UserExistState(this.user);

  @override
  List<Object?> get props => [user];
}

class UserNotFoundState extends UserState {}

class UserCreatedState extends UserState {}

class UserErrorState extends UserState {
  final String message;
  const UserErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
