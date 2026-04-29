import '../entities/class_instance.dart';
import '../repositories/class_instance_repository.dart';

class UpdateClassInstance {
  final ClassInstanceRepository repository;
  UpdateClassInstance(this.repository);

  Future<void> call(ClassInstance classInstance) async =>
      await repository.updateClassInstance(classInstance);
}
