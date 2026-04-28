import '../repositories/weeky_slot_repository.dart';

class DeleteWeeklySlot {
  final WeeklySlotRepository repository;
  DeleteWeeklySlot(this.repository);

  Future<void> call(String weeklySlotId) async =>
      repository.deleteWeeklySlot(weeklySlotId);
}
