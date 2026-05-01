import 'package:clases_fit_app/features/user/domain/entities/user_role.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.phone,
    super.avatarUrl,
    required super.role,
  });

  factory UserModel.fromSupabaseUser(dynamic user) => UserModel(
    id: user.id,
    email: user.email ?? '',
    name: user.userMetadata?['name'] ?? '',
    phone: '', // ⚠️ NO existe en auth
    avatarUrl: null, // ⚠️ NO existe en auth
    role: UserRole.owner, // ⚠️ valor por defecto temporal
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'],
    name: json['name'],
    phone: json['phone'],
    role: UserRole.values.firstWhere((e) => e.name == json['role']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'phone': phone,
    'avatar_url': avatarUrl,
    'role': role.name,
  };

  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    name: user.name,
    phone: user.phone,
    avatarUrl: user.avatarUrl,
    role: user.role,
  );

  User toEntity() => User(
    id: id,
    email: email,
    name: name,
    phone: phone,
    avatarUrl: avatarUrl,
    role: role,
  );
}
