import '../entities/schedule.dart';
import '../repositories/schedule_repository.dart';

class CreateSchedule {
  final ScheduleRepository repository;
  CreateSchedule(this.repository);

  Future<void> call(Schedule schedule) async =>
      await repository.createSchedule(schedule);
}
