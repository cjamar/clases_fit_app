import '../models/weekly_slot_model.dart';

abstract class WeeklySlotDatasource {
  Future<List<WeeklySlotModel>> getWeeklySlotsBySchedule(String scheduleId);
  Future<void> createWeeklySlot(WeeklySlotModel weeklySlot);
  Future<void> updateWeeklySlot(WeeklySlotModel weeklySlot);
  Future<void> deleteWeeklySlot(String weeklySlotId);
}
