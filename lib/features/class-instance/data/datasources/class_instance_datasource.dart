import '../models/class_instance_model.dart';

abstract class ClassInstanceDatasource {
  Future<List<ClassInstanceModel>> getClassInstance(
    String scheduleId,
    DateTime startTime,
    DateTime endTime,
  );
  Future<void> createClassInstance(ClassInstanceModel classInstanceModel);
  Future<void> updateClassInstance(ClassInstanceModel classInstanceModel);
  Future<void> deleteClassInstance(String classInstanceId);

  Future<List<ClassInstanceModel>> getClassInstancesByWeek(
    String scheduleId,
    DateTime weekStart,
    DateTime weekEnd,
  );
  Future<void> insertClassInstances(List<Map<String, dynamic>> jsonList);
}
