import '../../domain/entities/weekly_slot.dart';

class WeeklySlotModel extends WeeklySlot {
  const WeeklySlotModel({
    required super.id,
    required super.scheduleId,
    required super.classTemplateId,
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    required super.isActive,
    required super.createdAt,
  });

  factory WeeklySlotModel.fromJson(Map<String, dynamic> json) =>
      WeeklySlotModel(
        id: json['id'],
        scheduleId: json['schedule_id'],
        classTemplateId: json['class_template_id'],
        dayOfWeek: json['day_of_week'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        isActive: json['is_active'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'schedule_id': scheduleId,
    'class_template_id': classTemplateId,
    'day_of_week': dayOfWeek,
    'start_time': startTime,
    'end_time': endTime,
    'is_active': isActive,
    'created_at': createdAt.toIso8601String(),
  };

  factory WeeklySlotModel.fromEntity(WeeklySlot entity) => WeeklySlotModel(
    id: entity.id,
    scheduleId: entity.scheduleId,
    classTemplateId: entity.classTemplateId,
    dayOfWeek: entity.dayOfWeek,
    startTime: entity.startTime,
    endTime: entity.endTime,
    isActive: entity.isActive,
    createdAt: entity.createdAt,
  );
}
