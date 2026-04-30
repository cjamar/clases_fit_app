import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_schedule.dart';
import '../../domain/usecases/delete_schedule.dart';
import '../../domain/usecases/get_schedules_by_instructor.dart';
import '../../domain/usecases/update_schedule.dart';
import 'schedule_event.dart';
import 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetSchedulesByInstructor getSchedulesByInstructor;
  final CreateSchedule createSchedule;
  final UpdateSchedule updateSchedule;
  final DeleteSchedule deleteSchedule;

  ScheduleBloc({
    required this.getSchedulesByInstructor,
    required this.createSchedule,
    required this.updateSchedule,
    required this.deleteSchedule,
  }) : super(ScheduleInitial()) {
    on<LoadSchedulesEvent>((event, emit) async {
      emit(ScheduleLoading());
      try {
        final schedules = await getSchedulesByInstructor(event.instructorId);
        emit(ScheduleLoaded(schedules, event.instructorId));
      } catch (e) {
        emit(ScheduleError(e.toString()));
      }
    });

    on<CreateScheduleEvent>((event, emit) async {
      emit(ScheduleLoading());
      print('<<<<<<<< ON CREATE SCHEDULE EVENT BLOC >>>>>>>>');
      try {
        await createSchedule(event.schedule);
        await _reloadSchedules(emit, event.schedule.instructorId);
      } catch (e) {
        emit(ScheduleError(e.toString()));
      }
    });

    on<UpdateScheduleEvent>((event, emit) async {
      emit(ScheduleLoading());
      try {
        await updateSchedule(event.schedule);
        await _reloadSchedules(emit, event.schedule.instructorId);
      } catch (e) {
        emit(ScheduleError(e.toString()));
      }
    });

    on<DeleteScheduleEvent>((event, emit) async {
      emit(ScheduleLoading());
      try {
        await deleteSchedule(event.scheduleId);
        await _reloadSchedules(emit, event.instructorId);
      } catch (e) {
        emit(ScheduleError(e.toString()));
      }
    });
  }

  Future<void> _reloadSchedules(
    Emitter<ScheduleState> emit,
    String instructorId,
  ) async {
    final schedules = await getSchedulesByInstructor(instructorId);
    emit(ScheduleLoaded(schedules, instructorId));
  }
}
