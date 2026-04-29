import '../../domain/entities/weekly_slot.dart';
import '../../domain/repositories/weeky_slot_repository.dart';
import '../datasources/weekly_slot_datasource.dart';
import '../models/weekly_slot_model.dart';

class WeeklySlotRepositoryImpl extends WeeklySlotRepository {
  final WeeklySlotDatasource weeklySlotDatasource;
  WeeklySlotRepositoryImpl(this.weeklySlotDatasource);

  @override
  Future<List<WeeklySlot>> getWeeklySlotsBySchedule(String scheduleId) async =>
      await weeklySlotDatasource.getWeeklySlotsBySchedule(scheduleId);

  @override
  Future<void> createWeeklySlot(WeeklySlot weeklySlot) async {
    final weeklySlotModel = WeeklySlotModel.fromEntity(weeklySlot);
    await weeklySlotDatasource.createWeeklySlot(weeklySlotModel);
  }

  @override
  Future<void> updateWeeklySlot(WeeklySlot weeklySlot) async {
    final weeklySlotModel = WeeklySlotModel.fromEntity(weeklySlot);
    await weeklySlotDatasource.updateWeeklySlot(weeklySlotModel);
  }

  @override
  Future<void> deleteWeeklySlot(String weeklySlotId) async =>
      await weeklySlotDatasource.deleteWeeklySlot(weeklySlotId);
}
