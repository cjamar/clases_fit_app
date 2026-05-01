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
}
