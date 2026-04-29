import '../entities/class_instance.dart';
import '../repositories/class_instance_repository.dart';

class GetClassInstances {
  final ClassInstanceRepository repository;
  GetClassInstances(this.repository);

  Future<List<ClassInstance>> call({
    required String scheduleId,
    required DateTime startTime,
    required DateTime endTime,
  }) async =>
      await repository.getClassInstances(scheduleId, startTime, endTime);
}
