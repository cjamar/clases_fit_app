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
    final classInstanceModel = ClassInstanceModel(
      id: classInstance.id,
      scheduleId: classInstance.scheduleId,
      classTemplateId: classInstance.classTemplateId,
      date: classInstance.date,
      startTime: classInstance.startTime,
      endTime: classInstance.endTime,
      minCapacity: classInstance.minCapacity,
      maxCapacity: classInstance.maxCapacity,
      currentBookings: classInstance.currentBookings,
      status: classInstance.status,
      createdAt: classInstance.createdAt,
    );
    await datasource.createClassInstance(classInstanceModel);
  }

  @override
  Future<void> updateClassInstance(ClassInstance classInstance) async {
    final classInstanceModel = ClassInstanceModel(
      id: classInstance.id,
      scheduleId: classInstance.scheduleId,
      classTemplateId: classInstance.classTemplateId,
      date: classInstance.date,
      startTime: classInstance.startTime,
      endTime: classInstance.endTime,
      minCapacity: classInstance.minCapacity,
      maxCapacity: classInstance.maxCapacity,
      currentBookings: classInstance.currentBookings,
      status: classInstance.status,
      createdAt: classInstance.createdAt,
    );
    await datasource.updateClassInstance(classInstanceModel);
  }

  @override
  Future<void> deleteClassInstance(String classInstanceId) async =>
      await datasource.deleteClassInstance(classInstanceId);
}
