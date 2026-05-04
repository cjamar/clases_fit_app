import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import 'user_datasource.dart';

class UserDatasourceImpl implements UserDatasource {
  final SupabaseClient supabase;
  UserDatasourceImpl(this.supabase);

  @override
  Future<UserModel?> getUserById(String userId) async {
    final data = await supabase
        .from('users')
        .select()
        .eq('id', userId)
        .maybeSingle();
    if (data == null) return null;
    return UserModel.fromJson(data);
  }

  @override
  Future<void> createUser(UserModel user) async =>
      await supabase.from('users').insert(user.toJson());

  @override
  Future<String?> uploadAvatar(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);

    if (file == null) return null;

    final bytes = await file.readAsBytes();
    final fileExt = file.path.split('.').last;

    final fileName =
        '${supabase.auth.currentUser!.id}.${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final path = 'avatars/$fileName';

    await supabase.storage.from('avatars').uploadBinary(path, bytes);
    final publicUrl = supabase.storage.from('avatars').getPublicUrl(path);

    return publicUrl;
  }
}
