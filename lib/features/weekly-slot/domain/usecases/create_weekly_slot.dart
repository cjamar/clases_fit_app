import '../entities/weekly_slot.dart';
import '../repositories/weeky_slot_repository.dart';

class CreateWeeklySlot {
  final WeeklySlotRepository repository;
  CreateWeeklySlot(this.repository);

  Future<void> call(WeeklySlot weeklySlot) async =>
      await repository.createWeeklySlot(weeklySlot);
}
