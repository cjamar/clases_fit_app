import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromSupabaseUser(dynamic user) => UserModel(
    id: user.id,
    email: user.email ?? '',
    name: user.userMetadata?['name'] ?? '',
  );
}
