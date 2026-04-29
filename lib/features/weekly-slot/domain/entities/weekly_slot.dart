import 'package:equatable/equatable.dart';

class WeeklySlot extends Equatable {
  final String id;
  final String scheduleId;
  final String classTemplateId;
  final int dayOfWeek;
  final String startTime;
  final String endTime;
  final bool isActive;
  final DateTime createdAt;

  const WeeklySlot({
    required this.id,
    required this.scheduleId,
    required this.classTemplateId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isActive,
    required this.createdAt,
  }) : assert(
         dayOfWeek >= 1 && dayOfWeek <= 7,
         'Invalid weekday configuration',
       );

  @override
  List<Object?> get props => [
    id,
    scheduleId,
    classTemplateId,
    dayOfWeek,
    startTime,
    endTime,
    isActive,
    createdAt,
  ];
}
