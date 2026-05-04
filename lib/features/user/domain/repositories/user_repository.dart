import 'package:image_picker/image_picker.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> getUserById(String userId);
  Future<void> createUser(User user);
  Future<String?> uploadAvatar(ImageSource source);
}
