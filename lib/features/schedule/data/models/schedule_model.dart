import '../../domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  const ScheduleModel({
    required super.id,
    required super.instructorId,
    required super.name,
    required super.createdAt,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    id: json['id'],
    instructorId: json['instructor_id'],
    name: json['name'],
    createdAt: DateTime.parse(json['created_at']),
  );

  Map<String, dynamic> toJson() => {
    if (id.isNotEmpty) 'id': id,
    'instructor_id': instructorId,
    'name': name,
    'created_at': createdAt.toIso8601String(),
  };

  factory ScheduleModel.fromEntity(Schedule entity) => ScheduleModel(
    id: entity.id,
    instructorId: entity.instructorId,
    name: entity.name,
    createdAt: entity.createdAt,
  );
}
