import '../entities/class_instance.dart';
import '../repositories/class_instance_repository.dart';

class CreateClassInstance {
  final ClassInstanceRepository repository;
  CreateClassInstance(this.repository);

  Future<void> call(ClassInstance classInstance) async =>
      await repository.createClassInstance(classInstance);
}
