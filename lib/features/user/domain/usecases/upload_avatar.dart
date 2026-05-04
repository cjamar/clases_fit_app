import 'package:image_picker/image_picker.dart';
import '../repositories/user_repository.dart';

class UploadAvatar {
  final UserRepository repository;
  UploadAvatar(this.repository);

  Future<String?> call(ImageSource source) async =>
      await repository.uploadAvatar(source);
}
