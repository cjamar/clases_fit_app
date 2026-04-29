import '../repositories/class_instance_repository.dart';

class DeleteClassInstance {
  final ClassInstanceRepository repository;
  DeleteClassInstance(this.repository);

  Future<void> call(String classInstanceId) async =>
      await repository.deleteClassInstance(classInstanceId);
}
