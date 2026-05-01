import 'package:clases_fit_app/features/user/domain/entities/user_role.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String? avatarUrl;
  final UserRole role;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.avatarUrl,
    required this.role,
  });

  @override
  List<Object?> get props => [id, email, name, phone, avatarUrl, role];
}
