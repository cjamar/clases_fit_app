import '../entities/weekly_slot.dart';
import '../repositories/weeky_slot_repository.dart';

class UpdateWeeklySlot {
  final WeeklySlotRepository repository;
  UpdateWeeklySlot(this.repository);

  Future<void> call(WeeklySlot weeklySlot) async =>
      repository.updateWeeklySlot(weeklySlot);
}
