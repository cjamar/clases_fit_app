import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;
  UserRepositoryImpl(this.datasource);

  @override
  Future<User?> getUserById(String userId) async =>
      await datasource.getUserById(userId);

  @override
  Future<void> createUser(User user) async {
    UserModel userModel = UserModel.fromEntity(user);
    await datasource.createUser(userModel);
  }
}
