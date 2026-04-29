import '../entities/class_instance.dart';
import '../repositories/class_instance_repository.dart';

class GenerateWeekClassInstances {
  final ClassInstanceRepository repository;
  GenerateWeekClassInstances(this.repository);

  Future<List<ClassInstance>> call({
    required String scheduleId,
    required DateTime weekStart,
    required DateTime weekEnd,
  }) async => await repository.generateWeekClassInstances(
    scheduleId,
    weekStart,
    weekEnd,
  );
}
