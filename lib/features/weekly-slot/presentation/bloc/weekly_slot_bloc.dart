import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_weekly_slot.dart';
import '../../domain/usecases/delete_weekly_slot.dart';
import '../../domain/usecases/get_weekly_slots_by_schedule.dart';
import '../../domain/usecases/update_weekly_slot.dart';
import '../weekly_slot_event.dart';
import 'weekly_slot_state.dart';

class WeeklySlotBloc extends Bloc<WeeklySlotEvent, WeeklySlotState> {
  final GetWeeklySlotsBySchedule getWeeklySlotsBySchedule;
  final CreateWeeklySlot createWeeklySlots;
  final UpdateWeeklySlot updateWeeklySlots;
  final DeleteWeeklySlot deleteWeeklySlots;

  WeeklySlotBloc({
    required this.getWeeklySlotsBySchedule,
    required this.createWeeklySlots,
    required this.updateWeeklySlots,
    required this.deleteWeeklySlots,
  }) : super(WeeklySlotInitial()) {
    on<LoadWeeklySlotsEvent>((event, emit) async {
      emit(WeeklySlotLoading());
      await _reloadWeeklySlots(emit, event.scheduleId);
      try {} catch (e) {
        emit(WeeklySlotError(e.toString()));
      }
    });

    on<CreateWeeklySlotsEvent>((event, emit) async {
      emit(WeeklySlotLoading());
      try {
        await createWeeklySlots(event.weeklySlot);
        await _reloadWeeklySlots(emit, event.weeklySlot.scheduleId);
      } catch (e) {
        emit(WeeklySlotError(e.toString()));
      }
    });

    on<UpdateWeeklySlotsEvent>((event, emit) async {
      emit(WeeklySlotLoading());
      try {
        await updateWeeklySlots(event.weeklySlot);
        await _reloadWeeklySlots(emit, event.weeklySlot.scheduleId);
      } catch (e) {
        emit(WeeklySlotError(e.toString()));
      }
    });

    on<DeleteWeeklySlotsEvent>((event, emit) async {
      emit(WeeklySlotLoading());
      try {
        await deleteWeeklySlots(event.weeklySlotId);
        await _reloadWeeklySlots(emit, event.weeklySlotId);
      } catch (e) {
        emit(WeeklySlotError(e.toString()));
      }
    });
  }

  _reloadWeeklySlots(Emitter<WeeklySlotState> emit, String scheduleId) async {
    final weeklySlots = await getWeeklySlotsBySchedule(scheduleId);
    emit(WeeklySlotLoaded(weeklySlots, scheduleId));
  }
}
