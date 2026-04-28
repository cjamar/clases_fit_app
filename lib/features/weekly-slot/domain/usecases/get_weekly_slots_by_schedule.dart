import '../entities/weekly_slot.dart';
import '../repositories/weeky_slot_repository.dart';

class GetWeeklySlotsBySchedule {
  final WeeklySlotRepository repository;
  GetWeeklySlotsBySchedule(this.repository);

  Future<List<WeeklySlot>> call(String scheduleId) async =>
      await repository.getWeeklySlotsBySchedule(scheduleId);
}
