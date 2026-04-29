import '../entities/class_instance.dart';

abstract class ClassInstanceRepository {
  Future<List<ClassInstance>> getClassInstance(
    String scheduleId,
    DateTime startTime,
    DateTime endTime,
  );
  Future<void> createClassInstance(ClassInstance classInstance);
  Future<void> updateClassInstance(ClassInstance classInstance);
  Future<void> deleteClassInstance(String classInstanceId);
  Future<List<ClassInstance>> getClassInstancesByWeek(
    String scheduleId,
    DateTime weekStart,
    DateTime weekEnd,
  );
  Future<void> insertClassInstances(List<ClassInstance> instances);
}
