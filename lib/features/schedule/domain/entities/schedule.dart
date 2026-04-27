import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String id;
  final String instructorId;
  final String name;
  final DateTime createdAt;

  const Schedule({
    required this.id,
    required this.instructorId,
    required this.name,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, instructorId, name, createdAt];
}
