import 'package:clases_fit_app/features/schedule/domain/entities/schedule.dart';
import 'package:equatable/equatable.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

class LoadSchedules extends ScheduleEvent {
  final String instructorId;
  const LoadSchedules(this.instructorId);

  @override
  List<Object?> get props => [instructorId];
}

class CreateScheduleEvent extends ScheduleEvent {
  final Schedule schedule;
  const CreateScheduleEvent(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class UpdateScheduleEvent extends ScheduleEvent {
  final Schedule schedule;
  const UpdateScheduleEvent(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class DeleteScheduleEvent extends ScheduleEvent {
  final String scheduleId;
  final String instructorId;

  const DeleteScheduleEvent(this.scheduleId, this.instructorId);

  @override
  List<Object?> get props => [scheduleId, instructorId];
}
