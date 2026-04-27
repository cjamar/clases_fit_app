import '../entities/class_template.dart';
import '../repositories/class_template_repository.dart';

class UpdateClassTemplate {
  final ClassTemplateRepository repository;
  UpdateClassTemplate(this.repository);

  Future<void> call(ClassTemplate classTemplate) async =>
      repository.updateClassTemplate(classTemplate);
}
