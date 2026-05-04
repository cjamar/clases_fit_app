import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';

abstract class UserDatasource {
  Future<UserModel?> getUserById(String userId);
  Future<void> createUser(UserModel user);
  Future<String?> uploadAvatar(ImageSource source);
}
