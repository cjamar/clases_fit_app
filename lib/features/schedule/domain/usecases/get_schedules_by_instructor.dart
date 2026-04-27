import '../entities/schedule.dart';
import '../repositories/schedule_repository.dart';

class GetSchedulesByInstructor {
  final ScheduleRepository repository;
  GetSchedulesByInstructor(this.repository);

  Future<List<Schedule>> call(String instructorId) async =>
      await repository.getSchedulesByInstructor(instructorId);
}
