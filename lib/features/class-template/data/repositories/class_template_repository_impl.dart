import '../../domain/entities/class_template.dart';
import '../../domain/repositories/class_template_repository.dart';
import '../datasources/class_template_datasource_impl.dart';
import '../models/class_template_model.dart';

class ClassTemplateRepositoryImpl extends ClassTemplateRepository {
  final ClassTemplateDatasourceImpl datasource;
  ClassTemplateRepositoryImpl(this.datasource);

  @override
  Future<List<ClassTemplate>> getClassTemplatesByInstructor(
    String instructorId,
  ) async => await datasource.getClassTemplatesByInstructor(instructorId);

  @override
  Future<void> createClassTemplate(ClassTemplate classTemplate) async {
    final classTemplateModel = ClassTemplateModel(
      id: classTemplate.id,
      instructorId: classTemplate.instructorId,
      name: classTemplate.name,
      description: classTemplate.description,
      durationMinutes: classTemplate.durationMinutes,
      minCapacity: classTemplate.minCapacity,
      maxCapacity: classTemplate.maxCapacity,
      createdAt: classTemplate.createdAt,
    );

    await datasource.createClassTemplate(classTemplateModel);
  }

  @override
  Future<void> updateClassTemplate(ClassTemplate classTemplate) async {
    final classTemplateModel = ClassTemplateModel(
      id: classTemplate.id,
      instructorId: classTemplate.instructorId,
      name: classTemplate.name,
      description: classTemplate.description,
      durationMinutes: classTemplate.durationMinutes,
      minCapacity: classTemplate.minCapacity,
      maxCapacity: classTemplate.maxCapacity,
      createdAt: classTemplate.createdAt,
    );
    await datasource.updateClassTemplate(classTemplateModel);
  }

  @override
  Future<void> deleteClassTemplate(String classTemplateId) async =>
      await datasource.deleteClassTemplate(classTemplateId);
}
