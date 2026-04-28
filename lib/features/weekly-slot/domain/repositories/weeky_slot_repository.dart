import '../entities/weekly_slot.dart';

abstract class WeeklySlotRepository {
  Future<List<WeeklySlot>> getWeeklySlotsBySchedule(String scheduleId);
  Future<void> createWeeklySlot(WeeklySlot weeklySlot);
  Future<void> updateWeeklySlot(WeeklySlot weeklySlot);
  Future<void> deleteWeeklySlot(String weeklySlotId);
}
