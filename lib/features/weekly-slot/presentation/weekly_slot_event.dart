import 'package:equatable/equatable.dart';
import '../domain/entities/weekly_slot.dart';

abstract class WeeklySlotEvent extends Equatable {
  const WeeklySlotEvent();

  @override
  List<Object?> get props => [];
}

class LoadWeeklySlotsEvent extends WeeklySlotEvent {
  final String scheduleId;
  const LoadWeeklySlotsEvent(this.scheduleId);

  @override
  List<Object?> get props => [scheduleId];
}

class CreateWeeklySlotsEvent extends WeeklySlotEvent {
  final WeeklySlot weeklySlot;
  const CreateWeeklySlotsEvent(this.weeklySlot);

  @override
  List<Object?> get props => [weeklySlot];
}

class UpdateWeeklySlotsEvent extends WeeklySlotEvent {
  final WeeklySlot weeklySlot;
  const UpdateWeeklySlotsEvent(this.weeklySlot);

  @override
  List<Object?> get props => [weeklySlot];
}

class DeleteWeeklySlotsEvent extends WeeklySlotEvent {
  final String weeklySlotId;
  const DeleteWeeklySlotsEvent(this.weeklySlotId);

  @override
  List<Object?> get props => [weeklySlotId];
}
