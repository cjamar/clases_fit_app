import '../entities/schedule.dart';

abstract class ScheduleRepository {
  Future<List<Schedule>> getSchedulesByInstructor(String instructorId);
  Future<void> createSchedule(Schedule schedule);
  Future<void> updateSchedule(Schedule schedule);
  Future<void> deleteSchedule(String scheduleId);
}
