import '../entities/class_instance.dart';
import '../entities/class_status.dart';

class ClassInstanceGeneratorService {
  List<ClassInstance> generate({
    required List<dynamic> weeklySlots,
    required String scheduleId,
    required DateTime weekStart,
    required DateTime weekEnd,
  }) {
    final List<ClassInstance> classInstanceToInsert = [];

    for (final ws in weeklySlots) {
      final int dayOfWeek = ws['day_of_week'];
      DateTime currentTime = weekStart;

      while (currentTime.isBefore(weekEnd) ||
          currentTime.isAtSameMomentAs(weekEnd)) {
        if (currentTime.weekday == dayOfWeek) {
          _buildInstance(scheduleId, classInstanceToInsert, ws, currentTime);
        }
        currentTime = currentTime.add(const Duration(days: 1));
      }
    }
    return classInstanceToInsert;
  }

  void _buildInstance(
    String scheduleId,
    List<ClassInstance> classInstanceToInsert,
    dynamic ws,
    DateTime currentTime,
  ) => classInstanceToInsert.add(
    ClassInstance(
      id: '', // temporal (lo genera DB)
      scheduleId: ws.scheduleId,
      classTemplateId: ws.classTemplateId,
      weeklySlotId: ws.id,
      date: currentTime,
      startTime: ws.startTime,
      endTime: ws.endTime,
      minCapacity: ws.minCapacity,
      maxCapacity: ws.maxCapacity,
      currentBookings: 0,
      status: ClassStatus.available,
      createdAt: DateTime.now(),
    ),
  );
}
