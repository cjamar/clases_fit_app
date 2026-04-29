import '../../domain/entities/class_instance.dart';

class ClassInstanceModel extends ClassInstance {
  const ClassInstanceModel({
    required super.id,
    required super.scheduleId,
    required super.classTemplateId,
    required super.weeklySlotId,
    required super.date,
    required super.startTime,
    required super.endTime,
    required super.minCapacity,
    required super.maxCapacity,
    required super.currentBookings,
    required super.status,
    required super.createdAt,
  });

  factory ClassInstanceModel.fromJson(Map<String, dynamic> json) =>
      ClassInstanceModel(
        id: json['id'],
        scheduleId: json['schedule_id'],
        classTemplateId: json['class_template_id'],
        weeklySlotId: json['weekly_slot_id'],
        date: json['date'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        minCapacity: json['min_capacity'],
        maxCapacity: json['max_capacity'],
        currentBookings: json['current_bookings'],
        status: json['status'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'schedule_id': scheduleId,
    'class_template_id': classTemplateId,
    'weekly_slot_id': weeklySlotId,
    'date': date.toIso8601String(),
    'start_time': startTime,
    'end_time': endTime,
    'min_capacity': minCapacity,
    'max_capacity': maxCapacity,
    'current_bookings': currentBookings,
    'status': status.name,
    'created_at': createdAt.toIso8601String(),
  };

  factory ClassInstanceModel.fromEntity(ClassInstance entity) =>
      ClassInstanceModel(
        id: entity.id,
        scheduleId: entity.scheduleId,
        classTemplateId: entity.classTemplateId,
        weeklySlotId: entity.weeklySlotId,
        date: entity.date,
        startTime: entity.startTime,
        endTime: entity.endTime,
        minCapacity: entity.minCapacity,
        maxCapacity: entity.maxCapacity,
        currentBookings: entity.currentBookings,
        status: entity.status,
        createdAt: entity.createdAt,
      );
}
