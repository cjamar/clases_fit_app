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
  Future<void> insertClassInstances(List<ClassInstance> instances) async {
    final models = instances
        .map((e) => ClassInstanceModel.fromEntity(e))
        .toList();
    final jsonList = models.map((e) => e.toJson()).toList();

    if (jsonList.isNotEmpty) await datasource.insertClassInstances(jsonList);
  }

  @override
  Future<List<ClassInstance>> getClassInstancesByWeek(
    String scheduleId,
    DateTime weekStart,
    DateTime weekEnd,
  ) async {
    final result = await datasource.getClassInstancesByWeek(
      scheduleId,
      weekStart,
      weekEnd,
    );
    final resultToReturn = result.map((e) => e.toEntity()).toList();
    return resultToReturn;
  }
}
