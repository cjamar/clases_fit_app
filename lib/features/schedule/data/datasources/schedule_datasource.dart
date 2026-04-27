import '../models/schedule_model.dart';

abstract class ScheduleDatasource {
  Future<List<ScheduleModel>> getClassTemplatesByInstructor(
    String instructorId,
  );
  Future<void> createSchedule(ScheduleModel schedule);
  Future<void> updateSchedule(ScheduleModel schedule);
  Future<void> deleteSchedule(String scheduleId);
}
