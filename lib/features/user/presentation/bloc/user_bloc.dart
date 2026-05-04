import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_user_by_id.dart';
import '../../domain/usecases/upload_avatar.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserById getUserById;
  final CreateUser createUser;
  final UploadAvatar uploadAvatar;

  UserBloc({
    required this.getUserById,
    required this.createUser,
    required this.uploadAvatar,
  }) : super(UserInitialState()) {
    on<CheckUserExistEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final user = await getUserById(event.userId);
        if (user == null) {
          emit(UserNotFoundState());
        } else {
          emit(UserExistState(user));
        }
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<CreateUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        await createUser(event.user);
        emit(UserCreatedState());
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<UploadAvatarEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final url = await uploadAvatar(event.source);

        if (url == null) {
          emit(UserErrorState('No se seleccionó ninguna imagen'));
          return;
        }
        emit(UserAvatarUploadedState(url));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
