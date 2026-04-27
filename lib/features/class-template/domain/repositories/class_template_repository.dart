import '../entities/class_template.dart';

abstract class ClassTemplateRepository {
  Future<List<ClassTemplate>> getClassTemplatesByInstructor(
    String instructorId,
  );
  Future<void> createClassTemplate(ClassTemplate classTemplate);
  Future<void> updateClassTemplate(ClassTemplate classTemplate);
  Future<void> deleteClassTemplate(String classTemplateId);
}
