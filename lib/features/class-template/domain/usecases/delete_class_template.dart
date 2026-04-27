import '../repositories/class_template_repository.dart';

class DeleteClassTemplate {
  final ClassTemplateRepository repository;
  DeleteClassTemplate(this.repository);

  Future<void> call(String classTemplateId) async =>
      repository.deleteClassTemplate(classTemplateId);
}
