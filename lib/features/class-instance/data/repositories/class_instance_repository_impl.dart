import '../../domain/entities/class_instance.dart';
import '../../domain/repositories/class_instance_repository.dart';
import '../datasources/class_instance_datasource.dart';
import '../models/class_instance_model.dart';

class ClassInstanceRepositoryImpl implements ClassInstanceRepository {
  final ClassInstanceDatasource datasource;
  ClassInstanceRepositoryImpl(this.datasource);

  @override
  Future<List<ClassInstance>> getClassInstance(
    String scheduleId,
    DateTime startTime,
    DateTime endTime,
  ) async => await datasource.getClassInstance(scheduleId, startTime, endTime);

  @override
  Future<void> createClassInstance(ClassInstance classInstance) async {
    final classInstanceModel = ClassInstanceModel.fromEntity(classInstance);
    await datasource.createClassInstance(classInstanceModel);
  }

  @override
  Future<void> updateClassInstance(ClassInstance classInstance) async {
    final classInstanceModel = ClassInstanceModel.fromEntity(classInstance);
    await datasource.updateClassInstance(classInstanceModel);
  }

  @override
  Future<void> deleteClassInstance(String classInstanceId) async =>
      await datasource.deleteClassInstance(classInstanceId);

  @override
  Future<List<ClassInstance>> generateWeekClassInstances(
    String scheduleId,
    DateTime weekStart,
    DateTime weekEnd,
  ) async => await datasource.generateWeekClassInstances(
    scheduleId,
    weekStart,
    weekEnd,
  );
}
