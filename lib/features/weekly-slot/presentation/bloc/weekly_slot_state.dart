import 'package:equatable/equatable.dart';
import '../../domain/entities/weekly_slot.dart';

abstract class WeeklySlotState extends Equatable {
  const WeeklySlotState();

  @override
  List<Object?> get props => [];
}

class WeeklySlotInitial extends WeeklySlotState {}

class WeeklySlotLoading extends WeeklySlotState {}

class WeeklySlotLoaded extends WeeklySlotState {
  final List<WeeklySlot> weeklySlots;
  final String scheduleId;
  const WeeklySlotLoaded(this.weeklySlots, this.scheduleId);

  @override
  List<Object?> get props => [weeklySlots, scheduleId];
}

class WeeklySlotError extends WeeklySlotState {
  final String message;
  const WeeklySlotError(this.message);

  @override
  List<Object?> get props => [message];
}
