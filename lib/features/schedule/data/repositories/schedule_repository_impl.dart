import 'package:clases_fit_app/features/schedule/data/datasources/schedule_datasource.dart';
import 'package:clases_fit_app/features/schedule/data/models/schedule_model.dart';

import '../../domain/entities/schedule.dart';
import '../../domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleDatasource datasource;
  ScheduleRepositoryImpl(this.datasource);

  @override
  Future<List<Schedule>> getSchedulesByInstructor(String instructorId) async =>
      await datasource.getClassTemplatesByInstructor(instructorId);

  @override
  Future<void> createSchedule(Schedule schedule) async {
    final scheduleModel = ScheduleModel(
      id: schedule.id,
      instructorId: schedule.instructorId,
      name: schedule.name,
      createdAt: schedule.createdAt,
    );

    await datasource.createSchedule(scheduleModel);
  }

  @override
  Future<void> updateSchedule(Schedule schedule) async {
    final scheduleModel = ScheduleModel(
      id: schedule.id,
      instructorId: schedule.instructorId,
      name: schedule.name,
      createdAt: schedule.createdAt,
    );
    await datasource.updateSchedule(scheduleModel);
  }

  @override
  Future<void> deleteSchedule(String scheduleId) async =>
      await datasource.deleteSchedule(scheduleId);
}
