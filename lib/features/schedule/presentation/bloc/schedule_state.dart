import 'package:clases_fit_app/features/schedule/domain/entities/schedule.dart';
import 'package:equatable/equatable.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<Schedule> scheduleList;
  final String instructorId;
  const ScheduleLoaded(this.scheduleList, this.instructorId);

  @override
  List<Object?> get props => [scheduleList, instructorId];
}

class ScheduleError extends ScheduleState {
  final String message;
  const ScheduleError(this.message);

  @override
  List<Object?> get props => [message];
}
