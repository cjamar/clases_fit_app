import 'package:clases_fit_app/features/class-instance/domain/usecases/generate_week_class_instances.dart';

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
  Future<List<ClassInstanceModel>> generateWeekClassInstances(
    String scheduleId,
    DateTime weekStart,
    DateTime weekEnd,
  );
}
