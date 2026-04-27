import 'package:equatable/equatable.dart';

class ClassTemplate extends Equatable {
  final String id;
  final String instructorId;
  final String name;
  final String? description;
  final int durationMinutes;
  final int minCapacity;
  final int maxCapacity;
  final DateTime createdAt;

  ClassTemplate({
    required this.id,
    required this.instructorId,
    required this.name,
    this.description,
    required this.durationMinutes,
    required this.minCapacity,
    required this.maxCapacity,
    required this.createdAt,
  }) {
    if (minCapacity <= 0 || maxCapacity < minCapacity) {
      throw Exception('Invalid capacity configuration');
    }
  }

  @override
  List<Object?> get props => [
    id,
    instructorId,
    name,
    description,
    durationMinutes,
    minCapacity,
    maxCapacity,
    createdAt,
  ];
}
