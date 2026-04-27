import '../entities/class_template.dart';
import '../repositories/class_template_repository.dart';

class CreateClassTemplate {
  final ClassTemplateRepository repository;
  CreateClassTemplate(this.repository);

  Future<void> call(ClassTemplate classTemplate) async =>
      await repository.createClassTemplate(classTemplate);
}
