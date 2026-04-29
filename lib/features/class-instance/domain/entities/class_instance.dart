import 'package:equatable/equatable.dart';
import 'class_status.dart';

class ClassInstance extends Equatable {
  final String id;
  final String scheduleId;
  final String classTemplateId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int minCapacity;
  final int maxCapacity;
  final int currentBookings;
  final ClassStatus status;
  final DateTime createdAt;

  const ClassInstance({
    required this.id,
    required this.scheduleId,
    required this.classTemplateId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.minCapacity,
    required this.maxCapacity,
    required this.currentBookings,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    scheduleId,
    classTemplateId,
    date,
    startTime,
    endTime,
    minCapacity,
    maxCapacity,
    currentBookings,
    status,
    createdAt,
  ];
}


// TODO: ACTUALIZAR EN SUPABASE
// id
// schedule_id
// class_template_id
// date
// start_time
// end_time
// min_capacity
// max_capacity
// current_bookings
// status
// created_at