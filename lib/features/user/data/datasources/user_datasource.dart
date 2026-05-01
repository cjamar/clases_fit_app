import '../models/user_model.dart';

abstract class UserDatasource {
  Future<UserModel?> getUserById(String userId);
  Future<void> createUser(UserModel user);
}
