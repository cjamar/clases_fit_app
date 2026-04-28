import 'package:clases_fit_app/features/weekly-slot/data/models/weekly_slot_model.dart';

import '../../domain/entities/weekly_slot.dart';
import '../../domain/repositories/weeky_slot_repository.dart';
import '../datasources/weekly_slot_datasource.dart';

class WeeklySlotRepositoryImpl extends WeeklySlotRepository {
  final WeeklySlotDatasource weeklySlotDatasource;
  WeeklySlotRepositoryImpl(this.weeklySlotDatasource);

  @override
  Future<List<WeeklySlot>> getWeeklySlotsBySchedule(String scheduleId) async =>
      await weeklySlotDatasource.getWeeklySlotsBySchedule(scheduleId);

  @override
  Future<void> createWeeklySlot(WeeklySlot weeklySlot) async {
    final weeklySlotModel = WeeklySlotModel(
      id: weeklySlot.id,
      scheduleId: weeklySlot.scheduleId,
      classTemplateId: weeklySlot.classTemplateId,
      dayOfWeek: weeklySlot.dayOfWeek,
      startTime: weeklySlot.startTime,
      endTime: weeklySlot.endTime,
      isActive: weeklySlot.isActive,
      createdAt: weeklySlot.createdAt,
    );
    await weeklySlotDatasource.createWeeklySlot(weeklySlotModel);
  }

  @override
  Future<void> updateWeeklySlot(WeeklySlot weeklySlot) async {
    final weeklySlotModel = WeeklySlotModel(
      id: weeklySlot.id,
      scheduleId: weeklySlot.scheduleId,
      classTemplateId: weeklySlot.classTemplateId,
      dayOfWeek: weeklySlot.dayOfWeek,
      startTime: weeklySlot.startTime,
      endTime: weeklySlot.endTime,
      isActive: weeklySlot.isActive,
      createdAt: weeklySlot.createdAt,
    );
    await weeklySlotDatasource.updateWeeklySlot(weeklySlotModel);
  }

  @override
  Future<void> deleteWeeklySlot(String weeklySlotId) async =>
      await weeklySlotDatasource.deleteWeeklySlot(weeklySlotId);
}
