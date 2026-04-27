import '../models/class_template_model.dart';

abstract class ClassTemplateDatasource {
  Future<List<ClassTemplateModel>> getClassTemplatesByInstructor(
    String instructorId,
  );
  Future<void> createClassTemplate(ClassTemplateModel classTemplate);
  Future<void> updateClassTemplate(ClassTemplateModel classTemplate);
  Future<void> deleteClassTemplate(String classTemplateId);
}
