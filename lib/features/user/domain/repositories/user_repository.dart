import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> getUserById(String userId);
  Future<void> createUser(User user);
}
