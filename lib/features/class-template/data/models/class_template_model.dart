import 'package:clases_fit_app/features/class-template/domain/entities/class_template.dart';

class ClassTemplateModel extends ClassTemplate {
  ClassTemplateModel({
    required super.id,
    required super.instructorId,
    required super.name,
    super.description,
    required super.durationMinutes,
    required super.minCapacity,
    required super.maxCapacity,
    required super.createdAt,
  });

  factory ClassTemplateModel.fromJson(Map<String, dynamic> json) =>
      ClassTemplateModel(
        id: json['id'],
        instructorId: json['instructor_id'],
        name: json['name'],
        description: json['description'],
        durationMinutes: json['duration_minutes'],
        minCapacity: json['min_capacity'],
        maxCapacity: json['max_capacity'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'instructor_id': instructorId,
    'name': name,
    'description': description,
    'duration_minutes': durationMinutes,
    'min_capacity': minCapacity,
    'max_capacity': maxCapacity,
    'created_at': createdAt,
  };
}
